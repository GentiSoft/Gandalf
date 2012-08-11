#!/usr/bin/env bash
# Habilita google talk, si cambia algo pueden consultarlo aca para arreglar:
# https://support.google.com/talk/bin/answer.py?hl=es&answer=24074

if [ -f /etc/gandalf/gandalf.conf ]; then
  source /etc/gandalf/gandalf.conf
fi

INTERFACES=($INET_INTERFACE);

hab_gtalk () {
  hab_out $1 5222
  hab_out $1 5222
  echo "Habilitando $2 para google talk"
}

for interface in $INTERFACES; do
  hab_gtalk $interface
done
