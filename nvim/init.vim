"------------------------------------------------
" install Plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" {{{ Plugins -------------------------------
" Plugins START
call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'mcchrish/nnn.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'cespare/vim-toml'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/jsonc.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-commentary'
  Plug 'mattn/emmet-vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'ap/vim-css-color'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tpope/vim-fugitive'
  " Plug 'vimwiki/vimwiki'
  Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
  " typescript syntax highlight
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  " Themes
  Plug 'morhetz/gruvbox'
  Plug 'arcticicestudio/nord-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'herrbischoff/cobalt2.vim'
  Plug 'puremourning/vimspector'
  Plug 'jacoborus/tender.vim'
call plug#end()
" Plugins END
" }}} ------------------------------------------

" {{{ Seettings START ---------------------------
" Settings START
let mapleader = ','
filetype plugin on
set completeopt=menuone
set mouse=a
set nobackup
set nocompatible
set noswapfile
set nowritebackup
set number rnu
set numberwidth=5
set signcolumn=yes
set title
set wrap
set colorcolumn=80
set smartindent
set expandtab
set shiftwidth=2
set softtabstop=2
set fdm=marker
setlocal wrap
" Settings END
" }}} -------------------------------------------

" {{{ persist START -----------------------------
" persist START
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

" Persist cursor
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
" persist END
" }}} -------------------------------------------

" {{{ Theme ------------------------------------
" Theme START
syntax on
set background=dark
set cursorline
set hidden
set cmdheight=1
set laststatus=2

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" colorscheme gruvbox
" let g:gruvbox_transp_bg = 1
" let g:gruvbox_italicize_strings = 0
" highlight Normal     ctermbg=NONE guibg=NONE
" highlight LineNr     ctermbg=NONE guibg=NONE
" highlight SignColumn ctermbg=NONE guibg=NONE

" colorscheme nord
" colorscheme cobalt2
colorscheme tender
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermfg=0 ctermbg=12 guibg=NONE 
highlight SignColumn ctermbg=NONE guibg=NONE
highlight Comment    ctermfg=14

set list
set listchars=tab:»·,trail:·

" theming the status bar
source $HOME/.config/nvim/themes/airline.vim

" Theme END
" }}} ------------------------------------------

" {{{ Remaps -----------------------------------
" Remaps START

" Set SPACE as leader key
nnoremap <Space> <Nop>
map <Space> <Leader>

" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Toggle between buffers
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <C-x> :bd<CR>
" nmap <Leader>bn :bn<CR>
" nmap <Leader>bp :bp<CR>
" FZF shortcut
" nnoremap <C-p> :Rg<Cr>
nnoremap <C-p> :Files<Cr>
nmap <Leader>bl :Buffers<CR>
nmap <Leader>g :Commits<CR>
nnoremap <Leader>g? :GFiles?<CR>
nnoremap <Leader>g/ :GFiles<CR>
nmap <Leader>e :Files<CR>
nmap <Leader>p :Rg<CR>
nmap <Leader>g? :GFiles?<CR>
nmap <Leader>h :History<CR>

" Move between panes
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" copy paste from system clipboard
" cf https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
" to copy to the system clipboard in normal mode Shift+y then type the number
" of lines and then 'y' 
vnoremap <Leader>y "+y
nnoremap <S-y> "+y
nnoremap <Leader>p "+p

""""""""""""""""""""""""""""""""""""""
" Mapping to move lines
" Normal, Insert and Visual mode
" Ctrl+m j move line down
" Ctrl+m k move line down
""""""""""""""""""""""""""""""""""""""
nnoremap <C-m>j :m .+1<CR>==
nnoremap <C-m>k :m .-2<CR>==
inoremap <C-m>j <Esc>:m .+1<CR>==gi
inoremap <C-m>k <Esc>:m .-2<CR>==gi
vnoremap <C-m>j :m '>+1<CR>gv=gv
vnoremap <C-m>k :m '<-2<CR>gv=gv

" Remaps END
" }}} ------------------------------------------

""""""""""""""""""""""""""""""""""""""
" save file as superuser with :W
""""""""""""""""""""""""""""""""""""""
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" {{{ AutoPairs Settings
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
" disable autopairs (AltLeft+p)
let g:AutoPairsShortcutToggle = '<M-p>'
" }}}


"""""""""""""""""""""""""""""""""""""
" Emmet settings
"""""""""""""""""""""""""""""""""""""" 
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascriptreact,typescriptreact EmmetInstall
let g:user_emmet_leader_key=','

"------------------------------------------------
" nnn plugin
"
"------------------------------------------------
let g:nnn#layout = { 'window': {'width': 0.5, 'height': 0.6, 'highlight': 'Debug'} }

"------------------------------------------------
" vimwiki
"------------------------------------------------
let g:vimwiki_ext2syntax  = {'.md':'markdown'}
" vim-instant-markdown
" prerequiste :
"   yarn global add instant-mardown-d
let g:instant_markdown_autostart = 0
map <Leader>md :InstantMarkdownPreview<CR>
" to stop the server `:InstantMarkdownStop`

"------------------------------------------------
" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",
    "\ "Modified"  : "#d9bf91",
    "\ "Renamed"   : "#51C9FC",
    "\ "Untracked" : "#FCE77C",
    "\ "Unmerged"  : "#FC51E6",
    "\ "Dirty"     : "#FFBD61",
    "\ "Clean"     : "#87939A",
    "\ "Ignored"   : "#808080"
    "\ }
let g:NERDTreeIgnore = ['^node_modules$']
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

"------------------------------------------------

let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver'
\ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

"------------------------------------------------
" Coc START
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,jsonc setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ga  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
