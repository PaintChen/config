"*********************************
"* setting 
"*********************************
syntax on " 语法高亮
set encoding=utf-8 " 文件编码utf-8
set number " 显示行号
set relativenumber " 显示相对行号
set cursorline " 光标所在的当前行高亮
" set noexpandtab "
set tabstop=2 " 设定 tab 长度为 2
set shiftwidth=2 " 设定 << 和 >> 命令移动时的宽度为 2
set softtabstop=2 " 使得按退格键时可以一次删掉 2 个空格
set autoindent " 启动一个新行的时候使用与前一行一样的缩进
set list " 如果行尾有多余的空格（包括 Tab 键），该配置将让这些空格显示成可见的小方块。
set listchars=tab:\|\ ,trail:▫ " 如果行尾有多余的空格（包括 Tab 键），该配置将让这些空格显示成可见的小方块。
" set scrolloff=4 "
" set ttimeoutlen=0 "
" set notimeout "
" set viewoptions=cursor,folds,slash,unix "
" set warp "
" set tw=0 "
" set indentexpr= "
" set foldmethod=indent "
" set foldlevel=99 "
" set foldenable "
" set formatoptions-=tc "
" set splitright "
" set splitbelow "
set showmode " 在底部显示，当前处于命令模式还是插入模式。
set showcmd " 总在 Vim 窗口的右下角显示当前光标位置
" set wildmenu "
" set ignorecase "
" set smartcase "
" set shortmess+=c "
" set inccommand=split "
set ttyfast "should make scrolling faster "
" set lazyredraw "same as above 
" set visualbell "
set t_Co=256 " 颜色配置
filetype indent on " 开启文件类型检查，并且载入与该类型对应的缩进规则。
set wrap " 自动折行，即太长的行分成几行显示。
set hlsearch " 搜索时，高亮显示匹配结果。
" set spell spelllang=en_us " 打开英语单词的拼写检查，中文会染色提示错误
set wildmenu
set wildmode=longest:list,full
"*********************************
"* my plug
"*********************************

call plug#begin('~/.vim/plugged')


" common

Plug 'tomasr/molokai' " 主题
Plug 'scrooloose/syntastic' " 语法检查/高亮
Plug 'luochen1990/rainbow' " 括号着色
Plug 'chiel92/vim-autoformat' " 代码格式化
Plug 'francoiscabrol/ranger.vim' " 与ranger交互的文件浏览器
Plug 'junegunn/fzf' " 模糊查找器
Plug 'rking/ag.vim' " 快速批量搜索代码，搜索文件, 模糊匹配, 正则表达式
Plug 'haya14busa/incsearch.vim' " 同时高亮所有匹配的字符
Plug 'itchyny/lightline.vim' " 底部栏显示
Plug 'liuchengxu/vista.vim' " Taglist需要ctags
Plug 'honza/vim-snippets' " 
Plug 'jiangmiao/auto-pairs' " 


" git辅助
Plug 'airblade/vim-gitgutter' " 文件修改跟踪
Plug 'fszymanski/fzf-gitignore' " 
Plug 'theniceboy/vim-gitignore' " 


" c/c++
Plug 'octol/vim-cpp-enhanced-highlight'	" 高亮增强


" python
Plug 'hynek/vim-python-pep8-indent' " python PEP8标准缩进

call plug#end()

" =
" =Ranger.vim
" =
nnoremap R :Ranger<CR> " normal模式下输入R打开Ranger
let g:ranger_map_keys = 0 " To disable the default key mapping

"=
"=lightline
"=
set laststatus=2
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'filename', 'modified', 'method' ] ]
\ },
\ 'component_function': {
\   'method': 'NearestMethodOrFunction'
\ },
\ }

"=
"=scheme
"=
colorscheme molokai
let g:molokai_original = 1

"=
"='luochen1990/rainbow'
"=
let g:rainbow_active = 1
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'tex': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'vim': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'css': 0,
\	}
\}

"=
"=Vista.vim
"=

"Show the nearest method/function in the statusline
noremap <silent> T :Vista!!<CR>
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
\ 'cpp': 'vim_lsp',
\ 'py': 'vim_lsp',
\ }
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
