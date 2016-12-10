# Common prefix for installation directories.
# https://www.gnu.org/prep/standards/html_node/Directory-Variables.html#Directory-Variables
# This directory must exist when you start the install:
prefix = /usr/local
datarootdir = $(prefix)/share
datadir = $(datarootdir)
exec_prefix = $(prefix)
# Where to put the executable for the command 'gcc'.
bindir = $(exec_prefix)/bin
# Where to put the directories used by the compiler.
libexecdir = $(exec_prefix)/libexec
# Where to put the Info files.
infodir = $(datarootdir)/info
sysconfdir = $(prefix)/etc

all:

clean:

install:
	mkdir -p $(DESTDIR)$(sysconfdir)/init.d/
	mkdir -p $(DESTDIR)/$(BINDIR)/
	mkdir -p $(DESTDIR)$(sysconfdir)/default/
	mkdir -p $(DESTDIR)$(sysconfdir)/firewall-iptables/
	cp firewall-iptables $(DESTDIR)$(sysconfdir)/init.d/
	cp -a scripts.d/ $(DESTDIR)$(sysconfdir)/firewall-iptables/
	cp firewall-iptables.defaults $(DESTDIR)$(sysconfdir)/default/firewall-iptables
	cp firewall-iptables-checkmodules $(DESTDIR)/$(bindir)/
