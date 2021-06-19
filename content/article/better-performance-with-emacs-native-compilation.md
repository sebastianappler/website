+++
title = "Better performance with Emacs native compile"
date = 2021-04-29
tags = ["emacs", "guide"]
categories = ["emacs"]
draft = false
author = "Sebastian Appler"
+++

I recently stumbled upon Emacs native compilation. As native sounds like good I had to try it out. If you also want to try it here's a quick guide how to compile natively.

We can find some hints on [emacswiki](https://www.emacswiki.org/emacs/GccEmacs) but lets walk through it in detail on an Ubuntu system.

First if you compiled Emacs by source before make sure to uninstall it. This can be made
with the \`make uninstall\` command. Don't worry this will not remove any emacs settings.

```shell
cd /your/prevoious/src/emacs
make uninstall
```

Checkout the source code for native comp:

```shell
git clone git://git.savannah.gnu.org/emacs.git emacs-native-comp
```

On the emacswiki they mention that we need \`libgccjit\`. That can be installed with this:

```shell
sudo apt install libgccjit-10-dev
```

Ok, we are almost done for some serious compiling. But first we need to set the gcc version. If I skipped this step I would get an error when doing the Emacs configuration.

```shell
export CC="gcc-10"
```

Lets install Emacs:

```shell
# Generate configure
./autogen.sh

# Configuring, this will fail if you dont set the CC variable in the previous step
./configure --with-native-compilation

# Serious compiling...
sudo make -j$(nproc)

# Finially to install emacs native compilation on the system
sudo make install

# Or just run this to try the compilation
./src/emacs
```

If everything went well you should now have a native compiled emacs!

I did some performance tests by starting doom emacs and noting the startup time in
shown in the right corner.

Here is the test before and after native comp with my doom emacs setup:

```nil
Emacs 27.1 startup time (normal)
0.849
0.909
0.903
0.919
0.890
0.872
0.929

~ 0.895s

Emacs native comp startup time

0.723
0.789
0.738
0.737
0.727
0.768
0.740

~ 0.746s

Total ~20% faster
```

{{< figure src="/ox-hugo/doom-emacs-performance.png" >}}

As you can see I got around 20% performance boost on startup 8-)
