# Created by newuser for 5.0.7
autoload -U compinit
compinit
zstyle ':completion:*' menu select
setopt HIST_IGNORE_DUPS
#autoload -U promptinit
#promptinit
autoload -U colors && colors

PROMPT="[$fg_bold[red]%n$fg_bold[magenta]@$fg_bold[magenta]%m$reset_color] $fg[blue](^_^%)$reset_color [$fg_bold[green]%~$reset_color]
$ "

#コマンドライン返り値を顔文字で表示する関数
prmpt(){
    PROMPT="[$fg_bold[red]%n$fg_bold[magenta]@$fg_bold[magenta]%m$reset_color] %(?.$fg[green](^_^%)$reset_color.$fg[red](;_;%)%?$reset_color) [$fg_bold[green]%~$reset_color]
$ " 
}

#上の関数がprecmdで呼ばれるように登録
autoload -Uz add-zsh-hook
add-zsh-hook precmd prmpt

# ディレクトリ名だけでcdする
setopt auto_cd 

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
 
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
 
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
 
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
 
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
 
# 高機能なワイルドカード展開を使用する
setopt extended_glob 
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
# rlwrap の後でもエイリアスを有効にする。
alias rlwrap='rlwrap '

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;  
esac

# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

#alias ls='ls --color=auto -F'
alias tmux='tmux -2'
alias la='ls -al'
alias ll='ls -l'
alias l='ls'
alias e='emacs -nw'
alias rl='rlwrap'
alias t='tmux'
alias tl='tmux ls'
alias ta='tmux a -t'
alias clear2="echo -e '\026\033c'"
alias go='gnome-open'

export EDITOR='nano'
unset SSH_ASKPASS

export PATH="$HOME/.rbenv/bin:$PATH"

which rbenv > /dev/null
if [ $? = 0 ]; then
    eval "$(rbenv init -)"
fi
#. "/home/kazakami/.acme.sh/acme.sh.env"
