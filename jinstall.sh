#!/bin/sh
# License: GNU GPLv3
sudo apt-get update && apt-get upgrade -y

# assumes no desktop environment -- must install Xorg things
sudo apt-get --no-install-recommends install xserver-xorg xserver-xorg-video-fbdev \
xinit pciutils xinput xfonts-100dpi xfonts-75dpi xfonts-scalable libx11-dev libxft-dev libxinerama-dev xorg-dev -y
# install other common utils
sudo apt-get install build-essential curl make git lightdm sucrose -y

# font
cd /usr/share/fonts/
sudo git clone https://github.com/adobe-fonts/source-code-pro.git
cd
sudo fc-cache -fv

# install st and set font. If something goes wrong delete config.h and try again manually.
git clone https://git.suckless.org/st
cd st
sed -i '7 a static char *font = "Source Code Pro:pixelsize=16:antialias=true:autohint=true";' config.def.h
sed -i '9d' config.def.h
sudo make install
cd

# install a browser
sudo apt install firefox-esr -y

# instructions:
# Alt-Shift-Enter                                           # to open st
# Alt-Shift-c                                               # to close a window
