if [[ "$TERM" == "xterm" || "$TERM" == "xterm-color" ]]; then
	export PROMPT_COMMAND="set_window_and_tab_title"
	export HISTCONTROL=erasedups
	shopt -s histappend
    #PS1="\w \$ "
    #export PS1
fi

for file in /usr/local/etc/bash_completion.d/* ; do
  source "$file"
done

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

alias ls="ls -G"
alias l="ls -laG"
alias c="cd ~/Code"
alias gruo="git remote update origin"

alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias g="git status"
alias gg="git lg"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"
alias grv="git remote -v"
alias gcv="git commit -v"
alias v="vim"
alias oo='open -a /Applications/OpenOffice.org.app'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias tmux='tmux -2'
alias ..='cd ..'
alias ak="ssh -Y root@162.243.14.224"

export EDITOR=vim

export HISTSIZE=1000000
export HISTFILESIZE=1000000
shopt -s histappend

function h() {
 history | grep "$@"
}

function set_window_and_tab_title()
{
	local pwd_length=42 # set the maximum length just incase with dig deep.
	local dir="$PWD"    # get the cwd

   # Substitute a leading path that's in $HOME for "~"
   if [[ "$HOME" == ${dir:0:${#HOME}} ]]; then
       dir="~${dir:${#HOME}}"
   fi
   # Append a trailing slash if it's not there already.
   if [[ ${dir:${#dir}-1} != "/" ]]; then
       dir="$dir/"
   fi	
   # Truncate if we're too long.
   # We preserve the leading '/' or '~/', and substitute
   # ellipses for some directories in the middle.
   if [[ "$dir" =~ (~){0,1}/.*(.{${pwd_length}}) ]]; then
       local tilde=${BASH_REMATCH[1]}
       local directory=${BASH_REMATCH[2]}

       # At this point, $directory is the truncated end-section of the
       # path.  We will now make it only contain full directory names
       # (e.g. "ibrary/Mail" -> "/Mail").
       if [[ "$directory" =~ [^/]*(.*) ]]; then
           directory=${BASH_REMATCH[1]}
       fi

       # Can't work out if it's possible to use the Unicode ellipsis,
       # '…' (Unicode 2026).  Directly embedding it in the string does not
       # seem to work, and \u escape sequences ('\u2026') are not expanded.
       #printf -v dir "$tilde/\u2026$s", $directory"
       dir="$tilde/...$directory"
   fi

   # Don't embed $dir directly in printf's first argument, because it's
   # possible it could contain printf escape sequences.
   printf "\033]0;$USER@localhost:%s\007" "$dir"
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="/usr/local/bin:$PATH"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if
  which pyenv > /dev/null; then eval "$(pyenv init -)";
  rm ~/.pyenv/shims/*config
fi

