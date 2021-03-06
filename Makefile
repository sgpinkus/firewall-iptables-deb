# Simple makefile.
DESTDIR=/
BINDIR=/usr/bin/
INITDIR=/etc/init.d/
CONFDIR=/etc/default/
FIREWALL_CONFFILE=$(CONFDIR)/firewall-iptables
FIREWALL_SCRIPT_DIR=/etc/firewall-iptables/scripts.d/

.EXPORT_ALL_VARIABLES:

all:
	# ... firewall-iptables.in > firewall-iptables

clean:

install:
	mkdir -p $(DESTDIR)/$(INITDIR)
	mkdir -p $(DESTDIR)/$(BINDIR)
	mkdir -p $(DESTDIR)/$(CONFDIR)
	mkdir -p $(DESTDIR)/$(FIREWALL_SCRIPT_DIR)
	cp firewall-iptables $(DESTDIR)$(INITDIR)
	cp firewall-iptables-checkmodules $(DESTDIR)/$(BINDIR)/
	cp -a scripts.d/* $(DESTDIR)/$(FIREWALL_SCRIPT_DIR)
	cp firewall-iptables.conf $(DESTDIR)/$(CONFDIR)/firewall-iptables
