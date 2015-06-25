# Overview
Simple iptables firewall with port forwarding, setup as a inserv init scripts.
Mostly copied from D.Ranch - http://www.ecst.csuchico.edu/~dranch. Rewritten here as an debian init scripts.
You'll want to edit the default allowed port list in /etc/defaults/.
Use `firewall-iptables-checkmodules` to check you have the required kernel modules available.

# Installation
Copy the files in place manually from debian/ dir or build and install the .deb:

    https://github.com/sam-at-github/firewall-iptables-deb;
    cd firewall-iptables/ && dpkg-buildpackage -b -uc -us && cd -
    sudo dpkg -i firewall-iptables_*.deb
