#

FROM docker.io/library/ubuntu:jammy-20231211.1

# DESCRIPTION "更改时区，替换apk源为USTC"
LABEL MAINTAINER=yangrui
LABEL ubuntu_version=22.04
LABEL zoneinfo="Asia/Shanghai"
LABEL apt_repositoris="mirrors.ustc.edu.cn"


RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y  tzdata ca-certificates curl  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone


sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list ;
apt update;
apt install vim curl zsh git wget jq tree autojump tzdata ca-certificates -y ;
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

echo '
set nu

set wildmenu             " vim自身命名行模式智能补全
set completeopt-=preview " 补全时不显示窗口，只显示补全列表
set laststatus=2         " 总是显示状态栏
set cursorline           " 高亮显示当前行
set whichwrap+=<,>,h,l   " 设置光标键跨行
set ttimeoutlen=0        " 设置<ESC>键响应时间
set virtualedit=block,onemore
syntax on
let g:onedark_termcolors=256
set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,gbk,gb2312,gb18030

set ts=4 " 设置4个空格为制表符
set expandtab
set paste
set autoindent
set cindent
set noai 
set nosi
' > ~/.vimrc;

git clone --depth=1 https://jihulab.com/rickiey/ohmyzsh.git ~/.oh-my-zsh;
git clone --depth=1 https://jihulab.com/rickiey/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
git clone --depth=1 https://jihulab.com/rickiey/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
git clone --depth=1 https://jihulab.com/rickiey/cmdtime.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/cmdtime;
wget https://jihulab.com/rickiey/batcat-repo/-/raw/ba282011f56b1751b78876d2c95554415e53a9d8/bat-musl_0.22.1_amd64.deb ;
dpkg -i bat-musl_0.22.1_amd64.deb;
rm -f bat-musl_0.22.1_amd64.deb;
DATAFORMAT="'+%Y-%m-%d %H:%M:%S'";
echo 'export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="steeef"
DISABLE_AUTO_UPDATE="true"
plugins=(git zsh-autosuggestions cmdtime zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
alias cat="bat -p  --theme Dracula  "
alias ll="ls --time-style='$DATAFORMAT' -lhF"
alias la="ls --time-style='$DATAFORMAT' -AlhF"
alias l="ls --time-style='$DATAFORMAT' -lhF"
alias t="tree -DFugphcr --timefmt='$DATAFORMAT' -L 1"
alias t2="tree -DFugphcr --timefmt='$DATAFORMAT' -L 2"
' > ~/.zshrc

docker commit ubuntu-dev registry.cn-shanghai.aliyuncs.com/linden_blockchain/ubuntu:dev 