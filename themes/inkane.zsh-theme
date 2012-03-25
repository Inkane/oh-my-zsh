# my own zsh theme

### Shows state of the Versioning Control System (e.g. Git, Subversion, Mercurial
# load vcs_info
autoload -Uz vcs_info

# some style attribuets for vcs_info, not sure how they work
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{red}:%f%F{yellow}%r%f'
zstyle ':vcs_info:*' enable cvs svn bzr

# test
precmd () { vcs_info }

source /home/fabian/ohmy-additions/zsh-git-prompt/zshrc.sh

function prompt_char {
	git branch >/dev/null 2>/dev/null && echo '±' && return
	hg root >/dev/null 2>/dev/null && echo '☿' && return
	svn info >/dev/null 2>/dev/null && echo '⚡' && return
	bzr info >/dev/null 2>/dev/null && echo '◈ ' && return
	# default prompt
	echo %{$fg[red]%}">>"%{$reset_color%}
}

function hg_prompt_info {
    hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}


# local time, color coded by last return code
local time_enabled="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
local time_disabled="%{$fg[green]%}%*%{$reset_color%}"
local time=$time_enabled

# user part, color coded by privileges
local user="%(!.%{$fg[blue]%}.%{$fg[blue]%})%n%{$reset_color%}"

# dummy
local host=""

# Compacted $PWD
local pwd="%{$fg[blue]%}%c%{$reset_color%}"

PROMPT='${user}${host} ${pwd} $(hg_prompt_info) $(virtualenv_info) $(git_super_status) ${vcs_info_msg_0_} $(prompt_char) '
RPROMPT='%{$fg[white]%}[%{$reset_color%}${time}%{$fg[white]%}]%{$reset_color%}'
### Prompt for for loops
PROMPT2=%{$fg[white]%}{%_}%{$reset_color%}$(echo "\t")
### Prompt for selections (see select)
PROMPT3=%{$fg[white]%}{.?.}%{$reset_color%}$(echo "\t")

# not sure what those vars are doing
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
