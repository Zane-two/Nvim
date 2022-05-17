"==================Vim-Plug======================"
call plug#begin('~/.vim/plugged')

"Plug 'VundleVim/Vundle.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'yggdroot/indentline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'glepnir/dashboard-nvim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'navarasu/onedark.nvim'
"Plug 'Yggdroot/LeaderF'
Plug 'ryanoasis/vim-devicons'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
"Plug 'plasticboy/vim-markdown'
"Plug 'jamshedvesuna/vim-markdown-preview' 
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim'
Plug 'bfrg/vim-cpp-modern'
"Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'Raimondi/delimitMate'
Plug 'pangloss/vim-javascript'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'heavenshell/vim-pydocstring'
Plug 'tell-k/vim-autopep8'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nvie/vim-flake8'
"Plug 'kien/ctrlp.vim'
Plug 'felikz/ctrlp-py-matcher'
Plug 'valloric/youcompleteme'

call plug#end()
"================NerdTree================="
map <silent> <C-e> :NERDTreeToggle<CR>
"================Vim-Airline=============="
let g:airline_theme="bubblegum" 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
"================rainbow=================="
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
"================TagBar==================="
nmap <F3> :TagbarToggle<CR>
" tagbar默认去这个目录中寻找ctags，ctags的默认安装路径也是这个目录
" let g:tagbar_ctags_bin='/usr/bin/ctags'  " Proper Ctags locations
let g:tagbar_width=26                      " Default is 40, seems too wide
noremap <Leader>y :TagbarToggle<CR>        " Display panel with (,y)

" 启动 时自动focus
let g:tagbar_autofocus = 1

" for ruby, delete if you do not need
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }
"================indentline==============="
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_setColors = 0
"================dashboard================"
let g:indentLine_fileTypeExclude = ['defx', 'denite', 'startify', 'tagbar', 'vista_kind', 'vista', 'coc-explorer', 'dashboard']
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
let g:dashboard_custom_shortcut={
\ 'last_session'       : 'SPC s l',
\ 'find_history'       : 'SPC f h',
\ 'find_file'          : 'SPC f f',
\ 'new_file'           : 'SPC c n',
\ 'change_colorscheme' : 'SPC t c',
\ 'find_word'          : 'SPC f a',
\ 'book_marks'         : 'SPC f b',
\ }
let g:dashboard_default_executive ='fzf'
"===============FZF======================"
" find file
noremap \ :FZF<CR>
" find history
noremap <C-h> :MRU<CR>
" find lines containing keywords
noremap <C-l> :LinesWithPreview<CR>
" find buffer
noremap <C-b> :Buffers<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler

command! -bang -nargs=* Buffers
  \ call fzf#vim#buffers(
  \   '',
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:0%', '?'),
  \   <bang>0)

command! -bang -nargs=* LinesWithPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --color=always --smart-case . '.fnameescape(expand('%')), 1,
    \   fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --sort'}, 'up:50%', '?'),
    \   1)

command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
"==========================leaderf======================"

"==========================coc.nvim====================="
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

let g:coc_global_extensions = [
	\'coc-json',
	\'coc-marketplace',
	\'coc-vimlsp',
	\'coc-clangd',
	\'coc-powershell']
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
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
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
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
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"===========================keyboard==========================="
noremap <F12> :PlugInstall<CR>
noremap qq :q<CR>
noremap Q :wq<CR>
noremap <C-s>  :bn<CR>
noremap <C-x>  :bp<CR>
imap jk <Esc>
nmap <space> :
map <C-n> :tabnew<CR>
noremap <C-f> :FZF<CR>
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
noremap M :e<CR>
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc
noremap <C-y> ::MarkdownPreview<CR>
noremap <F8> ::Tagbar<CR>
" 按 F5 执行当前 Python 代码"
map <F5> :call PRUN()<CR>
func! PRUN()
    exec "w" 
    if &filetype == 'python'
        exec "!python %"
    endif
endfunc
"==========================setting============================="
set fenc=
set number
syntax on           			" 语法高亮
autocmd InsertLeave * se nocul  	" 用浅色高亮当前行
"autocmd InsertEnter * se cul    	" 用浅色高亮当前行
set ruler           			" 显示标尺
set showcmd         			" 输入的命令显示出来，看的清楚
set foldenable      			" 允许折叠
set foldmethod=manual   		" 手动折叠
set autowrite
set ruler                   		" 打开状态栏标尺
set cursorline              		" 突出显示当前行
set magic                   		" 设置魔术
set guioptions-=T           		" 隐藏工具栏
set guioptions-=m           		" 隐藏菜单栏
set syntax=on
set autoindent				" 自动缩进
set cindent				" Tab键的宽度
set tabstop=4				" 统一缩进为4
set softtabstop=4
set shiftwidth=4
set noexpandtab				" 不要用空格代替制表符
set hlsearch
set incsearch
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8
set helplang=cn
"=========================new_itab==============================="
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#########################################################################")
        call append(line("."), "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author: ma6174")
        call append(line(".")+2, "\# mail: ma6174@163.com")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "\#!/bin/bash")
        call append(line(".")+6, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: ma6174")
        call append(line(".")+2, "    > Mail: ma6174@163.com ")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc
"====================theme===================="
let g:onedark_style = 'deep'  " We need add the configs before colorscheme line
colorscheme onedark
let g:onedark_darker_diagnostics = 0 " By default it is 1
let g:onedark_diagnostics_undercurl = 0 " By default it is 1
"===================markdown=================="
"vim-markdown"
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh'] "启用受保护的代码块语法高亮
let g:markdown_syntax_conceal = 0	"禁用 markdown 语法隐藏
let g:markdown_minlines = 100
"markdown-syntax"
let g:vim_markdown_folding_level = 6
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1
"previm"
"let vim_markdown_preview_toggle=2
"let vim_markdown_preview_toggle=3
"let vim_markdown_preview_hotkey='<C-m>'
"let vim_markdown_preview_browser='Google Chrome'
"let vim_markdown_preview_github=1
"let vim_markdown_preview_perl=1
"================C/Cpp==================="
" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 0

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1
"================ale======================"
"始终开启标志列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
"设置状态栏显示的内容
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}
let s:error_symbol = get(g:, 'airline#extensions#ale#error_symbol', 'E:')
let s:warning_symbol = get(g:, 'airline#extensions#ale#warning_symbol', 'W:')
let s:error_symbol = get(g:, 'airline#extensions#ale#error_symbol', '✗ ')
let s:warning_symbol = get(g:, 'airline#extensions#ale#warning_symbol', '⚡ ')
"文件内容发生变化时不进行检查
let g:ale_lint_on_text_changed = 'never'
"打开文件时不进行检查
let g:ale_lint_on_enter = 0
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\   'python': ['pylint'],
\}
let g:ale_java_javac_options = '-encoding UTF-8  -J-Duser.language=en'
"=================emmet==================="
let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_leader_key='<C-z>'
"=================ranger=================="
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1
noremap <C-r> :Ranger<CR>
"================python==================="
"autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_disable_show_diff=1
autocmd BufWritePost *.py call flake8#Flake8()
"================ctrlp===================="
let g:ctrlp_map = '<F6>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux	  
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
let g:ctrlp_user_command = 'find %s -type f' 
let g:airline#extensions#tabline#enabled = 1
noremap <F4> :CtrlPLine<CR>
"================clap====================="
let g:clap_layout = { 'relative': 'editor' }
let g:clap_provider_alias = {'hist:': 'command_history'}
let g:clap_theme = { 'search_text': {'guifg': 'red', 'ctermfg': 'red'} }
noremap <F7> :Clap<CR>
