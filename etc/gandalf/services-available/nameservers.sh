#!/usr/bin/env bash
# Lee los hosts usados para nameserver y los habilita

if [ -f /etc/gandalf/gandalf.conf ]; then
  source /etc/gandalf/gandalf.conf
fi

INTERFACES=($INET_INTERFACE);

hab_dns() {
  $IPTABLES_BIN -A INPUT -i $1 -s $2 -p udp -m udp --sport 53 -j ACCEPT
  $IPTABLES_BIN -A OUTPUT -o $1 -d $2 -p udp -m udp --dport 53 -j ACCEPT
  
  echo "Habilitando $2 para consultas de DNS en la interface $1"
}

for interface in $INTERFACES; do

  # Leo los resolv's hosts para darle permiso a DNS:

  dns_servers=$(cat /etc/resolv.conf | egrep "^nameserver" | cut -d " "  -f 2)

  for h in $dns_servers; do
    hab_dns $interface $h
  done

done