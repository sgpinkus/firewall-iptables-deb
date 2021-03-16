# Overview
Simple iptables firewall setup packaged as a debian init script. Based off tutorial by David A. Ranch at  http://www.ecst.csuchico.edu/~dranch. Breaks out actual rules scripts in directory `/etc/firewall-iptables/scripts.d/` which are run in alphabetical order on start|stop. This makes things more customizable and easy to manage.

*Don't actually use this for a Linux firewall in production.* There are much better iptables frontends for managing and creating firewalls available now days like firewalld and ufw.

# Installation
To install as a .deb package:

    git clone git@github.com:sgpinkus/firewall-iptables-deb.git
    cd firewall-iptables/
    sudo gdebi build/firewall-iptables_*.deb

Alternatively you can use the Makefile:

    make
    sudo make install

# Configuration
All configuration for built in scripts is via vars in /etc/default/firewall-iptables. See the default defaults for description.

# Usage

  - Installed as a service is used like `service firewall-iptables {start|stop|restart|force-reload}`.
  - The built-in individual scripts can also be used like `FIREWALL_CONFFILE=./firewall-iptables.conf ./scripts.d/001-forward {start|stop}` w/o installing as init script.

# Debian Packaging Notes
Build a .deb file:

```
git clone git@github.com:sgpinkus/firewall-iptables-deb.git
cd firewall-iptables/
gbp dch
dch --release
dpkg-buildpackage -b -uc -us
git rm build/*.deb
mv ../firewall-iptables_*_all.deb build/
git add build/
```
