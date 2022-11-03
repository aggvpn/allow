#!/bin/bash

dnsReqv1() {
  read etc
  echo 'nameserver 103.161.133.217' > /etc/resolv.conf
  echo -e "YOUR DNS DONE ENTER : $etc"

  dns
}

encryptReqv2() {
  read head
  echo 'nameserver 103.161.133.217' > /etc/resolvconf/resolv.conf.d/head
  echo -e "YOUR DNS DONE ENTER : $head"

  dns
}

clear
echo -e "\033[4;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
figlet DNS | lolcat
echo -e "\033[4;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[4;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[41;1;39m                ⇱ DNS MENU ⇲                  \E[0m"
echo -e "\033[4;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"                                                                                         
echo -e "\033[4;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "[\033[0;32m01\033[0m] • DNS TAK KEKAL        [\033[0;32m02\033[0m] • DNS KEKAL"
echo -e ""
echo -e "\033[4;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -ne "Select menu : "
read x

case "$x" in
1 | 01)
  clear
  dnsReqv1
  ;;
2 | 02)
  clear
  dnsReqv2
  ;;
*)
  clear
  dns
  ;;
esac
