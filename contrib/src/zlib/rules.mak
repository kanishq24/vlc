# ZLIB
ZLIB_VERSION := 1.2.5
ZLIB_URL := $(SF)/libpng/zlib-$(ZLIB_VERSION).tar.gz

PKGS += zlib

$(TARBALLS)/zlib-$(ZLIB_VERSION).tar.gz:
	$(call download,$(ZLIB_URL))

.sum-zlib: zlib-$(ZLIB_VERSION).tar.gz

zlib: zlib-$(ZLIB_VERSION).tar.gz .sum-zlib
	$(UNPACK)
	$(APPLY) $(SRC)/zlib/zlib-wince.patch
	$(APPLY) $(SRC)/zlib/zlib-static.patch
	$(MOVE)

.zlib: zlib
	#$(RECONF)
	cd $< && $(HOSTVARS) ./configure --prefix=$(PREFIX) --static
	cd $< && $(MAKE) install
	touch $@
