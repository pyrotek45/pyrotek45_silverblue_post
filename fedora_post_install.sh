#!/usr/bin/bash
# Fedora Silverblue Post install by Pyrotek45 [mon jul 26 - 2021]
sudo ostree admin pin 0
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

#installs flathub repo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Discord (Online chat and video calling)
flatpak install flathub com.discordapp.Discord -y
echo "alias discord='flatpak run com.discordapp.Discord'" >> ~/.bashrc

# Neovim + config (Forked version of vim)
flatpak install flathub io.neovim.nvim -y
git clone https://github.com/pyrotek45/pyrotek45_neovim.git && chmod +x pyrotek45_neovim/neovim_setup.sh && cd pyrotek45_neovim/ && ./neovim_setup.sh -f
echo "alias nvim='flatpak run io.neovim.nvim'" >> ~/.bashrc

# Steam and Proton (Gaming platform by Valve)
flatpak install com.valvesoftware.Steam.CompatibilityTool.Proton-GE -y
flatpak install flathub com.valvesoftware.Steam -y
echo "alias steam='flatpak run com.valvesoftware.Steam'" >> ~/.bashrc

#TODO
#install vscode and replace setting.json for flatpak spawn
# {
#    "terminal.integrated.defaultProfile.linux": "bash",
#    "terminal.integrated.profiles.linux": {
#        "bash": {
#          "path": "/usr/bin/flatpak-spawn",
#          "args": ["--host", "--env=TERM=xterm-256color", "bash"]
#        }
#    }
#  }

# Visual studio code (Programming ide)
flatpak install flathub com.visualstudio.code -y
echo "alias vscode='flatpak run com.visualstudio.code'" >> ~/.bashrc

# Blender (3d modeling software)
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

source ~/.bashrc

# Home Folder config
mkdir ~/Github











