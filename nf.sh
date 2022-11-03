#!/bin/bash

dnsReqv1() {
  echo 'nameserver 103.161.133.217' > /etc/resolv.conf
  clear
  echo -e '\e[0;32mDONE \033[0m'
  echo -e ''
  echo -e "YOUR ENCRYPTED FILE PATH : $dir"
  read -n 1 -s -r -p "Press any key to back on menu"

  dns
}

encryptReqv2() {
  echo 'nameserver 103.161.133.217' > /etc/resolvconf/resolv.conf.d/head
  clear
  echo -e '\e[0;36mDONE ENCRYPT\033[0m'
  echo -e ''
  echo -e "YOUR ENCRYPTED FILE PATH : $dir"
  read -n 1 -s -r -p "Press any key to back on menu"

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
