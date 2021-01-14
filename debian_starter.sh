#!/bin/sh
# License: GNU GPLv3
sudo apt-get update && apt-get upgrade -y

# assumes no desktop environment -- must install Xorg things
sudo apt-get --no-install-recommends install xserver-xorg xserver-xorg-video-fbdev \
xinit pciutils xinput xfonts-100dpi xfonts-75dpi xfonts-scalable libx11-dev libxft-dev libxinerama-dev xorg-dev -y
# install other common utils
sudo apt-get install build-essential curl neovim make tmux git python3-pip neofetch stow -y

# fancy font
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

# install dwm
git clone https://git.suckless.org/dwm
cd dwm
sed -i '9 a static const char *fonts[]          = { "Source Code Pro:size=12" };' config.def.h
sed -i '10 a static const char dmenufont[]       = "Source Code Pro:size=12";' config.def.h
sed -i '8d' config.def.h
sed -i '8d' config.def.h
sudo make install
cd

# install dmenu and set font
git clone https://git.suckless.org/dmenu
cd dmenu
sed -i '6 a "Source Code Pro:size=12"' config.def.h
sed -i '8d' config.def.h
sudo make install 
cd

# get xsession ready to go
touch ~/.xsession
echo '#!/bin/sh' >> ~/.xsession
echo 'xterm &' >> ~/.xsession
echo 'exec dwm' >> ~/.xsession

# install a browser
sudo apt install firefox-esr -y

# instructions:
# startx                                                    # to get into dwm
# Alt-Shift-Enter                                           # to open st
# Alt-Shift-c                                               # to close a window
# Alt-p                                                     # start dmenu application launcher
# nvim into dotfiles/nvim/.config/nvim and run :PlugInstall # to install all vim packages
