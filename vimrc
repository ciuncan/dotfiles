set shell=/bin/bash
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'moll/vim-bbye'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'scrooloose/syntastic.git'
Bundle 'vim-scripts/matlab.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'mpollmeier/vim-scalaConceal'
Plugin 'ensime/ensime-vim'
Bundle 'leafgarland/typescript-vim'
Bundle 'regedarek/ZoomWin'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'majutsushi/tagbar'
Bundle 'elzr/vim-json'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'
Plugin 'chriskempson/base16-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/closetag.vim.git'
Bundle 'othree/html5.vim.git'
Bundle 'gregsexton/MatchTag'
Bundle 'mhinz/vim-signify'
Plugin 'airblade/vim-rooter'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'cloudhead/shady.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'groenewege/vim-less'
Plugin 'ryanss/vim-hackernews'
Bundle 'clausreinke/typescript-tools.vim', {'rtp': 'vim'}
Plugin 'terryma/vim-expand-region'
Plugin 'vim-scripts/gitignore'
Plugin 'tpope/vim-endwise.git'
Bundle 'tpope/vim-repeat'
Plugin 'fatih/vim-go'
Plugin 'Shougo/neocomplete.vim'
Plugin 'exu/pgsql.vim'
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-salve.git'
Plugin 'tpope/vim-projectionist.git'
Plugin 'tpope/vim-dispatch.git'
Plugin 'tpope/vim-fireplace'


"
"following plugins looks nice, but will enable them when I feel I need them:
"
" Bundle 'rstacruz/sparkup', {'rtp': 'vim'}
" Bundle 'airblade/vim-gitgutter'
"Bundle 'Shougo/neocomplcache'
"Bundle 'godlygeek/tabular'
"Bundle 'jgdavey/vim-blockle'
"Bundle 'kana/vim-textobj-user'
"Bundle 'nelstrom/vim-textobj-rubyblock'
"Bundle 'tpope/vim-haml'
"Bundle 'tsaleh/vim-matchit'
"Bundle 'tsaleh/vim-shoulda'
"Bundle 'tsaleh/vim-tmux'
"Bundle 'vim-ruby/vim-ruby'
"Bundle 'vim-scripts/Gist.vim'
"Bundle 'vim-scripts/IndexedSearch'
"Bundle 'sickill/vim-pasta'
"Bundle 'timcharper/textile.vim'
"Bundle 'tomtom/tcomment_vim'
"Bundle 'tpope/vim-cucumber'
call vundle#end()

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Iosevka\ medium\ 12 "Fantasque\ Sans\ Mono\ Bold\ 11
  elseif has("gui_win32")
    set guifont=Iosevka:h11:b:cTURKISH "Meslo\ LG\ S\ Regular
  endif
else
endif

"Enough with the dinging!
set visualbell
set noerrorbells
set t_vb=
set tm=500

"Activate TAB completion
set nocompatible

"TAB autocompletion will show the list of all matching completions
set wildmode=longest,list,full
"ignore case while matching filenames
set wildignorecase
"ignore temp files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"Set tab width to 2
set tabstop=2

" let backspace delete indent
set softtabstop=2

"Set shift width to 2
set shiftwidth=2

"Enable search highlight
set hlsearch

"Enable incremental search
set incsearch

set smartcase

"Enable automatic indentation
set autoindent

"Enable smart indentation
set smartindent

" Set to auto read when a file is changed from the outside
set autoread

"Enable line numbers
set number

"Always show current position
set ruler

"Allow backspacing over everything in insert mode
set backspace=indent,eol,start

"Put spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

"Set command hight to 2
set cmdheight=2

"Enter select mode when using the mouse
"set selectmode=mouse

"Keep 700 lines of command line history
set history=700

"Show matching opening bracket when the closing is typed in
set showmatch

" Turn backup off
set nobackup
set nowb
set noswapfile

"Left-right arrow keys continue moving at the end of line to next line, and
"begining to previous line
set whichwrap+=<,>,[,],b,s,h,l

"Maximum text width to automatic linebreak
set tw=80

"Don't move back the cursor one position when exiting insert mode
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

"Show "invisible" characters
set list
" Highlight problematic whitespace
set lcs=tab:▸\ ,eol:¬,trail:.,extends:#,nbsp:_

" Code folding mode indent, nests maximum 10
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

"CtrlP settings
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"Make Ctrl-P plugin a lot faster for Git projects
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

"leader key is space
"let mapleader = ","
let mapleader = "\<Space>"

