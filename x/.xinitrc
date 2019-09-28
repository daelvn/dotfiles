#!/bin/bash
# .xinitrc
# https://github.com/daelvn/dotfiles

case "$2" in
	i3)
		exec i3
		;;
	gnome)
		exec xrdb .Xresources &
		exec gnome-session
		;;
	pantheon)
		gsettings-data-convert &
		xdg-user-dirs-gtk-update &
		/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
		/usr/lib/gnome-settings-daemon/gnome-settings-daemon &
		/usr/lib/gnome-user-share/gnome-user-share &
		eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
		export GNOME_KEYRING_CONTROL GNOME_KEYRING_PUD GPG_AGENT_INFO SSH_AUTH_SOCK
		exec cerbere
		;;
	pantheon-gnome)
		;;
	*)
		exec i3
		;;
esac
