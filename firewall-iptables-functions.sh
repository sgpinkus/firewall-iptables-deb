# Set the out of the box default iptables policy.
#
function set_default_policy()
{
  iptables -P INPUT ACCEPT
  iptables -F INPUT
  iptables -P OUTPUT ACCEPT
  iptables -F OUTPUT
  iptables -P FORWARD DROP
  iptables -F FORWARD
  iptables -t mangle -F
  iptables -t mangle -X
  iptables -t nat -F
  iptables -t nat -X
  iptables -t filter -F
  iptables -t filter -X
  iptables -t raw -F
  iptables -t raw -X
  iptables -Z # Reset all IPTABLES counters
}

function chain_exists()
{
  iptables -t "$1" -n --list "$2" >/dev/null 2>&1
  return $?
}