"Save a file as root (,W)
noremap <Leader>W :w !sudo tee % > /dev/null
noremap <Leader>w :w<CR>
noremap <Leader>x :x<CR>
noremap <Leader>q :Bdelete<CR>
noremap <Leader>c <c-w><c-c>
noremap <Leader>Q :q!<CR>
noremap <Leader>e :e
noremap <Leader>h :h
noremap <Leader>so :so %<cr>
noremap <Leader>v :vs
"noremap <Leader>t :set ignorecase!<CR>
noremap <Leader>t :TagbarToggle<CR>
noremap <Leader>s :split
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>r :NERDTreeFind<CR>
noremap <Leader>ff :silent !firefox %<CR>
noremap <Leader>ch :silent !google-chrome % &<CR>
noremap <Leader>g  :silent !git gui<CR>
"List buffers
noremap <Leader>b :buffers<CR>
"cd to directory of current file
map <Leader>CD <ESC>:CD
"execute last command mode command.
map <Leader>, <ESC><ESC>:<Up><CR>
"split line at cursor.
map <Leader>o i<CR><ESC>
map <Leader>m <ESC>:make<CR>
"manipulate clipboard
map <Leader>y "+y
map <Leader>d "+d
map <Leader>p "+p
map <Leader>Y "+Y
map <Leader>D "+D
map <Leader>P "+P

"Automatically jump to end of text you pasted:
"I can paste multiple lines multiple times with simple ppppp.
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"Quickly select text you just pasted:
noremap gV `[v`]

"Stop that stupid window from popping up:
map q: :q

""Enter visual line mode
"nmap <Leader><Leader> V

"neocomplete configuration
let g:neocomplete#enable_at_startup = 1

"Easymotion configuration

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap ss <Plug>(easymotion-s)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"in visual mode, use v to expand selection, ctrl+v to shrink selection.
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"Open file using xdg-open
map <C-o> <ESC><ESC>:!xdg-open "%"<CR>

"Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"Open the definiton in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

function! Comment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^/\#/
  elseif ext == 'js' || ext == 'scala' || ext == 'sbt'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^\#//
  elseif ext == 'js' || ext == 'scala' || ext == 'sbt'
    silent s:^\/\/::g
  elseif ext == 'vim'
    silent s:^\"::g
  endif
endfunction

function! ClearEmptyLines()
  "Clear whitespace only line:
  silent %s/^\s*$//g
  "Clear whitespace at the end of lines
  silent %s/\s*$//g
endfunction

noremap <A-/> :call Comment()<CR>
noremap <A-?> :call Uncomment()<CR>
noremap <A-c> :call ClearEmptyLines()<CR>

function! RelativeNumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

"Toggle relative numbers
noremap <C-n> :call RelativeNumberToggle()<cr>
call RelativeNumberToggle()

"Higlight column indicating maximum text width
set colorcolumn=+1
hi ColorColumn guibg=#2d2d2d ctermbg=246

"Highlight line with overlength
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"Status line (file information, etc...)
set statusline=%n:\ %f%m%r%w\ [%Y,%{&fileencoding},%{&fileformat}]\ [%{getcwd()}]%=\ [%l-%L,%v][%p%%]

"Enable syntax highlighting
syntax on

"Set colorscheme to 'vividchalk'
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme base16-bespin
"solarized

"Enable filetype dependent plugins
filetype plugin on

"Define command to go to directory of current file
cmap CD cd %:p:h<CR>:pwd<CR>

"Map F6 key when opening a Haskell file to run it when pressed.
au Bufenter *.{,l}hs map <F6> :!runhaskell "%"<CR>

"Set complier for haskell files
au Bufenter *.{,l}hs compiler ghc

"Enable spell-check when opening html files.
au Bufenter *.html  set spell

"Enable spell-check when opening LaTeX files
au Bufenter *.tex set spell

"Set syntax for scala
au Bufenter *.scala set ft=scala
au Bufenter *.sbt set ft=scala

"Set syntax for typescript
au BufRead,BufNewFile *.ts setlocal filetype=typescript

"Go settings https://github.com/fatih/vim-go
"Run commands, such as go run with <leader>r for the current file or go build 
"and go test for the current package with <leader>b and <leader>t. Display a 
"beautiful annotated source code to see which functions are covered with 
"<leader>c.
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
"au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

"By default the mapping gd is enabled which opens the target identifier in 
"current buffer. You can also open the definition/declaration in a new vertical,
"horizontal or tab for the word under your cursor:
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

"Open the relevant Godoc for the word under the cursor with <leader>gd or open 
"it vertically with <leader>gv
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

"Or open the Godoc in browser
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

