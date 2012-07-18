#!/usr/bin/env bash
# Lee los hosts usados para nameserver y los habilita

if [ -f /etc/gandalf/gandalf.conf ]; then
  source /etc/gandalf/gandalf.conf
fi

$IPTABLES_BIN -A INPUT -p icmp -j ACCEPT
$IPTABLES_BIN -A OUTPUT -p icmp -j ACCEPT 
