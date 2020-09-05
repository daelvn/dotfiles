" nvim | 03.04.2018
" By daelvn
" Neovim configuration

" Plugins
call plug#begin('~/.config/nvim/plugged')
  " Fuzzy file finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " Vim alignment
  Plug 'junegunn/vim-easy-align'

  " Deoplete
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  " Nord
  Plug 'arcticicestudio/nord-vim'

  " Lightline
  Plug 'itchyny/lightline.vim'

  " Indent guides
  Plug 'Yggdroot/indentLine'

  " Syntax checkers
  Plug 'vim-syntastic/syntastic'

  " far
  Plug 'brooth/far.vim'

  " HAML support
  Plug 'tpope/vim-haml'

  " Moonscript support
  Plug 'leafo/moonscript-vim'
  Plug 'daelvn/msmx-vim'

  " CSS support
  Plug 'shmargum/vim-sass-colors'
  
  " Hardmode
  Plug 'wikitopian/hardmode'

  " Terminal support + REPL
  Plug 'vimlab/split-term.vim'

  " Discord Rich Presence
  Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
  "Plug 'anned20/vimsence'

  " Hoogle
  Plug 'Twinside/vim-hoogle'

  " Multi-cursors
  Plug 'terryma/vim-multiple-cursors'
  Plug 'hlissner/vim-multiedit'

  " Parinfer
  "Plug 'eraserhd/parinfer-rust'

  " EBNF support
  " Plug 'vim-scripts/bnf.vim'
  " Plug 'vim-scripts/ebnf.vim'
  Plug 'daelvn/bnf.vim'

  " DIMACS
  Plug 'alexeyignatiev/vim-dimacs'

  call plug#end ()
" Deoplete setup
let g:deoplete#enable_at_startup = 1

" Disable vim-multiedit default maps
" let g:multiedit_no_mappings = 1

" Leader
let mapleader = ','
let maplocalleader = mapleader

" Hardmode
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Use system clipboard
set clipboard=unnamedplus

" File associations
au BufNewFile,BufRead Alfons set syntax=moon
au BufRead,BufNewFile *.ronn set filetype=markdown

" indentLine
let g:indentLine_char = '|'

" Fzf
nnoremap <C-p> :FZF<CR>

" Alt+arrow window nav
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Nord setup
let g:nord_uniform_status_lines = 1
let g:nord_comment_brightness = 15
let g:nord_uniform_diff_background = 1
colorscheme nord

" Lightline setup
set laststatus=2
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'nord',
	\ }

" Options
syntax on
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
set incsearch hlsearch
set foldenable foldlevelstart=5
set foldmethod=indent
nnoremap <space> za
set number
set cursorline
set termguicolors

" My weird i<->a swap
nnoremap i a
nnoremap a i

" Shell running in new window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" Easier commands
tnoremap <Esc> <C-\><C-n>
nnoremap <F1> :q<Enter>
set splitbelow
" MoonScript
nnoremap <Leader>cm :!moonc %<Enter>
nnoremap <Leader>lm :Shell moonpick %<Enter><Enter>
nnoremap <Leader>rm :Shell moon %<Enter><Enter>
nnoremap <Leader>Rm :Term mooni <Enter>
nnoremap <Leader>im :Shell moonc -p %<Enter><Enter>
" Msmx
nnoremap <Leader>cx :Term msmx %<Enter>
nnoremap <Leader>cX :Term msmx -o /tmp/msmx % \| moonc -o %.moon /tmp/msmx<Enter>
" Lua
nnoremap <Leader>rl :Shell lua %<Enter><Enter>
nnoremap <Leader>Rl :Shell lua -i<Enter><Enter>
" Haskell
nnoremap <Leader>ch :Shell ghc -o %.bin %<Enter><Enter>
nnoremap <Leader>rh :Shell ghci %<Enter><Enter>
" Uploading
nnoremap <Leader>u  :!pbhtml %<Enter>
nnoremap <Leader>U  :!0x0 u %<Enter>
" LuaRocks
nnoremap <Leader>Lm :!luarocks make<Enter>
nnoremap <Leader>Lb :!luarocks build<Enter>
" Alfons
nnoremap <leader>ac :!alfons clean
nnoremap <leader>ax :!alfons compile
" EasyAlign
nmap     ga         <Plug>(EasyAlign)
xmap     ga         <Plug>(EasyAlign)
" Replace
nnoremap <Leader>/  :%s#

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_lua_checkers = ["luacheck", "luac"]
let g:syntastic_lua_luacheck_args = "--no-unused-args" 

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 1

" Transparency
"hi Normal guibg=NONE ctermbg=NONE

" Amulet
au BufEnter *.ml set filetype=amulet
