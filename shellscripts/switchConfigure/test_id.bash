#!/bin/bash
database=switches.db

get_switch(){
local return=`sqlite3 $database "select name, ip, gw, vlan from switches where name = '$1'"`;
echo $return;
IFS='|' read -ra SWITCH <<< "$return"
}

get_switch $1
