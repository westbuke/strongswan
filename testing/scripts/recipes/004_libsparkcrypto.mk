#!/usr/bin/make

PKG = libsparkcrypto
SRC = https://github.com/Componolit/$(PKG).git
REV = 83ab9b991a530aca40da0ade42f7aa874b0f99fd

DESTDIR = /usr/local/ada/lib/gnat

all: install

.$(PKG)-cloned:
	[ -d $(PKG) ] || git clone $(SRC) $(PKG)
	@touch $@

.$(PKG)-checkout-$(REV): .$(PKG)-cloned
	cd $(PKG) && git fetch && git checkout $(REV)
	@rm -f .$(PKG)-checkout-* && touch $@

.$(PKG)-built-$(REV): .$(PKG)-checkout-$(REV)
	cd $(PKG) && make NO_SPARK=1 NO_TESTS=1
	@rm -f .$(PKG)-built-* && touch $@

install: .$(PKG)-built-$(REV)
	cd $(PKG) && make NO_SPARK=1 NO_TESTS=1 DESTDIR=$(DESTDIR) install
