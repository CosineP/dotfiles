# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export PATH="$PATH:/opt/firefox:/opt/tor-browser_en-US:/opt/android-studio/bin:/opt/godot"
export DMENU_CUSTOM_OPTIONS="-fn "-*-helvetica-medium-r-*-*-14-*-*-*-*-*-*-*" -nb "#222222" -nf "#bbbbbb" -sb "#005577" -sf "#eeeeee""
export XDG_CONFIG_HOME=$HOME/.config
export vblank_mode=2

export PATH="$HOME/.cargo/bin:$PATH:/opt/godot"

PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"
