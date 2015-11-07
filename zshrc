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

if [[ -n $SSH_CLIENT ]] ; then
	hostcolor=yellow
fi

if [[ `uname` == "OpenBSD" ]];then
	alias ls='ls -F'
	hostcolor=red
else
	alias ls='ls --color=auto -F'
fi

case $TERM in
	*xterm*)
		precmd () { print -Pn "\e]0;@%m: %(1j,%j job%(2j|s|); ,)%~\a" }
		preexec () { print -Pn "\e]0;@%m: $1\a" }
esac

bindkey -e
setopt prompt_subst
autoload -Uz compinit promptinit colors vcs_info
compinit && promptinit && colors

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats \
	'%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
	'%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f%u%c '
#zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )


PROMPT="%{$fg[$hostcolor]%}%m %{$reset_color%}%1~%# "
RPROMPT=\$vcs_info_msg_0_"%(?..[%{$fg[red]%}%?%{$reset_color%}]) %T"

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

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Delete]=${terminfo[kdch1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward


# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init () {
		printf '%s' "${terminfo[smkx]}"
	}
	function zle-line-finish () {
		printf '%s' "${terminfo[rmkx]}"
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi
