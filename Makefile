# Nuff said.

DESTDIR=/
BINDIR=/usr/bin/

all:

clean:

install:
	mkdir -p $(DESTDIR)/etc/init.d/
	mkdir -p $(DESTDIR)/$(BINDIR)/
	mkdir -p $(DESTDIR)/etc/default/
	cp firewall-iptables $(DESTDIR)/etc/init.d/
	cp firewall-iptables.conf $(DESTDIR)/etc/default/firewall-iptables
	cp forward-iptables $(DESTDIR)/etc/init.d/
	cp forward-iptables.defaults $(DESTDIR)/etc/default/forward-iptables
	cp firewall-iptables-checkmodules $(DESTDIR)/$(BINDIR)/
