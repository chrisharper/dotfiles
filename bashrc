# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

export VISUAL=nvim
export EDITOR=nvim
alias vim=nvim
alias vi=nvim

function switchres(){
  cmd=`xrandr -q | grep 'primary 2560x1600'`
  if [ $? -eq 0 ]
  then 
    xrandr -s 3840x2160
    xrandr --dpi 192
  else
    xrandr -s 2560x1600
    xrandr --dpi 92
  fi
}

export -f switchres