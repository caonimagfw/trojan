#!/bin/bash
#fonts color 521
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
    	yum -y install zip unzip
        #your_domain = 'xxx.xx.com'
    
    	green "=========================================="
    	green "       开始安装trojan-go" 03
    	green "=========================================="
    	sleep 1s
        yum -y install unzip
        service caddy stop
        service shadowsocks stop
        green "======================="
        yellow "Input Domain of Trojan Go eg. abc.xx.net"
        green "======================="
        read your_domain

        green "======================="
        yellow "Input Password of Trojan Go"
        green "======================="
        read trojan_passwd
    	
        green "======================="
        yellow "Input localhost listen port, eg. 443"
        green "======================="
        read trojan_local_port

        green "======================="
        yellow "Input http web port , eg. 80"
        green "======================="
        read trojan_http_port

        if [ '${trojan_http_port}' = '80' ]; then
            trojan_http_port = 8100
        fi 
    	last_domain=$(echo ${your_domain} | awk -F. '{print $2"."$3}')
    	#     
        if [ ! -d "/usr/local/trojan-go" ]; then
            #not exists 
            cd /usr/local
            mkdir trojan-go
            cd trojan-go
            wget https://github.com/caonimagfw/trojan/raw/master/trojan-go-linux-amd64.zip
            unzip  trojan-go-linux-amd64.zip          
        fi 
    	#wget https://github.com/caonimagfw/trojan/raw/master/trojan-1.14.0-linux-amd64.tar.xz


    	 

    	rm -rf /usr/local/trojan-go/config.json
cat > /usr/local/trojan-go/config.json <<-EOF
    {
        "run_type": "server",
        "local_addr": "0.0.0.0",
        "local_port": ${trojan_local_port},
        "remote_addr": "0.0.0.0",
        "remote_port": ${trojan_http_port},
        "password": [
            "${trojan_passwd}"
        ],
        "log_level": 1,
        "ssl": {
            "cert": "/root/ssl/${last_domain}.crt",
            "key": "/root/ssl/${last_domain}.key"
        }
    }
EOF

        #set caddy 
        if [ -f "/usr/local/caddy/Caddyfile" ]; then
            cp -f "/usr/local/caddy/Caddyfile" "/usr/local/caddy/Caddyfile.trojan."$(date +"%Y%m%d_%H%M%S").bak
            rm -rf  "/usr/local/caddy/Caddyfile" 
        fi

cat > /usr/local/caddy/Caddyfile <<-EOF
                :${trojan_http_port} {
                        root /usr/local/caddy/www
                        timeouts none
                        #tls /root/ssl/${last_domain}.crt /root/ssl/${last_domain}.key
                        gzip
                }


                :80 {
                        redir https://${your_domain}:${trojan_http_port}                  
                }

EOF
       


    	#增加启动脚本
    	if [ ! -f ${systempwd}trojan-go.service ]; then
            rm -rf ${systempwd}trojan-go.service
        fi
cat > ${systempwd}trojan-go.service <<-EOF
    [Unit]  
    Description=trojan-go
    After=network.target  
       
    [Service]  
    Type=simple  
    PIDFile=/usr/local/trojan-go/trojan-go.pid
    ExecStart=/usr/local/trojan-go/trojan-go -config "/usr/local/trojan-go/config.json"  
    ExecReload=  
    ExecStop=/usr/local/trojan-go/trojan-go 
    PrivateTmp=true  
       
    [Install]  
    WantedBy=multi-user.target
EOF

    	chmod +x ${systempwd}trojan-go.service
    	systemctl start trojan-go.service
    	systemctl enable trojan-go.service
        service caddy start
        
    	green "======================================================================"
    	green "Trojan Go已安装完成，连接信息"
    	green "端口:${trojan_local_port} 密码：${trojan_passwd}"    
    	#else
        #    red "================================"
    	#red "https证书没有申请成果，本次安装失败"
    	#red "================================"
    	#fi
    	
}

function remove_trojan(){
    red "================================"
    red "即将卸载trojan"
    red "================================"
    systemctl stop trojan-go
    systemctl disable trojan-go
    rm -f ${systempwd}trojan-go.service
    rm -rf /usr/local/trojan-go*
    green "=============="
    green "trojan-go删除完毕"
    green "=============="
}

#function bbr_boost_sh(){
    #bash <(curl -L -s -k "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh")
#}

start_menu(){
    clear
    green " ===================================="
    green " Trojan Go 一键安装自动脚本      "
    green " 系统：centos7+/debian9+/ubuntu16.04+"
    green " 网站：www.v2rayssr.com （已开启禁止国内访问）              "
    green " 此脚本为 atrandys 的，波仔集成了BBRPLUS加速 "
    green " Youtube：波仔分享                "
    green " ===================================="
    echo
    red " ===================================="
    yellow " 1. 一键安装 Trojan Go"
    red " ===================================="
    #yellow " 2. 安装 4 IN 1 BBRPLUS加速脚本"
    #red " ===================================="
    yellow " 2. 一键卸载 Trojan Go"
    red " ===================================="
    yellow " 0. 退出脚本"
    red " ===================================="
    echo
    read -p "请输入数字:" num
    case "$num" in
    1)
    install_trojan
    ;;
    20)
    bbr_boost_sh 
    ;;
    2)
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