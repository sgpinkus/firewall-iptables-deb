firewall-iptables-deb
=====================

Simple iptables firewall with port forwarding, setup as a inserv init script.
Mostly copied from David A. Ranch - http://www.ecst.csuchico.edu/~dranch. Rewritten here as an debian init script.
You'll want to edit port list, and interface names in this file.
Use firewall-checkmodules to check you have the required kernel modules available.

Installation:

  git clone [this] && cd firewall-iptables-deb/
  sudo cp firewall-iptables-deb /etc/init.s
  sudo update-rc.d firewall-iptables-deb enable
  sudo service firewall-iptables-deb start

