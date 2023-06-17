#!/bin/bash
BGGREEN='\e[1;42'
BGBLUE='\e[1;44m'
ORANGE='\033[0;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0;37m'
BGRED='\e[1;41m'
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
echo -e ""
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}                     ┃ V2RAY/VMESS ┃                              ${NC}"
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/v2ray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
read -p "SNI (BUG)     : " sni
read -p "Bug Address (Example: www.google.com) : " sub
dom=$sub$domain
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/v2ray/config.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/v2ray/none.json
cat>/etc/v2ray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${dom}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/v2ray",
      "type": "none",
      "host": "${sni}",
      "tls": "tls"
}
EOF
cat>/etc/v2ray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${dom}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/v2ray",
      "type": "none",
      "host": "${sni}",
      "tls": "none"
}
EOF
cat>/etc/v2ray/$user-digiapn.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "{api-useinsider.com}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/v2ray",
      "type": "none",
      "host": "${sni}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(base64 -w 0 /etc/v2ray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /etc/v2ray/$user-none.json)"
vmesslink3="vmess://$(base64 -w 0 /etc/v2ray/$user-digiapn.json)"
systemctl restart v2ray
systemctl restart v2ray@none
service cron restart
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e ""
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}                     ┃ V2RAY/VMESS ┃                              ${NC}"
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
echo -e "Remarks        : ${user}"
echo -e "IP Server      : $MYIP"
echo -e "Domain         : ${domain}"
echo -e "Subdomain      : ${dom}"
echo -e "port TLS       : ${tls}"
echo -e "port none TLS  : ${none}"
echo -e "id             : ${uuid}"
echo -e "alterId        : 0"
echo -e "Security       : auto"
echo -e "network        : ws"
echo -e "path           : /v2ray"
echo -e "SNI            : $sni"
echo -e " ${ORANGE}=================================${NC}"
echo -e "link TLS       : ${vmesslink1}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "link none TLS  : ${vmesslink2}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "link none TLS  : ${vmesslink3}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "Created   : $hariini"
echo -e "Expired   : $exp"