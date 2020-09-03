.POSIX:
BIN_DIR = /usr/local/bin
install:
	@mkdir -p $(BIN_DIR)
	@for e in src/*.sh; do \
		cp -f $$e $${e%.*}; \
		chmod 755 $${e%.*}; \
		mv $${e%.*} $(BIN_DIR); \
		done
	@echo Done installing the executable files.
uninstall:
	@for e in src/*.sh;do \
		rm -f $(BIN_DIR)/$${e%.*}; \
		done
	@echo Done removing executable files.
.PHONY: install uninstall
