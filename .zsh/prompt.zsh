# prompt settings

source ~/Development/dotfiles/.git-prompt

setopt prompt_subst

function cpu_prompt_info {
  local cpu_info=$(sysctl -n machdep.cpu.brand_string)
  local arch_name=$(arch)
  # Warn if we're on an M1, but using an Intel shell
  if [[ "$cpu_info" = "Apple M1" ]] && [[ "$arch_name" != "arm64" ]]; then
    echo "${PR_BOLD_RED}[INTEL]%F{reset} "
  fi
}

# Make this look the same as the bash prompt
PROMPT="$(cpu_prompt_info)%F{251}%~%F{reset}%B%F{cyan}\$(__git_ps1 \" %s\")%F{reset}%b "
# PROMPT='%F{cyan}%n@%m %F{green}%~ %F{yellow}%% %f'


export GIT_PS1_SHOWDIRTYSTATE=true

