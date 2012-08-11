#!/usr/bin/env bash
# Lee los hosts usados para la sincronizacion horaria y los habilita

if [ -f /etc/gandalf/gandalf.conf ]; then
  source /etc/gandalf/gandalf.conf
fi

INTERFACES=($INET_INTERFACE);
CONFIG_FILE=/etc/ntp.conf

hab_ntp() {
  $IPTABLES_BIN -A INPUT -i $1 -s $2 -p udp -m udp --sport 53 -j ACCEPT
  $IPTABLES_BIN -A OUTPUT -o $1 -d $2 -p udp -m udp --dport 53 -j ACCEPT
  echo "Habilitando $2 para consultas de NTP en la interface $1"
}

for interface in $INTERFACES; do

  # Veo si hay servers de NTP configurados y los habilito
  if [ -f $CONFIG_FILE ]; then
    ntp_servers=$(cat $CONFIG_FILE | egrep "^server" | cut -d " " -f 2)
    for h in $ntp_servers; do
      hab_ntp $interface $h
    done
  fi

done