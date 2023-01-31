.PHONY: help

# Show this help.
help:
	@awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t

# Backup old ~/.bashrc and create new for reference.
install: 
	cp ~/.bashrc ~/.bashrc.bkp
	echo "source ~/.dotfiles/.bashrc" > ~/.bashrc