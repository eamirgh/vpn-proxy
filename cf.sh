#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

apt install jq curl -y
IP=$(wget -qO- icanhazip.com)
DOMAIN=gilergames.test
#sub=$(</dev/urandom tr -dc a-z0-9 | head -c4)
echo "    Cloudflare with SNI Bug "
echo "Enter your ISPbughost pointed VPS IP "
read -rp " Enteer : " -e host
SUB_DOMAIN=${sub}.gilergames.test
set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=xxxxxx
RECORD=xxxxxx
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/xxxxxx/dns_records" \
     -H "Content-Type: application/json" \
     -H "X-Auth-Email: email@gmail.test" \
     -H "X-Auth-Key: xxxxxx" \
     --data '{"type":"A","name":"${sub}.gilergames.test","content":"${IP}","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/xxxxxx/dns_records/${sub}.gilergames.test" \
     -H "X-Auth-Email: email@gmail.test" \
     -H "X-Auth-Key: xxxxxx" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"${sub}.gilergames.test","content":"$IP","ttl":120,"proxied":false}')
echo "IP=$SUB_DOMAIN" > /var/lib/premium-script/ipvps.txt
echo $SUB_DOMAIN > /root/domain
rm -f /root/cf.sh
