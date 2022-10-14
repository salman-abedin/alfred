.POSIX:
DIR_BIN = /usr/local/bin
init:
	@echo Initiation finished.
install:
	@mkdir -p $(DIR_BIN)
	@for script in src/*; do \
		cp -f $$script $(DIR_BIN); \
		chmod 755 $(DIR_BIN)/$${script##*/}; \
		done
	@echo Installation finished.
uninstall:
	@for script in src/*; do rm -f $(DIR_BIN)/$${script##*/}; done
	@echo Uninstallation finished.
.PHONY: init install uninstall
