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

# // Vless
vless1="$( cat /etc/xray-mini/vless-direct.json | grep -w port | awk '{print $2}' | sed 's/,//g' )"
vless2="$( cat /etc/xray-mini/vless-splice.json | grep -w port | awk '{print $2}' | sed 's/,//g' )"
echo -e ""
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}                     ┃ XRAYS/AUTO BUG ┃                              ${NC}"
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray-mini/vless-direct.json | wc -l)

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

# // Input To Server
sed -i '/#XRay$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-direct","email": "'""$user""'"' /etc/xray-mini/vless-direct.json
sed -i '/#XRay$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-splice","email": "'""$user""'"' /etc/xray-mini/vless-splice.json

vlesslink1="vless://${uuid}@${dom}:${vless1}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=maingame.com.my#${user}"
vlesslink3="vless://${uuid}@${dom}:${vless1}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=$ulist.com.my#${user}"
vlesslink4="vless://${uuid}@${dom}:${vless1}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=$mm.net.my#${user}"
vlesslink5="vless://${uuid}@${dom}:${vless1}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=$m.erosnow.com#${user}"
vlesslink6="vless://${uuid}@${dom}:${vless1}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=$music.u.com.my#${user}"
vlesslink7="vless://${uuid}@${dom}:${vless1}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=$wap.u.com.my#${user}"

# // Restarting Service
systemctl stop xray-mini@vless-direct
systemctl stop xray-mini@vless-splice
systemctl disable xray-mini@vless-direct
systemctl disable xray-mini@vless-splice
systemctl enable xray-mini@vless-direct
systemctl enable xray-mini@vless-splice
systemctl start xray-mini@vless-direct
systemctl start xray-mini@vless-splice
systemctl restart xray-mini@vless-direct
systemctl restart xray-mini@vless-splice

clear
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e ""
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}                     ┃ UMOBILE XRAY ┃                              ${NC}"
echo -e " ${ORANGE}══════════════════════════════════════════════════════════════════${NC}"
echo -e "Remarks        : ${user}"
echo -e "IP Server      : $MYIP"
echo -e "Domain         : ${domain}"
echo -e "Subdomain      : ${dom}"
echo -e "Port Direct    : $vless1"
echo -e "Port Splice    : $vless1"
echo -e "id             : ${uuid}"
echo -e "path           : /xray"
echo -e "SNI            : $sni"
echo -e "Created   : $hariini"
echo -e "Expired   : $exp"
echo -e " ${ORANGE}=================================${NC}"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e " ${ORANGE}=================================${NC}"
echo -e "Link UMO-1    : ${vlesslink1}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "LInk UMO-2    : ${vlesslink2}"
echo -e " ${ORANGE}=================================${NC}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "Link UMO-3    : ${vlesslink3}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "LInk UMO-4    : ${vlesslink4}"
echo -e " ${ORANGE}=================================${NC}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "Link UMO-5    : ${vlesslink5}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "LInk UMO-6    : ${vlesslink6}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "LInk UMO-7    : ${vlesslink7}"
echo -e " ${ORANGE}=================================${NC}"
echo -e "Gantikan BUG anda"
echo -e " ${ORANGE}=================================${NC}"
echo -e "Created   : $hariini"
echo -e "Expired   : $exp"