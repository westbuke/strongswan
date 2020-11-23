#!/usr/bin/make

PKG = tkm-rpc
SRC = https://git.codelabs.ch/git/$(PKG).git
REV = 4e7d4436641e1ee11f9f9c54b6db20b21452d217

PREFIX = /usr/local/ada

export ADA_PROJECT_PATH=$(PREFIX)/lib/gnat

all: install

.$(PKG)-cloned:
	[ -d $(PKG) ] || git clone $(SRC) $(PKG)
	@touch $@

.$(PKG)-checkout-$(REV): .$(PKG)-cloned
	cd $(PKG) && git fetch && git checkout $(REV)
	@rm -f .$(PKG)-checkout-* && touch $@

.$(PKG)-built-$(REV): .$(PKG)-checkout-$(REV)
	cd $(PKG) && make
	@rm -f .$(PKG)-built-* && touch $@

install: .$(PKG)-built-$(REV)
	cd $(PKG) && make PREFIX=$(PREFIX) install
