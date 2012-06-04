#!/usr/bin/env bash
# Habilita el msn

if [ -f /etc/gandalf/gandalf.conf ]; then
  source /etc/gandalf/gandalf.conf
fi

INTERFACES=($INET_INTERFACE);

hab_msn () {
  $IPTABLES_BIN -A INPUT -i $1 -p tcp -m tcp --sport 1863 -m state --state RELATED,ESTABLISHED -j ACCEPT
  $IPTABLES_BIN -A OUTPUT -o $1 -p tcp -m tcp --dport 1863 -j ACCEPT
  $IPTABLES_BIN -A INPUT -i $1 -p tcp -m tcp --sport 6891:6901 -m state --state RELATED,ESTABLISHED -j ACCEPT
  $IPTABLES_BIN -A OUTPUT -o $1 -p tcp -m tcp --dport 6891:6901 -j ACCEPT
  $IPTABLES_BIN -A INPUT -i $1 -p udp -m udp --sport 6901 -m state --state RELATED,ESTABLISHED -j ACCEPT
  $IPTABLES_BIN -A OUTPUT -o $1 -p udp -m udp --dport 6901 -j ACCEPT
  echo $1 en $2  
}

hab_msn_gw () {
  $IPTABLES_BIN -A INPUT -i $1 -p tcp -m tcp --sport 80 -s $2 -m state --state RELATED,ESTABLISHED -j ACCEPT
  $IPTABLES_BIN -A OUTPUT -o $1 -p tcp -m tcp --dport 80 -d $2 -j ACCEPT
  $IPTABLES_BIN -A INPUT -i $1 -p tcp -m tcp --sport 443 -s $2 -m state --state RELATED,ESTABLISHED -j ACCEPT
  $IPTABLES_BIN -A OUTPUT -o $1 -p tcp -m tcp --dport 443 -d $2 -j ACCEPT
  echo $1 en $2
}

for interface in $INTERFACES; do

  hab_msn $interface
  
  servers=$(resolveip gateway.messenger.hotmail.com | cut -d " " -f 6)

  for h in $servers; do
    hab_msn_gw $interface $h
  done

  

done
