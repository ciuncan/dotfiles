set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'msanders/snipmate.vim'
Bundle 'JuliaLang/julia-vim'
Bundle 'vim-scripts/matlab.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'elzr/vim-json'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-vividchalk'
Bundle 'vim-scripts/jQuery'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-git'

"following plugins looks nice, but will enable them when I feel I need them:
"
"Bundle 'majutsushi/tagbar'
"Bundle 'Shougo/neocomplcache'
"Bundle 'godlygeek/tabular'
"Bundle 'groenewege/vim-less'
"Bundle 'jgdavey/vim-blockle'
"Bundle 'kana/vim-textobj-user'
"Bundle 'kien/ctrlp.vim'
"Bundle 'nelstrom/vim-textobj-rubyblock'
"Bundle 'tpope/vim-haml'
"Bundle 'tpope/vim-rails'
"Bundle 'tpope/vim-repeat'
"Bundle 'tsaleh/vim-matchit'
"Bundle 'tsaleh/vim-shoulda'
"Bundle 'tsaleh/vim-tmux'
"Bundle 'vim-ruby/vim-ruby'
"Bundle 'vim-scripts/Gist.vim'
"Bundle 'vim-scripts/IndexedSearch'
"Bundle 'Lokaltog/vim-powerline'
"Bundle 'sickill/vim-pasta'
"Bundle 'timcharper/textile.vim'
"Bundle 'tomtom/tcomment_vim'
"Bundle 'tpope/vim-cucumber'
"Bundle 'tpope/vim-endwise'
"Bundle 'tpope/vim-fugitive'

"Set colorscheme to 'vividchalk'
color vividchalk

"Set font Monaco 9
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monaco\ 12
  elseif has("gui_win32")
    set guifont=Monaco:h12:cTURKISH
  endif
else
endif

"Activate TAB completion
set nocompatible

"TAB autocompletion will show the list of all matching completions
set wildmode=longest,list,full

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

"Enable automatic indentation
set autoindent

"Enable smart indentation
set smartindent

"Enable line numbers
set number

"Allow backspacing over everything in insert mode
set backspace=indent,eol,start

"Put spaces instead of tabs
set expandtab

"Set command hight to 2
set cmdheight=2

"Enter select mode when using the mouse
"set selectmode=mouse

"Keep 100 lines of command line history
set history=100

"Show matching opening bracket when the closing is typed in
set showmatch

"Left-right arrow keys continue moving at the end of line to next line, and
"begining to previous line
set whichwrap+=<,>,[,],b,s,h,l

"Maximum text width to automatic linebreak
set tw=80

"Show "invisible" characters
set list
" Highlight problematic whitespace
set lcs=tab:▸\ ,eol:¬,trail:.,extends:#,nbsp:_

"Save a file as root (,W)
noremap <Leader>W :w !sudo tee % > /dev/null<CR>
noremap <Leader>w :w<CR>
noremap <Leader>x :x<CR>
noremap <Leader>q :q<CR>
noremap <Leader>h :h 
noremap <Leader>so :so %<cr>
noremap <Leader>v :vs 
noremap <Leader>s :split 
noremap <Leader>n :NERDTreeToggle<CR>
"cd to directory of current file
map <Leader>cd <ESC>:CD
"execute last command mode command.
map <Leader>, <ESC>:<Up><CR>
"split line at cursor.
map <Leader>o i<CR><ESC>
"manipulate clipboard
map <Leader>y "+y
map <Leader>d "+d
map <Leader>p "+p

function! RelativeNumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

"Toggle relative numbers
noremap <C-n> :call RelativeNumberToggle()<cr>

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

"Enable filetype dependent plugins
filetype plugin on

"Define command to go to directory of current file
cmap CD cd %:p:h<CR>:pwd<CR>

"Map F6 key when opening a Haskell file to run it when pressed.
au Bufenter *.hs map <F6> :!runhaskell "%"<CR>

"Set complier for haskell files
au Bufenter *.hs compiler ghc

"Enable spell-check when opening LaTeX files
au Bufenter *.tex set spell

"Map F1 key when opening a LaTeX file to compile all it when pressed.
"au Bufenter *.tex map <F1> <ESC><c-s>:silent !make<CR>
"Map F2 key when opening a LaTeX file to compile it when pressed.
"au Bufenter *.tex map <F2> <ESC><c-s>:silent !latex "%:p"<CR>
"Map F3 key when opening a LaTeX file to view dvi when pressed.
"au Bufenter *.tex map <F3> <ESC>:silent !yap "%:p:h/%:t:r"<CR>
"Map F4 key when opening a LaTeX file to make and view pdf when pressed.
"au Bufenter *.tex map <F4> <ESC>:silent !viewpdf<CR>

"leader key is comma
let mapleader = ","

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
map <M-l> :bprevious<CR>
map <M-h> :bnext<CR>

"Ctrl-backspace/delete deletes previous/next word
"noremap <C-Backspace> db
"noremap! <C-Backspace> db
"noremap <C-Del> dw
"noremap! <C-Del> dw

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
vmap <expr> j mode()==#"V" ? "j" : "gj"
vmap <expr> k mode()==#"V" ? "k" : "gk"
"Navigation in insert mode.
imap <c-j> <esc>ja
imap <c-k> <esc>ka
imap <c-h> <esc>ha
imap <c-l> <esc>la
"page up/down
imap <c-u> <esc><c-u>a
imap <c-d> <esc><c-d>a

"Navigation in command mode.
cmap <c-h> <Left>
cmap <c-l> <Right>
cmap <c-j> <Down>
cmap <c-k> <Up>

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q

"paste clipboard into command mode
cmap ;p <C-r>" 

"From http://vimregex.com/ {
"Tip 2: Easy shortcurts for replacing
noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::cg<Left><Left><Left><Left>

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

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"let g:Tex_ViewRule_pdf = 'C:/Program\ Files\ (x86)/SumatraPDF/SumatraPDF.exe'
"}

call pathogen#infect()
call pathogen#helptags()

" tagbar for scala 
"let g:tagbar_type_scala = {
"    \ 'ctagstype' : 'Scala',
"    \ 'kinds'     : [
"        \ 'p:packages:1',
"        \ 'V:values',
"        \ 'v:variables',
"        \ 'T:types',
"        \ 't:traits',
"        \ 'o:objects',
"        \ 'a:aclasses',
"        \ 'c:classes',
"        \ 'r:cclasses',
"        \ 'm:methods'
"    \ ]
"\ }

" toggle tagbar
"nmap <F8> :TagbarToggle<CR> 

