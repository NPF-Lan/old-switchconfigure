#!/bin/bash

for a in `seq 2 24`; do
vlan=$(expr 100 + $a );
echo "vlan $vlan
   name \"VLAN$vlan\"
   untagged A$a
   tagged Trk1
   ip address 192.168.$a.1 255.255.255.0
   ip helper-address 10.10.10.10
   exit";
done