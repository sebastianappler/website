+++
title = "DeGoogle your Android phone with LineageOS"
date = 2021-08-19
tags = ["lineageos", "android", "guide", "privacy", "open-source"]
categories = ["android", "guides", "privacy"]
draft = false
author = "Sebastian Appler"
+++

It's happening a lot in alternative OS for Android. Promising distribution's such as [CalyxOS](https://calyxos.org/) and [GrapheneOS](https://grapheneos.org/) offers very
interesting features with big focus on privacy and security. We also have [PureOS](https://www.pureos.net/) a pure linux distro that's not based on
AOSP but tries to use desktop linux apps on the phone. For me it still not viable way as a daily driver. The major drawback
is that even that they are interesting they are only supported for Pixel phones (or specific phones like Librem for PureOS).
Who would have thought that Google phones would be the best option to DeGoogle?

What we can do is to use [LineageOS](https://lineageos.org/). It has support for an impressive amount of phones. LineageOS (successor of CyanogenMod)
has support for an impressive 178 devices when I made a fast check on their [download page](https://download.lineageos.org/).
It seems to be accepted as a good base for privacy focused Android where it already has a bunch of forks targeting different
audiences.

The big question was if it's wise to wipe my daily driver in favor of a for me unknown LineageOS experience. I am using a
OnePlus 7T Pro and I didn't want to imagine the procedures to restore it to OnePlus stock if it failed. But I couldn't resist.
The thought of totally getting rid if Google was not going away, so I did it anyway. YOLO!

I also had to make sure that critical features works such as notifications so I landed on a version of [LineageOS for microG](https://lineage.microg.org/).


## Caveats {#caveats}

There's a few caveats that you should be aware of before installing LineageOS.


### Data is wiped when unlocking the OEM {#data-is-wiped-when-unlocking-the-oem}

Before you go ahead and unlock the OEM remember that when you execute the command `fastboot unlock oem` you will wipe all
the data on your phone even if you didn't install anything. Make sure that all your two-factor keys and other goodies are
safe before proceeding.


### The bootloader can't be locked after installation {#the-bootloader-can-t-be-locked-after-installation}

You cant lock the bootloader after installation except for Pixel phones. Most of the concerns involves if the bad guy gets
a physical hold of your phone. They can then boot into recovery mode and bypass security or launch a custom rom.

But you can also consider the security risks to stay on an old Android version that will not get updates and can have known
security vulnerabilities. Also the locking of bootloader is something that Google wants to have control of. They would probably
not be happy if the users were unable to uninstall apps such as Chrome browser or Google Play Services.

There is some security concerns although you can ask if it's safer to stay on unmaintained versions.


### Google Play Services and Google Apps {#google-play-services-and-google-apps}

If you just install LineageOS you will not have push notifications or location services by default. To tackle this problem you
can use microG that is an open source replacement for Google Play Services without as much tracking as possible. Google Apps
wont work as far as I can tell, however I haven't tested it myself. Part of the reason I install LineageOS is to get rid of
Google.


## Installation {#installation}

The installation can feel scary but is pretty straight forward. It requires some steps but luckily there's detailed guides on
how to install it on each device. I used the rom and recovery image from [microG downloads](https://download.lineage.microg.org/) but if you don't want microG you can
use the normal [LineageOS downloads](https://download.lineageos.org/) (do not unzip the rom after download).

For detailed step on installing LineageOS for your phone go to <https://wiki.lineageos.org/devices/> find your device (microG and
LineageOS has support for the same devices). Then check for _Installation_ in the _Guides_ section. Follow the steps carefully.

If everything worked out you will now be able to boot into LineageOS, congrats!


### For microG {#for-microg}


#### Fixing push notifications {#fixing-push-notifications}

For me push notifications did not work after the installation. It turned off after a while and was did reset after reboot. It
turned out I had to do some tricks to get it working.

Do not install apps that needs push notifications before these steps.

1.  Open the system phone app and dial `*#*#2432546#*#*` to do a manual device registration
2.  Open microG app and enable _Google Device Registration_ and reboot.
3.  Open microG app and enable _Cloud Messaging_ and reboot.

Now notifications should work and Google Device Registration/Cloud Messaging to be kept ON.


#### Enable location services {#enable-location-services}

As microG does not use Googles location services we also have to enable a location service to get GPS working.
Open the microG app and go to _Location Modules_ and activate _Mozilla Location Service_


## ...so how is LineageOS? {#dot-dot-dot-so-how-is-lineageos}

I was pretty worried at first because I didn't really know what to expect. Most of the time you will have to live with some
compromises to get better privacy. But I have to say I'm happily surprised. After all it seems like the heavily lifting is done by LineageOS and AOSP. It feels pretty similar as my previous OxygenOS. If you like stock Android you will not get disappointed.

I also noticed that the phone felt more smooth. I can't really say but it seems that in my case my phone was better optimized
for LineageOS. For example I have been using Firefox Nightly and it had some random stutters every now and then and they
are pretty much gone now. Some people reports that their battery is improved but I couldn't notice any significant difference.
Overall it feels much alike my old OS.

But the biggest part of them all is that now I'm (almost) totally free from Google, and it feels amazing!
It always bugged me to look at the Google Play Services app and not know what dark magic is going on inside that proprietary
app's code. Why I cant get rid of it and why I will probably never know what's going on in there. Now that and everything else
from Google is gone except from some minimal use with microG.

It feels free and I'm more in line with [Richard Stellman's TEDx talk](https://www.fsf.org/blogs/rms/20140407-geneva-tedx-talk-free-software-free-society).
