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
  if [[ -n `iptables -t "$1" --list "$2" 2>/dev/null` ]]; then
    return 0
  fi
  return 1
}
