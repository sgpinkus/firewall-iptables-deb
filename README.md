# Overview
Simple iptables firewall setup packaged as a debian init script. Based off tutorial by David A. Ranch at  http://www.ecst.csuchico.edu/~dranch. We break out actual rules to directory `/etc/firewall-iptables/scripts.d/` and run them with `run-parts start|stop`. This makes thing more customizable, while still remaining coherent and easy to manage over just running a bunch of iptables add commands somewhere.

# Installation
Copy the files in place manually from debian/ dir or build and install the .deb:

    https://github.com/sam-at-github/firewall-iptables-deb;
    cd firewall-iptables/ && dpkg-buildpackage -b -uc -us && cd -
    sudo dpkg -i firewall-iptables_*.deb
