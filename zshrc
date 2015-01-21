export HISTFILE=~/.histfile
export HISTSIZE=10000
export SAVEHIST=10000
export EDITOR=vim

hostcolor=blue

if [[ -d /snacks/bin ]] ; then
	path=(/snacks/bin $path)
fi

if [[ -f ~/dotfiles/256term.sh ]] ; then
	emulate sh -c 'source ~/dotfiles/256term.sh'
fi

if [[ `uname` == "OpenBSD" ]];then
	alias ls='ls -F'
	hostcolor=red
else
	alias ls='ls --color=auto -F'
fi

bindkey -e
autoload -Uz compinit promptinit colors
compinit && promptinit && colors
PROMPT="%{$fg[$hostcolor]%}%m %{$reset_color%}%1~%# "
RPROMPT="%(?..[%{$fg[red]%}%?%{$reset_color%}]) %T"
PRINTER="futura"
_force_rehash() {
	  (( CURRENT == 1 )) && rehash
		    return 1000 # Because we didn't really complete anything
}
setopt HIST_IGNORE_DUPS
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' users ochagene
