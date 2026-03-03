# ~/.zshrc

# ln -s ~/Development/dotfiles/.zshrc ~/.zshrc
# ln -s ~/Development/dotfiles/.gitconfig ~/.gitconfig

# Enable color support
autoload -Uz compinit
compinit

# Enable command completion
setopt complete_in_word # Allow tab completion to work even if the cursor is in the middle of a word
setopt auto_cd # Change to a directory just by typing its name
# setopt correctall # enable spelling correction for all commands, not just cd
unsetopt correct # disable automatic correction of commands, as it can be annoying when it guesses wrong 


# Allow more open files than the OSX default of 256
if [ $(ulimit -n) -lt 8192 ]; then
  ulimit -n 8192
fi

# unique values only in $PATH
typeset -U path PATH

source $HOME/.aliases

source ~/Development/dotfiles/.zsh/color.zsh
source ~/Development/dotfiles/.zsh/prompt.zsh
source ~/Development/dotfiles/.zsh/functions.zsh
source ~/Development/dotfiles/.zsh/history.zsh

# Setup zsh completions for homebrew formulas (from https://docs.brew.sh/Shell-Completion)
FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit

# Performance optimization: Cache completions to avoid rebuilding on every shell startup.
# Only rebuild the cache if it's older than 24 hours. This saves ~0.3 seconds.
# The -C flag skips the security check and uses the existing cache.
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ ! -f "$_zcompdump" ]] || [[ -n $(find "$_zcompdump" -mtime +1 2>/dev/null) ]]; then
  compinit
else
  compinit -C
fi
unset _zcompdump

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/local/bin"

. "$HOME/.local/bin/env"
