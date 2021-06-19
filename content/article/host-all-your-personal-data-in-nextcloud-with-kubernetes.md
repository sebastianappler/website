+++
title = "Host all your data in Nextcloud with Kubernetes"
date = 2021-03-21
tags = ["nextcloud", "kubernetes", "guide", "open-source"]
categories = ["nextcloud"]
draft = false
author = "Sebastian Appler"
+++

If you want to be clean with your privacy the problem how to store your files will soon become a problem. Maybe you already store your data in Google with images in Google Photos and files in Google Drive. There's many services that claim to be private but the best thing is of course to host it yourself. You don't want to sacrifice convenience and maybe it's scary that it will become a big hassle to make your own hosting. No worries, Nextcloud is here to save the day!

I chose to host my instance in Kubernetes because I want to have all my services hosted in an organized way and the possibilities to move, scale and add resources as needed. And it's much cooler with a own Kubernetes cluster! I started out with a plain apache server but bear with me. You will not be disappointed to have your own cluster.

This guide will assume you have the following:

-   Kubernetes cluster
-   [Helm](https://helm.sh/)


## Storage {#storage}

First thing we are going to do is to set up the storage for Nextcloud where your data will live. It's convenient if you can reach the files in some way because Nextcloud will dump it's `config.php` in the storage. It's also possible to do with the `helm upgrade` but sometimes I just like to fiddle with the config manually.

Start by creating a namespace for your Nextcloud

```shell
kubectl create ns nextcloud
```

You need to set up a storage provisioner or persistent volume. If you just want to get something going you can use the local disk on one of your nodes.

```yaml
# pv nextcloud
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-nextcloud
  namespace: nextcloud
  labels:
    name: "nextcloud"
spec:
  capacity:
    storage: 100Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-storage
  local:
    path: /mnt/nextcloud/ # An existing folder on your node
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - node1 # The name of your node
```

Now that we have a storage we can create a pvc that will bound it. Later, when we install Nextcloud, we will reference the pvc.

```yaml
# pvc nextcloud
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-nextcloud
  namespace: nextcloud
spec:
  resources:
    requests:
      storage: 100Gi
  selector:
    matchLabels:
      name: "nextcloud"
```

We will also need a database so we can create some storage for that as well.
If you used the local storage in the previous step, first add this.

```yaml
# pv nextcloud database
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-nextcloud-db
  namespace: nextcloud
  labels:
    name: "nextcloud-db"
spec:
  capacity:
    storage: 20Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-storage
  local:
    path: /mnt/nextcloud-db/ # An existing folder on your node
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - node1 # The name of your node
```

Then add pvc for database.

```yaml
# pvc nextcloud database
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-nextcloud-db
  namespace: nextcloud
spec:
  resources:
    requests:
      storage: 20Gi
  selector:
    matchLabels:
      name: "nextcloud-db"
```


## Database {#database}

Nextcloud can host Mysql, MariaDb and Postgres. The database will not store the your personal files but keep track of activity, saved bookmarks, indexes and more. I picked Postgres for my instance.
Bitnami has a great chart for that.

```shell
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install --namespace nextcloud nextcloud bitnami/postgresql \
--set persistence.enabled=true \
--set persistence.existingClaim=pvc-nextcloud-postgres \
```

You can follow the output from the helm chart to connect to the postgres database.
After we are connected, create a database called `nextcloud`.

```sql
CREATE DATABASE nextcloud;
```

Postgres will also create a secret for us. Nextcloud's helm chart supports the use of an existing secret. If we only want to use this inside the cluster for Nextcloud we can just reuse the admin user created by Postgres. We can just the secret by adding `postgresql-username=postgres` to it.

```shell
kubectl get secret nextcloud-postgres -n nextcloud -o json | jq --arg user "$(echo -n postgres | base64)" '.data["postgresql-username"]=$user' | kubectl apply -n nextcloud -f -
```


## Nextcloud {#nextcloud}

It's time to install the heart of our instance, the Nextcloud itself. Nextcloud has a helm chart that we can configure to our needs. If you want to read the documentation you can head over to their [helm repo](https://github.com/nextcloud/helm/tree/master/charts/nextcloud).

At first add the chart.

```shell
helm repo add nextcloud https://nextcloud.github.io/helm/
helm repo update
```

And here is the helm install for Nextcloud.

```shell
helm install my-nextcloud nextcloud/nextcloud --namespace nextcloud \
--set image.tag=21.0.0 \
--set internalDatabase.enabled=false \
--set externalDatabase.enabled=true \
--set externalDatabase.type=postgresql \
--set externalDatabase.host="nextcloud-postgresql"  \
--set externalDatabase.database=nextcloud \
--set externalDatabase.existingSecret.enabled=true \
--set externalDatabase.existingSecret.secretName=nextcloud-postgresql \
--set externalDatabase.existingSecret.usernameKey=postgresql-username \
--set externalDatabase.existingSecret.passwordKey=postgresql-password \
--set persistence.enabled=true \
--set persistence.existingClaim=pvc-nextcloud \
--set cronjob.enabled=true \
--set cronjob.schedule="*/15 * * * *" \
--set service.type=NodePort \
--set service.nodePort=32123 \
```

Ok, so what do we got here.

-   Image tag to the instance we want to install, in this case 21.0.0. You can check [Nextclouds docker](https://hub.docker.com/%5F/nextcloud/) page for available images.
-   The Postgres instance as an external database (sqlite is default but not recommended)
-   Pvc for Nextcloud data
-   Cronjobs to run every 15 minutes. That will run tasks for Nextcloud like updating your dashboard and adding new pictures to the map

Before the fun starts we need to edit the trusted\_domains in the `config.php` I mentioned earlier. It should be enough to set your local ip-address to just reach it but there are some other cases may also want that add that has to do with the routing inside the cluster.

```php
'trusted_domains' =>
  array (
    0 => 'localhost',
    1 => 'my-domain.com', # Your own domain if you have one
    2 => '192.168.1.*',   # To allow access to Nextcloud
    3 => 'my-nextcloud',
    4 => '*.cluster.local',
  ),
```

If you visit <http://cluster-ip:32123> you should now have a working Nextcloud! :)
The default login is usually:
admin/changeme

If you want to upgrade your Nextcloud you can just run

```shell
helm upgrade my-nextcloud nextcloud/nextcloud --namespace nextcloud \
--set image.tag=<VERSION_TAG> \
... plus everything from the install command.
```

I'm currently using an ingress controller with cert manager to make Kubernetes route my own domain to Nextcloud with automatic generation of Letsencrypt certificate. Maybe I will cover that in the next guide!


## Conclusion {#conclusion}

Nextcloud has a lot to offer. If you want a convenient way to host your data with tons of possibilities Nextcloud does an amazing job. Just put a little effort and you will have your own professional platform just for yourself or family. The community is healthy and it's updated regularly. Not only can you host your files it's a whole suit of services and apps that adds to the experience!

Give [Nextcloud](https://nextcloud.com/) a shot!
