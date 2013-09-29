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
	cp firewall-iptables.defaults $(DESTDIR)/etc/default/firewall-iptables
	cp firewall-iptables-checkmodules $(DESTDIR)/$(BINDIR)/

	


