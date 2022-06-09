#!/bin/bash
# By Aaron

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1

    echo "欢迎使用 HostlocAutoGetPoints 一键安装程序。"
    echo "安装即将开始"
    echo "如果您想取消安装，"
    echo "请在 5 秒钟内按 Ctrl+C 终止此脚本。"
    echo ""
    sleep 5


if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "arch"; then
    release="arch"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat|rocky|alma|oracle linux"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "arch"; then
    release="arch"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat|rocky|alma|oracle linux"; then
    release="centos"
else
    echo -e "${red}此一键脚本不适合你的系统哦～${plain}\n" && exit 1
fi


if [[ x"${release}" == x"centos" ]]; then
    yum install epel-release -y
    yum install git python3 python3-pip -y
elif [[ x"${release}" == x"ubuntu" ]]; then
    apt-get update -y
    apt install git python3 python3-pip -y
elif [[ x"${release}" == x"debian" ]]; then
    apt-get update -y
    apt install git python3 python3-pip -y
elif [[ x"${release}" == x"arch" ]]; then
    pacman -Sy
    yes | pacman -S git python3 python-pip cronie
    export EDITOR=/usr/bin/nano
fi


    python3 -m pip install --upgrade requests pyaes


    git clone https://github.com/AaronYES/HostlocAutoGetPoints


    cd HostlocAutoGetPoints
    config_file=HostlocAutoGetPoints.py
    printf "请输入Hostloc账号，如果您有多个账号，请使用英文逗号隔开"
    read -r USERNAME <&1
    sed -i "s/USERNAME/$USERNAME/" $config_file
    printf "请输入Hostloc密码，如果您有多个账号，请使用英文逗号隔开"
    read -r PASSWORD <&1
    sed -i "s/PASSWORD/$PASSWORD/" $config_file
    printf "请输入BOT_API，在@BotFather处申请"
    read -r BOT_API <&1
    sed -i "s/BOT_API/$BOT_API/" $config_file
    printf "请输入CHAT_ID，在@userinfobot处获取"
    read -r CHAT_ID <&1
    sed -i "s/CHAT_ID/$CHAT_ID/" $config_file


    echo '0 3 * * * /usr/bin/python3 /root/HostlocAutoGetPoints/HostlocAutoGetPoints.py' >> /var/spool/cron/root


echo "安装已完成"
echo "请执行 /usr/bin/python3 /root/HostlocAutoGetPoints/HostlocAutoGetPoints.py 查看配置是否正确"

