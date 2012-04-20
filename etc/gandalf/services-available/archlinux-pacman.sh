#!/usr/bin/env bash
# Lee los hosts usados para la descarga de paquetes y los habilita 

if [ -f /etc/gandalf/gandalf.conf ]; then
  source /etc/gandalf/gandalf.conf
fi

CONFIG_FILE=/etc/pacman.d/mirrorlist

if [ -f $CONFIG_FILE ]; then
  servers=$(cat $CONFIG_FILE | egrep "^Server" | cut -d "/" -f 3)
  for h in $servers; do

      echo "Por repo de archlinux $h:"

      ips=$(resolveip $h | cut -d " " -f 6)

      for ip in $ips; do
        hab_host $ip
      done

  done

fi

