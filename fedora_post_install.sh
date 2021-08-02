#!/usr/bin/bash
# Fedora Silverblue Post install by Pyrotek45 [mon jul 26 - 2021]
#installs flathub repo

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update -y
# Home Folder config
echo "creating a toolbox named dev"
toolbox create dev -y
toolbox run -c dev sudo dnf update -y

# Configure gedit ( Gnomes defualt text editor )
echo "alias gedit='flatpak run org.gnome.gedit'" >> ~/.bashrc

# To create files for flatpak gedit
flatpak run org.gnome.gedit & sleep 5 && flatpak kill org.gnome.gedit
rm ~/.var/app/org.gnome.gedit/config/glib-2.0/settings/keyfile
cp settings/gedit/keyfile ~/.var/app/org.gnome.gedit/config/glib-2.0/settings/

# Sets the time to 12 hour mode
gsettings set org.gnome.desktop.interface clock-format '12h'

# Edit the bash promt to have show git information and room for longer file paths
#echo "PS1='\[\e[0m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2)\[\e[0m\][\[\e[0m\]\u\[\e[0m\]@\[\e[0m\]\w\[\e[0m\]]\n\[\e[0m\]\$\[\e[0m\]'" >> ~/.bashrc

# adds minimize and maximize to the title bar
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# disables hot corners and enables the application menu
gnome-extensions enable apps-menu@gnome-shell-extensions.gcampax.github.com 
gsettings set org.gnome.desktop.interface enable-hot-corners false
# enables luanch new instance everytime an app is launched
gnome-extensions enable launch-new-instance@gnome-shell-extensions.gcampax.github.com

# sets dark theme and installs papirus icons
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'


# Discord ( Online chat and video calling )
flatpak install flathub com.discordapp.Discord -y
echo "alias discord='flatpak run com.discordapp.Discord'" >> ~/.bashrc
# Neovim + config ( Forked version of vim )
#flatpak install flathub io.neovim.nvim -y
#git clone https://github.com/pyrotek45/pyrotek45_neovim.git && chmod +x #pyrotek45_neovim/neovim_setup.sh && cd pyrotek45_neovim/ && ./#neovim_setup.sh -f
#echo "alias nvim='flatpak run io.neovim.nvim'" >> ~/.bashrc
echo "installing neovim into toolbox dev"

toolbox run -c dev sudo dnf install neovim -y
toolbox run -c dev git clone https://github.com/pyrotek45/pyrotek45_neovim.git && chmod +x pyrotek45_neovim/neovim_setup.sh && cd pyrotek45_neovim/ && ./neovim_setup.sh -n
echo "alias nvim='toolbox run -c dev nvim'" >> ~/.bashrc
cd ..

# Steam and Proton ( Gaming platform by Valve )
flatpak install com.valvesoftware.Steam.CompatibilityTool.Proton-GE -y
flatpak install flathub com.valvesoftware.Steam -y
echo "alias steam='flatpak run com.valvesoftware.Steam'" >> ~/.bashrc

# Visual studio code ( Programming IDE )
#flatpak install flathub com.visualstudio.code -y
#echo "alias vscode='flatpak run com.visualstudio.code'" >> ~/.bashrc

# To create files for flatpak vs code
#flatpak run com.visualstudio.code && sleep 5 && flatpak kill com.visualstudio.code
#cp settings/vscode/settings.json ~/.var/app/com.visualstudio.code/config/Code/User

toolbox run -c dev sudo dnf install libxshmfence -y
toolbox run -c dev sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
toolbox run -c dev sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

toolbox run -c dev dnf check-update -y
toolbox run -c dev sudo dnf install code -y

cp settings/icons/code.desktop ~/.local/share/applications/
echo "alias code='toolbox run -c dev code'" >> ~/.bashrc


# Blender ( 3d modeling software )
flatpak install flathub org.blender.Blender -y
echo "alias blender='flatpak run org.blender.Blender'" >> ~/.bashrc

# Godot (Game engine)
flatpak install flathub org.godotengine.Godot -y
echo "alias godot='flatpak run org.godotengine.Godot'" >> ~/.bashrc

# Glimpse (Photo editor forked from Gimp)
flatpak install flathub org.glimpse_editor.Glimpse -y
echo "alias glimpse='flatpak run org.glimpse_editor.Glimpse'" >> ~/.bashrc

# Bitwig (Pro audio Daw)
flatpak install flathub com.bitwig.BitwigStudio/x86_64/stable -y
echo "alias bitwig='flatpak run com.bitwig.BitwigStudio'" >> ~/.bashrc

# inkscape (Vector art program)
flatpak install flathub org.inkscape.Inkscape -y
echo "alias inkscape='flatpak run org.inkscape.Inkscape'" >> ~/.bashrc

# Kdenlive (Pro level video editor)
flatpak install flathub org.kde.kdenlive -y
echo "alias kdenlive='flatpak run org.kde.kdenlive'" >> ~/.bashrc

#TODO is flatpaks emacs worth it?
# Emacs ( GNU text editor and toolkit + DOOM MODE)

toolbox run -c dev sudo dnf install emacs -y
toolbox run -c dev git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
toolbox run -c dev ~/.emacs.d/bin/doom -y install
echo "alias emacs='toolbox run -c dev emacs'" >> ~/.bashrc

# spotify ( Music streaming platform )
flatpak install flathub com.spotify.Client -y
echo "alias spotify='flatpak run com.spotify.Client'" >> ~/.bashrc

# flatseal ( Manage flatpak permissions )
flatpak install flathub com.github.tchx84.Flatseal -y
echo "alias flatseal='flatpak run com.github.tchx84.Flatseal'" >> ~/.bashrc


# Blanket ( Listen to different sounds )
flatpak install flathub com.rafaelmardojai.Blanket -y
echo "alias blanket='flatpak run com.rafaelmardojai.Blanket'" >> ~/.bashrc

# Video downloader ( Download Video and Audio)
flatpak install flathub com.github.unrud.VideoDownloader -y
echo "alias video-downloader='flatpak run com.github.unrud.VideoDownloader'" >> ~/.bashrc

toolbox run -c dev gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

#echo "complete!" && exit



