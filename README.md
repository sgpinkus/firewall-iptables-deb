# Overview
Simple iptables firewall setup packaged as a debian init script. Based off tutorial by David A. Ranch at  http://www.ecst.csuchico.edu/~dranch. We've broken out actual rules scripts in directory `/etc/firewall-iptables/scripts.d/` which are run in alphabetical order on start|stop. This makes things more customizable and easy to manage.

# Installation
To install as a .deb package:

    git clone git@github.com:sgpinkus/firewall-iptables-deb.git
    cd firewall-iptables/
    dpkg-buildpackage -b -uc -us
    cd -
    sudo dpkg -i firewall-iptables_*.deb

Alternatively you can use the Makefile:

    make
    sudo make install

# Configuration
All configuration for built in scripts is via vars in /etc/default/firewall-iptables. See the defaults.

# Usage
Should be installed as a service as above, and used like `service firewall-iptables {start|stop|restart|force-reload}`. The built-in individual scripts can also be used like `CONFFILE=./firewall-iptables.conf ./scripts.d/001-forward {start|stop}`.
