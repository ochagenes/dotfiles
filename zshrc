HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
EDITOR=vim
if [[ -d /snacks/bin ]] ; then
	path=(/snacks/bin $path)
fi
alias ls='ls --color=auto'
bindkey -e
autoload -Uz compinit promptinit colors
compinit && promptinit && colors
PROMPT="%{$fg[blue]%}%m %{$reset_color%}%1~%# "
RPROMPT="%(?..[%{$fg[red]%}%?%{$reset_color%}]) %T"
PRINTER="futura"
PATH=/snacks/bin:$PATH
_force_rehash() {
	  (( CURRENT == 1 )) && rehash
		    return 1000 # Because we didn't really complete anything
}
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
