#!/bin/sh

if [ $# -ne 4 ]; then
  echo "$0: Requires 4 arguments. args = $*"
  exit 1
fi

nmcli con del "Wired connection 1"
nmcli con del "Wired connection 2"
nmcli con del "Wired connection 3"
nmcli con del "Wired connection 4"

nmcli con add type ethernet con-name eth1 ifname eth1 ipv4.method manual ipv4.address "$1/24" connection.autoconnect yes
nmcli con add type ethernet con-name eth2 ifname eth2 ipv4.method manual ipv4.address "$2/24" connection.autoconnect yes
nmcli con add type ethernet con-name eth3 ifname eth3 ipv4.method manual ipv4.address "$3/24" connection.autoconnect yes
nmcli con add type ethernet con-name eth4 ifname eth4 ipv4.method manual ipv4.address "$4/24" connection.autoconnect yes
