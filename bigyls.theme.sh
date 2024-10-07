#! bash oh-my-bash.module

# Set term to 256color mode, if 256color is not supported, colors won't work properly
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

# Set different host color for local and remote sessions
function set_user_and_host_color() {
  # Detect if connection is through SSH
  if [[ ! -z $SSH_CLIENT ]]; then
    _omb_util_put "${_omb_prompt_bold_silver}"
  else
    _omb_util_put "${_omb_prompt_bold_green}"
  fi
}

function _omb_theme_PROMPT_COMMAND() {
  ps_username="$(set_user_and_host_color)\u${_omb_prompt_normal}"
  ps_uh_separator="${_omb_prompt_bold_green}@${_omb_prompt_normal}"
  ps_hostname="$(set_user_and_host_color)\h${_omb_prompt_normal}"

  ps_path="${_omb_prompt_bold_navy}\w${_omb_prompt_normal}"
  ps_date="${_omb_prompt_bold_yellow}$(date +%d/%m/%y-%H:%M | sed 's/-/ /')${_omb_prompt_normal}"
  ps_vpn=" ${_omb_prompt_bold_red}$(ip a | grep -A 1 -e tun0 -e ppp0 | grep inet | tr -s ' ' | cut -d ' ' -f 3 | cut -d '/' -f 1)${_omb_prompt_normal}"
  ps_scm_prompt="${_omb_prompt_bold_purple}$(scm_prompt_info)${_omb_prompt_normal}"

  # Set prompt
  PS1="${_omb_prompt_bold_red}[${_omb_prompt_bold_reset}$ps_username$ps_uh_separator$ps_hostname${_omb_prompt_bold_red}]${_omb_prompt_normal} $ps_path {$ps_date} $ps_scm_prompt$ps_vpn"
  PS1+="\n${_omb_prompt_bold_green}➜${_omb_prompt_normal} "
}

# scm theming
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY="${_omb_prompt_bold_red}✗${light_red}"
SCM_THEME_PROMPT_CLEAN="${_omb_prompt_bold_green}✓${_omb_prompt_normal}"

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
