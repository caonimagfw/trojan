#!/bin/bash

#fonts color
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

#copy from 秋水逸冰 ss scripts
if [[ -f /etc/redhat-release ]]; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
fi

function install_trojan(){
    
        your_domain = 'kids.bmwpay.net'
    
    	green "=========================================="
    	green "       开始安装trojan"
    	green "=========================================="
    	sleep 1s
    
        green "======================="
        yellow "Input Password of Trojan"
        green "======================="
        read trojan_passwd
    	
    	    	
    	#mkdir /usr/local/trojan-cli
        cd /usr/local
    	wget https://github.com/caonimagfw/trojan/raw/master/trojan-1.14.0-linux-amd64.tar.xz
    	tar xf trojan-1.*
    	#下载trojan客户端
    	wget https://github.com/caonimagfw/trojan/raw/master/trojan-cli.zip
    	unzip trojan-cli.zip
    	cp /root/ssl/bmwpay.net/fullchain.perm /usr/local/trojan-cli/fullchain.perm
    	
    	cat > /usr/local/trojan-cli/config.json <<-EOF
    {
        "run_type": "client",
        "local_addr": "127.0.0.1",
        "local_port": 1080,
        "remote_addr": "$your_domain",
        "remote_port": 443,
        "password": [
            "$trojan_passwd"
        ],
        "log_level": 1,
        "ssl": {
            "verify": true,
            "verify_hostname": true,
            "cert": "fullchain.cer",
            "cipher_tls13":"TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
    	"sni": "",
            "alpn": [
                "h2",
                "http/1.1"
            ],
            "reuse_session": true,
            "session_ticket": false,
            "curves": ""
        },
        "tcp": {
            "no_delay": true,
            "keep_alive": true,
            "fast_open": false,
            "fast_open_qlen": 20
        }
    }
    EOF
    	rm -rf /usr/local/trojan/server.conf
    	cat > /usr/local/trojan/server.conf <<-EOF
    {
        "run_type": "server",
        "local_addr": "0.0.0.0",
        "local_port": 443,
        "remote_addr": "127.0.0.1",
        "remote_port": 80,
        "password": [
            "$trojan_passwd"
        ],
        "log_level": 1,
        "ssl": {
            "cert": "/usr/local/trojan-cli/fullchain.perm",
            "key": "/usr/local/trojan-cli/privkey.perm",
            "key_password": "",
            "cipher_tls13":"TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
    	"prefer_server_cipher": true,
            "alpn": [
                "http/1.1"
            ],
            "reuse_session": true,
            "session_ticket": false,
            "session_timeout": 600,
            "plain_http_response": "",
            "curves": "",
            "dhparam": ""
        },
        "tcp": {
            "no_delay": true,
            "keep_alive": true,
            "fast_open": false,
            "fast_open_qlen": 20
        },
        "mysql": {
            "enabled": false,
            "server_addr": "127.0.0.1",
            "server_port": 3306,
            "database": "trojan",
            "username": "trojan",
            "password": ""
        }
    }
    EOF
    	cd /usr/local/trojan-cli/
    	zip -q -r trojan-cli.zip /usr/local/trojan-cli/
    	mv /usr/local/trojan-cli/trojan-cli.zip /usr/local/caddy/www/
    	#增加启动脚本
    	
    cat > ${systempwd}trojan.service <<-EOF
    [Unit]  
    Description=trojan  
    After=network.target  
       
    [Service]  
    Type=simple  
    PIDFile=/usr/local/trojan/trojan/trojan.pid
    ExecStart=/usr/local/trojan/trojan -c "/usr/local/trojan/server.conf"  
    ExecReload=  
    ExecStop=/usr/local/trojan/trojan  
    PrivateTmp=true  
       
    [Install]  
    WantedBy=multi-user.target
    EOF

    	chmod +x ${systempwd}trojan.service
    	systemctl start trojan.service
    	systemctl enable trojan.service
    	green "======================================================================"
    	green "Trojan已安装完成，请使用以下链接下载trojan客户端，此客户端已配置好所有参数"
    	green "1、复制下面的链接，在浏览器打开，下载客户端"
    	yellow "http://${your_domain}/$trojan_path/trojan-cli.zip"
    	red "请记录下面规则网址"
    	yellow "http://${your_domain}/trojan.txt"
    	green "2、将下载的压缩包解压，打开文件夹，打开start.bat即打开并运行Trojan客户端"
    	green "3、打开stop.bat即关闭Trojan客户端"
    	green "4、Trojan客户端需要搭配浏览器插件使用，例如switchyomega等"
    	green "访问  https://www.v2rayssr.com/trojan-1.html ‎ 下载 浏览器插件 及教程"
    	green "======================================================================"
    	else
            red "================================"
    	red "https证书没有申请成果，本次安装失败"
    	red "================================"
    	fi
    	
}

function remove_trojan(){
    red "================================"
    red "即将卸载trojan"
    red "同时卸载安装的nginx"
    red "================================"
    systemctl stop trojan
    systemctl disable trojan
    rm -f ${systempwd}trojan.service
    if [ "$release" == "centos" ]; then
        yum remove -y nginx
    else
        apt autoremove -y nginx
    fi
    rm -rf /usr/local/trojan*
    green "=============="
    green "trojan删除完毕"
    green "=============="
}

function bbr_boost_sh(){
    #bash <(curl -L -s -k "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh")
}

start_menu(){
    clear
    green " ===================================="
    green " Trojan 一键安装自动脚本      "
    green " 系统：centos7+/debian9+/ubuntu16.04+"
    green " 网站：www.v2rayssr.com （已开启禁止国内访问）              "
    green " 此脚本为 atrandys 的，波仔集成了BBRPLUS加速 "
    green " Youtube：波仔分享                "
    green " ===================================="
    echo
    red " ===================================="
    yellow " 1. 一键安装 Trojan"
    red " ===================================="
    yellow " 2. 安装 4 IN 1 BBRPLUS加速脚本"
    red " ===================================="
    yellow " 3. 一键卸载 Trojan"
    red " ===================================="
    yellow " 0. 退出脚本"
    red " ===================================="
    echo
    read -p "请输入数字:" num
    case "$num" in
    1)
    install_trojan
    ;;
    2)
    bbr_boost_sh 
    ;;
    3)
    remove_trojan
    ;;
    0)
    exit 1
    ;;
    *)
    clear
    red "请输入正确数字"
    sleep 1s
    start_menu
    ;;
    esac
}

start_menu