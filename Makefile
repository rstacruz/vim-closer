vim := /usr/bin/env vim

test: vendor/vimrc
	@env HOME=$(shell pwd)/vendor ${vim} -Nu $< +"Vader! test/*"

vim: vendor/vimrc
	@env HOME=$(shell pwd)/vendor ${vim} -Nu $<

vendor/vimrc: vendor/vader.vim
	@mkdir -p ./vendor
	@echo "filetype off" > $@
	@echo "set rtp+=$<" >> $@
	@echo "set rtp+=." >> $@
	@echo "filetype plugin indent on" >> $@
	@echo "syntax enable" >> $@

vendor/vader.vim:
	@mkdir -p ./vendor
	@git clone https://github.com/junegunn/vader.vim ./vendor/vader.vim

.PHONY: test vendor/vimrc doc
