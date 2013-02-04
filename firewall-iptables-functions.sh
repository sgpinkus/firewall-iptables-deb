# Set the out of the box default iptables policy.
#
function set_default_policy()
{
  clear_firewall_chains
  clear_forward_chains
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

function set_firewall_rules()
{
  clear_firewall_chains
  # iptables -P INPUT DROP
  # Firewall. Add our chains so we can modularize.
  iptables -t filter -N gw_firewall_filter_input
  iptables -A gw_firewall_filter_input -m comment --comment "firewall-iptables firewall rules"
  # We can talk to ourselves freely. Allow all outgoing connections we start.
  # Allowing ssh, http, https, vnc - youll have to come and edit this as your firewall rules!
  iptables -A gw_firewall_filter_input -i lo -j ACCEPT
  iptables -A gw_firewall_filter_input -p icmp -j ACCEPT
  iptables -A gw_firewall_filter_input -m state --state RELATED,ESTABLISHED -j ACCEPT
  # iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
  [[ -n $INBOUND_TCP_ALLOW ]] && iptables -A gw_firewall_filter_input -p tcp -m multiport --destination-port $INBOUND_TCP_ALLOW -j ACCEPT
  [[ -n $INBOUND_UDP_ALLOW ]] && iptables -A gw_firewall_filter_input -p udp -m multiport --destination-port $INBOUND_UDP_ALLOW -j ACCEPT
  #iptables -A INPUT -j LOG
  if [[ -n "FIREWALL_DO_REJECT" ]]; then
    iptables -A gw_firewall_filter_input -j REJECT
  fi
  iptables -A INPUT -j gw_firewall_filter_input
}

function set_forward_rules()
{
  [[ -z "$EXTIF" ]] && echo "Error: EXTIF undefined" && return 1
  [[ -z "$INTIF" ]] && echo "Error: INTIF undefined" && return 1
  clear_forward_chains
  iptables -t filter -N gw_firewall_filter_forward
  iptables -t nat -N gw_firewall_nat_postrouting
  iptables -A gw_firewall_filter_forward -m comment --comment "firewall-iptables forwarding rules. External: $EXTIF, Internal: $INTIF."
  echo "   Allowing all connections OUT and only existing and related ones IN"
  iptables -A gw_firewall_filter_forward -i $EXTIF -o $INTIF -m state --state ESTABLISHED,RELATED -j ACCEPT
  iptables -A gw_firewall_filter_forward -i $INTIF -o $EXTIF -j ACCEPT
  #iptables -A gw_firewall_filter_forward -j LOG
  echo "   Enabling SNAT (MASQUERADE) functionality on $EXTIF"
  iptables -t nat -A gw_firewall_nat_postrouting -o $EXTIF -j MASQUERADE
  iptables -A FORWARD -j gw_firewall_filter_forward
  iptables -t nat -A POSTROUTING -j gw_firewall_nat_postrouting
}

function clear_firewall_chains()
{
  if chain_exists filter gw_firewall_filter_input; then
    iptables -t filter -D INPUT -j gw_firewall_filter_input
    iptables -t filter -F gw_firewall_filter_input
    iptables -t filter -X gw_firewall_filter_input
  fi
}

function clear_forward_chains()
{
  if chain_exists filter gw_firewall_filter_forward; then
    iptables -t filter -D FORWARD -j gw_firewall_filter_forward 2>/dev/null
    iptables -t filter -F gw_firewall_filter_forward 2>/dev/null
    iptables -t filter -X gw_firewall_filter_forward 2>/dev/null
  fi
  if chain_exists nat gw_firewall_nat_postrouting; then
    iptables -t nat -D POSTROUTING -j gw_firewall_nat_postrouting 2>/dev/null
    iptables -t nat -F gw_firewall_nat_postrouting 2>/dev/null
    iptables -t nat -X gw_firewall_nat_postrouting 2>/dev/null
  fi
}
