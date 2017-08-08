set fileencodings=utf-8
set autoread " autorefresh files changed outside of VIM
set laststatus=2 " required for vim-arline plugin 
set ul=500 " bigges undo buffer
syntax on
:color desert

set clipboard=unnamed " yank to system clipboard 
set incsearch " search on typing
set wildmenu " suggests vim command parameters

" if next line does not fit on screen display partial lines insted of @
set display+=lastline 

" pretty : set list chars
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
Plugin 'visSum.vim' " simple sum for selected numbers (works for visual selection too), just do \su
Plugin 'majutsushi/tagbar' " shows source file structure (tags) in sidebar
Plugin 'marijnh/tern_for_vim' " javascript syntax support (tagbar and autocomplete)
Plugin 'tpope/vim-surround' " easy text surrounding with parentheses, brackets, quotes, etc.
Plugin 'tpope/vim-classpath' " sets classpath when java files are opened - allows find and gf to work
Plugin 'artur-shaik/vim-javacomplete2' " autocomplete for java
Plugin 'xolox/vim-misc' " required for easytags
Plugin 'xolox/vim-easytags' " quick ctags generator
Plugin 'brookhong/cscope.vim' " better ctags with cscope
Plugin 'easymotion/vim-easymotion' " visualize motions - requires double <leader> to work ! ex: <leader><leader>s

" force typescript for ts files
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" required for javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <F7> <Plug>(JavaComplete-Imports-AddMissing)
imap <F7> <Plug>(JavaComplete-Imports-AddMissing)
nmap <F9> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F9> <Plug>(JavaComplete-Imports-RemoveUnused)

" quik open ctags definition in vertical split
map <F3> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

" run current file in batch with F5
map <F5> <Esc>:w<CR>:!%:p<CR>
imap <F5> <Esc>:w<CR>:!%:p<CR>
map <F6> :w!<CR>
imap <F6> <Esc>:w!<CR>h

map <F12> <Esc>:qa!<CR>

nnoremap <C-s> :w!<CR>
inoremap <C-s> <Esc>:w!<CR>h

map <F7> :w!<CR>:call VimuxRunCommand("clear; " . bufname("%:p"))<CR>
imap <F7> <Esc>:w!<CR>:call VimuxRunCommand("clear; " . bufname("%:p"))<CR>h
map <C-a> :w!<CR>:call VimuxRunCommand("clear; cd " . expand("%:p:h") . "; " . expand("%:p"))<CR>
imap <C-a> <Esc>:w!<CR>:call VimuxRunCommand("clear; cd" . expand("%:p:h") . ";" . expand("%:p"))<CR>h

" Open tabbar sidebar
nmap <F8> :TagbarToggle<CR>

" make nerd tree use one single instance of nerd tree
map <silent> <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
" open tree with F2
map <F2> <Esc>:NERDTreeToggle<CR>
imap <F2> <Esc>:NERDTreeToggle<CR>

" cscope key mapping
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>


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

" basic tab settings
set softtabstop=0 noexpandtab 
set shiftwidth=4 " indent should be exactly one tab
set tabstop=4 " make tab char 4 spaces long
set smarttab
set autoindent

" add highlight for characters that goes over 80th column 
function! Hi80Col()
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

" format XML
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" remove duplicated lines from current file
function! Uniq()
	g/^\(.*\)$\n\1$/d
endfunction

function! EditVimrc()
	:tabedit ~/.vimrc
endfunction

nnoremap  <leader>v <Esc>:call EditVimrc()<CR>
" reload vimrc on save
autocmd bufwritepost .vimrc source $MYVIMRC

command! -range -nargs=1 Entities call HtmlEntities(<line1>, <line2>, <args>)
noremap <silent> <Leader>h :Entities 0<CR>
noremap <silent> <Leader>H :Entities 1<CR>

" shows logs for app log format
function! ShowLogTimes()
	echo "Scanning log files"
	if !empty(matchstr(expand('%:t'),"log-.*"))
		echo "Log file dected"
		:v/(+\d.*)/d 
		:%s/.*(+\(\d.*\) ms).*/\1,\0/g
	else
		echo "Access file detected"
		:%s/.*" \(\d\{-}\.\d\{3}\) .*/\1 \0/g
	endif
	:noh
	:set nowrap
	:sort n
	normal G
endfunction

" use one color in vimdiff - this way its more readable
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
