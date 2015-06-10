#!/bin/bash

for a in `seq 2 24`; do
vlan=$(expr 100 + $a );
rulenumber=$(expr 5003 + $a);
echo "rule $rulenumber {
description \"bord $a\"
log disable
outbound-interface eth5
outside-address {
}
protocol all
source {
address 192.168.$a.0/24
}
type masquerade
}
";
done