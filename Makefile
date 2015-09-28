vim := vim

test: test-plain test-endwise

test-plain: vendor/vimrc
	@echo env HOME="$(shell pwd)/vendor" ${vim} -Nu $< +"Vader! test/*"

test-endwise: vendor/vimrc
	@env test_endwise=1 HOME="$(shell pwd)/vendor" ${vim} -Nu $< +"Vader! test/endwise/* test/*"

vim: vendor/vimrc
	@env HOME="$(shell pwd)/vendor" ${vim} -Nu $<

vendor/vimrc: vendor/vader.vim vendor/vim-endwise
	@mkdir -p ./vendor
	@echo "filetype off" > $@
	@echo "set rtp+=vendor/vader.vim" >> $@
	@echo "set rtp+=vendor/vim-endwise" >> $@
	@echo "set rtp+=." >> $@
	@echo "filetype plugin indent on" >> $@
	@echo "syntax enable" >> $@

vendor/vader.vim:
	@mkdir -p ./vendor
	@git clone https://github.com/junegunn/vader.vim.git ./vendor/vader.vim

vendor/vim-endwise:
	@mkdir -p ./vendor
	@git clone https://github.com/tpope/vim-endwise.git ./vendor/vim-endwise

.PHONY: test vendor/vimrc doc
