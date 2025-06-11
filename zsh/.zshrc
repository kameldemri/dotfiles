# ─────── PATH Setup ───────

# Java (latest OpenJDK)
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH="$JAVA_HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

# Doom Emacs binary path
export PATH="$HOME/.config/emacs/bin:$PATH"

# Oh My Zsh install path
export ZSH="$HOME/.oh-my-zsh"


# ─────── Plugin Auto-Installer ───────

# Auto-install zsh plugins if missing
ZSH_CUSTOM_PLUGINS="$ZSH/custom/plugins"

mkdir -p "$ZSH_CUSTOM_PLUGINS"

# zsh-autosuggestions
if [[ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git  "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [[ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting"
fi


# ─────── Theme & Plugins ───────

ZSH_THEME="robbyrussell"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)


# ─────── OMZ Config ───────

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh


# ─────── Aliases ───────

# XAMPP control
alias xstart='sudo /opt/lampp/lampp start'
alias xstop='sudo /opt/lampp/lampp stop'
alias xrestart='sudo /opt/lampp/lampp restart'

# MariaDB control
alias mariadbstart='sudo systemctl start mariadb'
alias mariadbstop='sudo systemctl stop mariadb'
alias mariadbrestart='sudo systemctl restart mariadb'

# Live server with Chromium
alias live-server="live-server --browser=chromium"
