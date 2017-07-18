set fileencodings=utf-8
set autoread " autorefresh files changed outside of VIM
set laststatus=2 " required for vim-arline plugin 
syntax on
:color desert

set clipboard=unnamed " yank to system clipboard 
set autoindent
set smarttab
set incsearch " search on typing
set wildmenu " suggests vim command parameters

" if next line does not fit on screen display partial lines insted of @
set display+=lastline 

" prett : set list chars
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" add underline for current line
set cursorline

" limit signify to svn and git
let g:signify_vcs_list = ['svn', 'git']

" add line numeration column
set number
set relativenumber

" turn on mouse for all events
set mouse=a

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree' " file tree navigator
Plugin 'leafgarland/typescript-vim'
Plugin 'quramy/tsuquyomi'
Plugin 'jistr/vim-nerdtree-tabs' " file tree and tabs integration 
Plugin 'tpope/vim-fugitive' " git integration 
Plugin 'gregsexton/gitv' " git visualization
Plugin 'scrooloose/syntastic' " source code syntax verification (python etc) 
Plugin 'vim-airline/vim-airline' " fancy statusbar 
Plugin 'ctrlpvim/ctrlp.vim' " file searcher 
Plugin 'christoomey/vim-tmux-navigator' " tmux integration
Plugin 'benmills/vimux' " tmux integration
Plugin 'sjl/vitality.vim' " integration with iterm2 and tmux - better cursor shape for insert mode
Plugin 'mhinz/vim-signify' " shows changes for current file (svn and git)
Plugin 'christianrondeau/vim-base64' " base64 decoding and encoding - <leader>btoa and <leader>atob
Plugin 'tpope/vim-jdaddy' " pretty print json - gqaj
Plugin 'ervandew/supertab' " easier inert mode completion with tab key
" disabled - problems with error 413
" Plugin 'valloric/youcompleteme'

" force typescript for ts files
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" run current file in batch with F5
map <F5> <Esc>:w<CR>:!%:p<CR>
imap <F5> <Esc>:w<CR>:!%:p<CR>
map <F6> :w!<CR>
imap <F6> <Esc>:w!<CR>h
 
map <F7> :w!<CR>:call VimuxRunCommand("clear; " . bufname("%:p"))<CR>
imap <F7> <Esc>:w!<CR>:call VimuxRunCommand("clear; " . bufname("%:p"))<CR>h
map <C-a> :w!<CR>:call VimuxRunCommand("clear; cd " . expand("%:p:h") . "; " . expand("%:p"))<CR>
imap <C-a> <Esc>:w!<CR>:call VimuxRunCommand("clear; cd" . expand("%:p:h") . ";" . expand("%:p"))<CR>h

" make nerd tree use one single instance of nerd tree
map <silent> <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
" open tree with F2
map <F2> <Esc>:NERDTreeToggle<CR>
imap <F2> <Esc>:NERDTreeToggle<CR>

" move around tabs with ctrl

" Tab navigation like Firefox.
nnoremap <C-u> :tabprevious<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-y> :tabclose<CR>
inoremap <C-u> <Esc>:tabprevious<CR>h
inoremap <C-n> <Esc>:tabnew<CR>
inoremap <C-y> <Esc>:tabclose<CR>

" open new tab on enter in nerd tree (by default is opens new buffer)
let NERDTreeMapOpenInTab='<Space>'

call vundle#end()            " required
filetype plugin indent on    " required

" syntatic configuration (static source code verification)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:airline#extensions#tabline#enabled = 1

" file search plugin configuration (ctrl+p)
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

nnoremap ,cd :lcd %:p:h<CR>  " working director to current directory after ,cd
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" force proper tab behaviour
inoremap <Tab> <Tab>

" change to normal mode on ctrl+H
imap <C-H> <Esc>
" map semicolon to colon - allows to enter command mode with just one key
nnoremap ; :  

" add new line before current line in normal mode with Enter 
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" add space in normal mode when spacebar is hit
nnoremap <Space> i<Space><Right><ESC>
" map backspace to delete left char in normal mode
nnoremap <backspace> X

" turn on search results highlighting
set hlsearch

" change bracket highlight color to magneta
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" faster switch to normal mode - dont wait for key sequence 
set timeoutlen=1000 ttimeoutlen=0

" add highlight for characters that goes over 80th column 
function Hi80Col()
	highlight ColorColumn ctermbg=magenta
	call matchadd('ColorColumn', '\%81v', 137)
endfunction

autocmd FileType javascript call Hi80Col()
autocmd FileType python call Hi80Col()

" ecape/unescape & < > HTML entities in range (default current line).
function! HtmlEntities(line1, line2, action)
	let search = @/
	let range = 'silent ' . a:line1 . ',' . a:line2
	if a:action == 0  " must convert &amp; last
		execute range . 'sno/&lt;/</eg'
		execute range . 'sno/&gt;/>/eg'
		execute range . 'sno/&amp;/&/eg'
	else              " must convert & first
		execute range . 'sno/&/&amp;/eg'
		execute range . 'sno/</&lt;/eg'
		execute range . 'sno/>/&gt;/eg'
	endif
	nohl
	let @/ = search
endfunction

" remove duplicated lines from current file
function! Uniq()
	g/^\(.*\)$\n\1$/d
endfunction

command! -range -nargs=1 Entities call HtmlEntities(<line1>, <line2>, <args>)
noremap <silent> <Leader>h :Entities 0<CR>
noremap <silent> <Leader>H :Entities 1<CR>
