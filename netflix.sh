#!/bin/bash
set -e

droplet=netflix
interface=Wi-Fi
us_regions=( nyc1 nyc2 nyc3 )

random_region() {
  echo ${us_regions[RANDOM % ${#us_regions[@]}]}
}

_server_ip=
server_ip() {
  [ -n "$_server_ip" ] || _server_ip="$(tugboat info --name="$droplet" --attribute=ip4 --porcelain)"
  echo "$_server_ip"
}

add_client_ip() {
  ssh "
    set -x
    sudo iptables -I FRIENDS -s ${1}/32 -j ACCEPT
    iptables-save > /etc/iptables/rules.v4 || iptables-save > /etc/iptables.rules
  "
}

sudo_warmup() {
  sudo -v -p "Local root password (for changing DNS settings): "
}

tugboat() {
  if command -v tugboat &>/dev/null; then
    command tugboat "$@"
  else
    echo "Error: you need \`tugboat' to continue. To install:" >&2
    echo "  gem install tugboat" >&2
    echo "  tugboat authorize" >&2
    return 1
  fi
}

ssh() {
  command ssh "root@$(server_ip)" "$@"
}

status() {
  echo -n "DNS: "
  networksetup -getdnsservers "$interface"
  tugboat info --name="$droplet"
}

on() {
  sudo_warmup
  add_client_ip "$(curl -fsS icanhazip.com)"
  sudo networksetup -setdnsservers "$interface" "$(server_ip)"
}

off() {
  sudo_warmup
  sudo networksetup -setdnsservers "$interface" empty
}

create() {
  sudo_warmup
  key_id="$(tugboat keys | grep -o 'id: [0-9]\+' | head -1 | awk '{print $2}')"
  if [ -z "$key_id" ]; then
    echo "Error: no SSH keys stored in your DigitalOcean settings." >&2
    echo "Please visit https://cloud.digitalocean.com/settings/security and use 'Add SSH key'." >&2
    return 1
  fi
  tugboat create "$droplet" --size 512mb --image docker --region "$(random_region)" --keys "$key_id" --ip6
  tugboat wait --name="$droplet"
  sleep 10
  ssh "
    set -x
    git clone https://github.com/ab77/netflix-proxy /opt/netflix-proxy
    cd /opt/netflix-proxy
    ./build.sh
  "
  on
}

destroy() {
  off
  tugboat destroy --name="$droplet" --confirm
}

case "$1" in
ssh | status | on | off | create | destroy )
  "$@"
  ;;
* )
  echo "Unknown command. Please use one of: status on off create destroy ssh" >&2
  exit 1
  ;;
esac