"Show a list of interfaces which is implemented by the type under your cursor 
"with <leader>s
au FileType go nmap <Leader>ii <Plug>(go-implements)

"Show type info for the word under your cursor with <leader>i (useful if you 
"have disabled auto showing type info via g:go_auto_type_info)
au FileType go nmap <Leader>i <Plug>(go-info)

"Rename the identifier under the cursor to a new name
au FileType go nmap <Leader>e <Plug>(go-rename)

"Go tagbar configuration
let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

"More <Plug> mappings can be seen with :he go-mappings. Also these are just 
"recommendations, you are free to create more advanced mappings or 
"functions based on :he go-commands.

"Map F1 key when opening a LaTeX file to compile all it when pressed.
"au Bufenter *.tex map <F1> <ESC><c-s>:silent !make<CR>
"Map F2 key when opening a LaTeX file to compile it when pressed.
"au Bufenter *.tex map <F2> <ESC><c-s>:silent !latex "%:p"<CR>
"Map F3 key when opening a LaTeX file to view dvi when pressed.
"au Bufenter *.tex map <F3> <ESC>:silent !yap "%:p:h/%:t:r"<CR>
"Map F4 key when opening a LaTeX file to make and view pdf when pressed.
"au Bufenter *.tex map <F4> <ESC>:silent !viewpdf<CR>

"Pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv

"In visual mode when tab is pressed indents selected lines
vmap <tab> >gv
vmap <s-tab> <gv

"Saves files with CTRL-S
imap <c-s> <c-o><c-s>
imap <c-s> <esc><c-s>
map <c-s> :w<cr>

"Buffer naviation
map <M-Left> :bprevious<CR>
map <M-Right> :bnext<CR>
map <A-J> :bprevious<CR>
map <A-K> :bnext<CR>

"Window navigtion
map <c-h> <c-w><Left>
map <c-l> <c-w><Right>
map <c-j> <c-w><Down>
map <c-k> <c-w><Up>


"Type 12<Enter> to go to line 12
"Hit Enter to go to end of file.
"Hit Backspace to go to beginning of file.
nnoremap <CR> G
nnoremap <BS> gg

"Ctrl-backspace/delete deletes previous/next word. Can be used faster than db.
"TODO find a better way for insert/command mode deletion
noremap <C-Backspace> db
noremap! <C-Backspace> <ESC>ldbi
noremap <C-Del> dw
noremap! <C-Del> <ESC>ldwi

"Select all.
map <c-a> ggVG

"Undo in insert mode.
imap <c-z> <c-o>u

"Let's be reasonable, shall we?
"up-down works when lines are wrapped.
nmap k gk
nmap j gj
"same behaviour in visual mode too, but when in linewise visual use normal line
"movement (according to line numbers)
"TODO when a number is specified for movement, use normal jk
" vmap <expr> j mode()==#"V" ? "j" : "gj"
" vmap <expr> k mode()==#"V" ? "k" : "gk"
"Navigation in insert mode.
imap <c-j> <esc>ja
imap <c-k> <esc>ka
imap <c-h> <esc>ha
imap <c-l> <esc>la
"page up/down
imap <c-u> <esc><c-u>a
imap <c-d> <esc><c-d>a
"Window resizing
"TODO not workin??
map <silent> <A-h> <C-w><
map <silent> <A-j> <C-W>-
map <silent> <A-k> <C-W>+
map <silent> <A-l> <C-w>>
"Navigation in command mode.
cmap <c-h> <Left>
cmap <c-l> <Right>
cmap <c-j> <Down>
cmap <c-k> <Up>

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
"cmap Q q

"paste clipboard into command mode
cmap ;p <C-r>"

"From http://vimregex.com/ {
"Tip 2: Easy shortcurts for replacing
noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::cg<Left><Left><Left><Left>

": functions the same way : functions.
nnoremap ; :

"Tip 3: Quick mapping to put \(\) in your pattern string
cmap ;\ \(\)<Left><Left>
"}

"LaTeX-Suite related settings {
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

"Rainbow parentheses configuration
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"airline setup
set laststatus=2
let g:airline#extensions#tabline#enabled   = 1
let g:airline#extensions#tabline#fnamemod  = ':t'
let g:airline_powerline_fonts              = 1
let g:airline_section_c                    = '%F'
let g:airline_section_z                    =
  \'%3p%% %{g:airline_symbols.linenr}%#__accent_bold#%l/%L%#__restore__#:%3c'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

"ctags configuration
set tags=./tags,tags,../tags

"gnome-terminal Alt key problem workaround
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim

let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50
