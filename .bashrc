COLOR_NONE="\[\033[00m\]"
COLOR_PURPLE="\[\033[0;32m\]"
COLOR_ORANGE="\[\033[0;33m\]"
COLOR_CYAN="\[\033[0;36m\]"
COLOR_GREEN="\[\033[0;76m\]"

BOLD_COLOR_WHITE="\[\033[1;97m\]"
BOLD_COLOR_PURPLE="\[\033[1;32m\]"
BOLD_COLOR_ORANGE="\[\033[1;33m\]"
BOLD_COLOR_CYAN="\[\033[1;36m\]"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

## uncomment for a colored prompt, if the terminal has the capability; turned
## off by default to not distract the user: the focus in a terminal window
## should be on the output of commands, not on the prompt
#force_color_prompt=yes
#
#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#    	# We have color support; assume it's compliant with Ecma-48
#    	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#    	# a case would tend to support setf rather than setaf.)
#    	color_prompt=yes
#    else
#    	color_prompt=
#    fi
#fi

#nset color_prompt force_color_prompt

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}
show_git_branch() {
  GIT_BRANCH_STR="$(parse_git_branch)"
  if [ ! -z "$GIT_BRANCH_STR" ]; then
    echo -e "$GIT_BRANCH_STR"
  else
    echo -e ""
  fi
}
show_hostname() {
  if [ ! -z "$CONTAINER_ID" ]; then
    echo -e "📦$CONTAINER_ID📦"
  else
    echo -e "$HOSTNAME"
  fi
}


# Add Python VirtualEnv portion of the prompt, this adds ":venvname"
if ! test -z "$VIRTUAL_ENV" ; then
	PS1_PY_VENV="${COLOR_VENV}`basename \"$VIRTUAL_ENV\"`${COLOR_DIVIDER}"
fi

PS1="\n\t $COLOR_PURPLE\w $COLOR_ORANGE\$(show_git_branch)\n$COLOR_CYAN\u$BOLD_COLOR_WHITE@$COLOR_NONE\$(show_hostname) $ "

. "$HOME/.cargo/env"

export XDG_CONFIG_HOME=$HOME/.config
export PATH=$HOME/.config/emacs/bin:$PATH
export PATH=$HOME/.local/podman/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.ghcup/bin:$PATH
