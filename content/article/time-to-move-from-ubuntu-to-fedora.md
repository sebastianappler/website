+++
title = "Time to move from Ubuntu to Fedora"
date = 2021-06-19
tags = ["ubuntu", "fedora", "linux", "open-source"]
categories = ["linux"]
draft = false
author = "Sebastian Appler"
+++

{{< figure src="/ox-hugo/ubuntu-to-fedora.png" >}}

Ubuntu has been my daily driver for quite some time now. When I migrated from Windows it was
a big step just going into the linux world and I picked Ubuntu as my first choice. The Ubuntu
has served me well since then. But from time to time I felt nudged that maybe Ubuntu is not
the best distro after all. I excused myself that, yes, Ubuntu is the most used distro so there
must be a reason why it's better, right?

A name that popped up continuously for me was Fedora. The first nudge I got was that Linus
Torvalds stated that he [doesn't like Ubuntu](https://fossbytes.com/linus-torvalds-doesnt-use-ubuntu-linux-debian/) and instead uses Fedora (with some tweaks).
If Torvalds states that something is better he has his reasons. If anything it will ensure
that Fedora is future proof as many developers will make sure Fedora works great for linux.
I have a hard time to see that Torvalds favorite distribution will be discontinued or
abandoned, instead the opposite is more likely as more people want to find out what Torvalds
sees in Fedora.

So Torvalds is one thing. What are the real differences?


## Open source {#open-source}

Fedora has a [strong policy](https://fedoraproject.org/wiki/Workstation/Third%5FParty%5FSoftware%5FRepositories) to only include free and open source software in it's distro.
You are allowed to enable third party and proprietary packages, but it is very active choice,
not the other way around. Ubuntu is more relaxed to only include open source. You would easily install a third party app if you don't pay attention. For me it's securing that Fedora
has this core value of open source and would go for great lengths to avoid this rule.

It's also worth to mention the funding. They are both supported by bigger companies. However,
Ubuntu is commercially supported by Canoncial while Fedora is a community project where Red
Hat is a sponsor. This may play an important role in future when decisions will be made for
the distro. More often than not, the more tight relationship you have with a company the more
their interest will have to be pleased.


## File system {#file-system}

Fedora installs by default with the btrfs file system. This is a more modern file system then Ubuntu's default, ext4. It's refreshing to see Fedora focuses on this area. Btrfs allows for
better fault tolerance, volume management and compression. The situation reminds me of how
Microsoft has been stuck with ntfs for ages and never seems to address the issue.


## Snap {#snap}

I really tried to like snap in Ubuntu. At first glance it seems like a good idea, you get
packages installed containerized and don't need to fiddle with building apps from source.
The problem I face is firstly that a lot of software works poorly or have quirks when
installed via snap. It's not uncommon that you will try the snap version to find out that
you're better off installing it from the package website instead.
Secondly a lot of the packages are outdated in snap. Which means if you want to use the latest
versions you can not rely on snap too much.

Also, you have to keep in mind what packages you install via snap so you wont install it
double. It happened more than once that the apt packages you installed was already added
with snap and now you have to figure how to remove the correct one.
I ended up to have a personal rule to avoid snap packages as much as possible.

In Fedora instead of snap your Software store will just use the standard package manager,
dnf, to install your packages. It's only a matter of if you like to use a GUI or the command
line to install the software.


## Releases {#releases}

Ubuntu just released its 21.04 (Hirsute Hippo) and although it's always nice with new releases
it feels like a forced one from Ubuntu. In the [release notes](https://discourse.ubuntu.com/t/hirsute-hippo-release-notes/19221) we get a linux kernel bump as
the first highlight feature. If you read further you will see some packages that are updated,
including Firefox. It's of course nice but it's not really much of a new major release.
In comparison Fedora 34 release got the latest Gnome 40. Better read write performance with
zstd. Replaced PulseAudio with Pipewire for sound. Plus all the package and kernel bumps.


## Summary {#summary}

While Ubuntu will be a stable horse for most. I feel that it is tilting towards a bad course.
Development decisions feels weird and does not really bring anything new to the table. Fedora
on the other hand seems to get more and more attention and a much healthier focus of
development. It's being firm with the open source policy while continuing to give you new
interesting features.

When deciding which boat to sail for the future Fedora feels like a much more interesting choice. I'm excited to see what future holds for Fedora!
