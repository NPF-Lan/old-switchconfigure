#!/bin/bash
DIALOG=${DIALOG=dialog}
MENU=/tmp/menu.sh.$$
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/switchconfigure$$
trap "rm -f $tempfile 2>/dev/null; rm $MENU 2>/dev/null" 0 1 2 5 15

database=switches.db;


menu_switchbyid(){
$DIALOG --title "NPF Switch Configurator & Stuff" --clear \
	--inputbox "SWITCH NUMMER:" 16 51 2> $tempfile

switch_id=$?

case $switch_id in
	0)
	input_id=`cat $tempfile`
	get_switch $input_id
	switch_name=${SWITCH[0]}
	switch_ip=${SWITCH[1]}
	switch_gw=${SWITCH[2]}
	switch_vlan=${SWITCH[3]}
	menu_switch_type
	;;
esac
}

menu_switch_type(){
$DIALOG --title "NPF Switch Configurator & Stuff" --clear \
	--menu "Vælg den switch type du er ved at konfigurere og tryk enter" \
	18 60 12 \
	`find . -name \*.exp| while read filename; do echo "$filename $filename"; done`  2> $tempfile

	switch_type=`cat $tempfile`
	do_expect $switch_type
}


menu(){
$DIALOG --clear --backtitle "NPF Switch Something Something... Darkside" \
--title "Menu" \
--menu "something" 15 50 4 \
ConfigurebyID "Configure by switch id" \
ResetSwitch "Reset switch" \
OpenConsole "Open Console" \
Exit "Exit" 2>$MENU
}


get_switch(){
local return=`sqlite3 $database "select name, ip, gw, vlan from switches where name = '$1'"`;
#echo $return;
IFS='|' read -ra SWITCH <<< "$return"
}

do_expect(){
screen -dmS switch /dev/ttyUSB0 9600
$1 $switch_name $switch_ip $switch_gw $switch_vlan
killall screen
exit
}

reset_switch(){
$DIALOG --title "NPF Switch Configurator & Stuff" --clear \
	--menu "Vælg den switch type du er ved at konfigurere og tryk enter" \
	18 60 12 \
	`find . -name reset_\*.exp| while read filename; do echo "$filename $filename"; done`  2> $tempfile

	switch_type=`cat $tempfile`
	do_expect $switch_type
}

open_console(){
source console.bash
}

while true
do
menu

menuitem=$(<"${MENU}")

case $menuitem in
	ConfigurebyID)
	menu_switchbyid
	;;
	UpdateFirmware)
	menu_firmware
	;;
	ResetSwitch)
	reset_switch
	;;
	OpenConsole)
	open_console
	;;
	Exit) break;;
	255) break;;
	Cancel) break;;
esac
done

[ -f $MENU ] && rm $MENU
[ -f $tempfile ] && rm $tempfile
