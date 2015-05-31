vim := /usr/bin/env vim

test: vendor/vimrc
	@env HOME=$(shell pwd)/vendor ${vim} -Nu $< +"Vader! test/*"

vim: vendor/vimrc
	@env HOME=$(shell pwd)/vendor ${vim} -Nu $<

vendor/vimrc: vendor/vader.vim
	@mkdir -p ./vendor
	@echo "filetype off" > $@
	@echo "set rtp+=vendor/vader.vim" >> $@
	@echo "if has('\$$test_endwise') | set rtp+=vendor/vim-endwise | endif" >> $@
	@echo "set rtp+=." >> $@
	@echo "filetype plugin indent on" >> $@
	@echo "syntax enable" >> $@

vendor/vader.vim:
	@mkdir -p ./vendor
	@git clone https://github.com/junegunn/vader.vit.git ./vendor/vader.vim

vendor/vim-endwise.vim:
	@mkdir -p ./vendor
	@git clone https://github.com/tpope/vim-endwise.git ./vendor/vim-endwise

.PHONY: test vendor/vimrc doc
