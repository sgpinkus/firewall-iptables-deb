# Overview
Simple iptable firewall setup. We break out actual rules to thte directory /etc/firewall-iptables/rules.d/ and run them with `run-parts start|stop`. this makes thing more customizable, while remaining coherent. So basically the "firewall" init script is just symbolic.

# Installation
Copy the files in place manually from debian/ dir or build and install the .deb:

    https://github.com/sam-at-github/firewall-iptables-deb;
    cd firewall-iptables/ && dpkg-buildpackage -b -uc -us && cd -
    sudo dpkg -i firewall-iptables_*.deb
