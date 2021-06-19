+++
title = "Why Emacs can become your favorite editor"
date = 2021-03-06
tags = ["emacs", "linux", "open-source"]
categories = ["emacs"]
draft = false
author = "Sebastian Appler"
+++

If you ask someone if they heard of Emacs they will probably say; "Yeah, I remembered it when people used it long time ago". But most people will look at you with a bushy thing going on in their face.

My first experience with Emacs was when I studied. The teachers wrote lab-instructions: "Open your favorite editor and follow the instructions. We will assume that you choose Emacs. If you didn't choose Emacs, good luck, your on your own!".

Since I believed in them I forced myself to use an editor that when you press \`Ctrl+s\` you will do anything but saving the document. If you want to undo, you think that \`Ctrl+z\` will have your back? I wont even start about how to open a new file. In other words it was IMPOSSIBLE to even use this thing. All commands were scattered at random places.

After the years of studying I let Emacs rest, the years passed. As my editor journey editor journey started I was using everything from notepad++, Eclipse, Visual Studio Code to Netbeans, IntelliJ and Sublime. It wasn't until two planets lined up that I realized the reasons for Emacs. I started to gravitate towards linux and started to care about privacy.


## The linux editors {#the-linux-editors}

When you use linux you probably come across the editor vi. In linux you will spend time in terminals, since terminals don't have a GUI, vi becomes pretty handy. With vi, you have a very powerful lightweight editor in your terminal. It will be available in almost any distro on any server that you use.

Like Emacs the vi editor's major obstacle is the amount of keybindings you need to learn, there's no GUI and no mouse so everything is keybindings. You will spend much time just to check how to do things or to copy-paste instead of actually editing files. The good news is, if you ever learned the vi commands, you can pretty much start using Emacs already!

The secret sauce to get a decent instance of Emacs is to use pre-configured one like [Doom Emacs](https://github.com/hlissner/doom-emacs) or [Spacemacs](https://www.spacemacs.org/). If you just start with a clean install it's likely you will lose the interest pretty immediately. I spent the better part of a day to just unsuccessfully try and make dark theme, it was just overwhelming. Unless you're prepared to invest some good amount of time just to get the basics right. Both of these pre-configured Emacs offers evil-mode which will make almost all vi commands viable in Emacs, yay! I knew these hours of training keybindings wasn't wasted! If you cant decide which one I can also recommend checking out [Chemacs](https://github.com/plexus/chemacs2), it will allow you to run two Emacs instances in parallel so it's easy to switch between them to compare features.

If you lurk around in the Emacs ecosystem you will realize that Emacs is a pretty potent editor. Every config can be configured, there's a plugin for almost everything and there's a big community behind it. But for me one of the biggest ups is that it's a true open source editor.


## Open-source & privacy {#open-source-and-privacy}

The most promising competitor to Emacs in my opinion is Visual Studio Code. It has gotten more and more attention during the years. The promise is this; an open-source editor with everything, and it's easy. This is all fine and dandy. The issue is that there's a company behind it, Microsoft, and with every company they are interested in money. The motive is not primarily to be in open-source because it's open-source.
History has taught us again and again that we shouldn't trust companies. I haven't been on the vision meetings at Microsoft but I know that the editor developers choose is a powerful achievement. It gives you opportunities to weave developers into your products which in turn will make them want their company to use Microsoft's products and that in turn will spiral away until everyone wants to use Microsoft. But you will not get every developer to use your editors by making a payed version locked to a product ecosystem. So first phase: "Make it cross platform open source and just awesome!".
The second phase is to slowly adopt money making practices. Microsoft is already slowly locking pieces behind closed source. For example the [Python Language Server](https://github.com/microsoft/pylance-release/issues/4), [Remote Tools](https://code.visualstudio.com/docs/remote/faq#%5Fwhy-arent-the-remote-development-extensions-or-their-components-open-source) and marketplace extensions to [only work with the Microsoft's VS Code](https://github.com/VSCodium/vscodium#extensions-and-the-marketplace).
If you want to use Microsoft's version you also have to actively opt-out from [telemetry](https://code.visualstudio.com/docs/getstarted/telemetry). Since other parts are closed source it even led to questions if it's [really open-source at all](https://github.com/Microsoft/vscode/issues/17996).
As Microsoft sits behind the wheels we shouldn't expect they will do what's good for the users. More of these money making practices will happen in the future, even if the situation is fine today it's no guarantee for tomorrow.


## Conclusion {#conclusion}

I really liked the easiness of VS Code but I don't want to get handcuffed by Microsoft in the future. With Emacs you can rest assured on whole different level that it will to stay true and open for it's users. It also has all the configuration and tools you need if you can invest some time to get them going. It's the perfect fit for linux users as it merges with many of the design philosophies of vi. You can switch effortless between them as you getting better editing with keybindings only.
