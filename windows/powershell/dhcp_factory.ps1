101..148|ForEach-Object { 
$vlan = $_; 
$bord = $vlan - 100; 
$startip = "192.168.$bord.10"; 
$slutip = "192.168.$bord.200"; 
$gateway = "192.168.$bord.1";
$gateway2 = "192.168.$bord.2";
$dns1 = "10.10.10.100";
$dns2 = "10.10.10.101";
$dns = $dns1,$dns2;
$scopeid = "Bord $bord vlan $vlan";
$gatewayarray = $gateway,$gateway2;
echo $scopeid
#Add-DhcpServerv4Scope -ComputerName dhcpwin -EndRange "$slutip" -StartRange "$startip" -Name "$scopeid" -State Active -SubnetMask "255.255.255.0";
Set-DhcpServerv4OptionValue -ComputerName dhcpwin -ScopeId "192.168.$bord.0" -Router $gatewayarray -DnsServer $dns;
#remove-dhcpserverv4scope -ComputerName dhcpwin -ScopeId "172.$vlan.$bord.0"
}
