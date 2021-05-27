set nocompatible              " 这是必需的 
filetype off                  " 这是必需的 

set splitright 
set splitbelow 

" 在此设置运行时路径 
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/YouCompleteMe

" vundle初始化 
call vundle#begin()
" 或者传递一个 Vundle 安装插件的路径
"call vundle#begin('~/some/path/here')

" 让 Vundle 管理 Vundle, 必须
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/LeaderF'
Plugin 'vim-airline/vim-airline'
Plugin 'preservim/nerdtree'
Plugin 'yegappan/taglist'
Plugin 'tpope/vim-surround'
Plugin 'AutoClose'
Plugin 'ZoomWin' "窗口保存
Plugin 'airblade/vim-rooter'

" 所有的插件需要在下面这行之前
call vundle#end() 

filetype on

" 自动补全配置
set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" "回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme 默认tab s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR> "force recomile with syntastic
"nnoremap <leader>lo :lopen<CR> "open locationlist
"nnoremap <leader>lc :lclose<CR> "close locationlist
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
" let g:ycm_clangd_binary_path = exepath("clangd")
" let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'

""""""""""""""""""""""""""LeaderF
let g:Lf_WindowHeight = 0.30

""""""""""""""""""""""""""按键映射和提示



"""""""""""""""""""""""""" 快速运行
func! Compile()
    exec "w"
    if &filetype == 'c'
      exec "!gcc -g % -o %< && ./%<"
    elseif &filetype == 'cpp'
      exec "!g++ -g % -o %< && ./%<"
    elseif &filetype == 'cc'
      exec "!g++ -g % -o %< && ./%<"
    elseif &filetype == 'python'
      exec "!python %"
    elseif &filetype == 'sh'
      exec "!sh %"
    endif
endfunc

"""""""""""""""""""""""""" NERDTree(文件列表)
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=20

""""""""""""""""""""""""" taglist
"参考配置链接https://www.cnblogs.com/diegodu/p/7088596.html
let g:Tlist_Ctags_Cmd="/usr/bin/ctags"
let g:Tlist_Show_One_File=1 "只显示当前文件的tag
let g:Tlist_Exit_OnlyWindow=1 "taglist是最后一个窗口时，直接退出vim
" TlistToggle


" 切换绝对行号和相对行号
function! NumToggle()
  if &relativenumber ==# "norelativenumber"
    set relativenumber
  else
    set norelativenumber
  endif
endfunction

function GuideEsc()
        unmap a
        unmap s
        unmap d
        unmap f
        unmap g
        unmap w
        unmap q
        unmap <esc>
        echo ""
endfunction

function Terminal()
        terminal
endfunction

function MenuA()
  echo "[a] 跳转定义  [s] 查找引用  [d] 重命名  [f] 修正错误  [g] 函数签名  [w]格式化  [q] 取消"
        nnoremap <silent><nowait> a :call GuideEsc()<cr>:YcmCompleter GoToDefinition<CR>
        nnoremap <silent><nowait> s :call GuideEsc()<cr>:YcmCompleter GoToReferences
        nnoremap <nowait> d :call GuideEsc()<cr>:YcmCompleter RefactorRename
        nnoremap <silent><nowait> f :call GuideEsc()<cr>:YcmCompleter FixIt<CR>
        nnoremap <silent><nowait> g <nop>
        nnoremap <silent><nowait> w :call GuideEsc()<cr>:YcmCompleter Format<CR>
        nnoremap <silent><nowait> q :call GuideEsc()<cr>
        nnoremap <silent><nowait> <esc> :call GuideEsc()<cr>
endfunction

function MenuS()
        echo "[a] 查找函数  [s] 打开文件  [d] buffer查找  [f] 最近文件 [g] 全局搜索  [q] 取消"
        nnoremap <silent><nowait> a :call GuideEsc()<cr>:LeaderfFunction<cr>
        nnoremap <silent><nowait> s :call GuideEsc()<cr>:LeaderfFile<cr>
        nnoremap <silent><nowait> d :call GuideEsc()<cr>:LeaderfBuffer<cr>
        nnoremap <silent><nowait> f :call GuideEsc()<cr>:LeaderfMru<cr>
        nnoremap <silent><nowait> g :call GuideEsc()<cr>:call PatternSearch()<cr>
        nnoremap <silent><nowait> w <nop>
        nnoremap <silent><nowait> q :call GuideEsc()<cr>
        nnoremap <silent><nowait> <esc> :call GuideEsc()<cr>
endfunction

function MenuD()
        echo "[a] 编译运行  [s] 编译检查  [q] 取消"
        nnoremap <silent><nowait> a :call GuideEsc()<cr>:call Compile()<cr>
        nnoremap <silent><nowait> s :call GuideEsc()<cr>:YcmDiags<CR>
        nnoremap <silent><nowait> d <nop>
        nnoremap <silent><nowait> f <nop>
        nnoremap <silent><nowait> g <nop>
        nnoremap <silent><nowait> w <nop>
endfunction

function MenuF()
        echo "[a] 函数列表  [s] 文件列表  [d] .h/.c  [f] 标签页  [q] 取消"
        nnoremap <silent><nowait> a :call GuideEsc()<cr>:TlistToggle<cr>
        nnoremap <silent><nowait> s :call GuideEsc()<cr>:NERDTreeToggle<cr>
        nnoremap <silent><nowait> d <nop>
        nnoremap <nowait> f :call GuideEsc()<cr>:tabe
        nnoremap <silent><nowait> g <nop>
        nnoremap <silent><nowait> w <nop>
        nnoremap <silent><nowait> q :call GuideEsc()<cr>
        nnoremap <silent><nowait> <esc> :call GuideEsc()<cr>
endfunction

function MenuWA()
  echo "[a] 切换鼠标  [s] 切换粘贴  [d] 切换行号  [f] 不可见字符  [q] 取消"
        nnoremap <silent><nowait> a :call GuideEsc()<cr>:call MouseToggle()<cr>
        nnoremap <silent><nowait> s :call GuideEsc()<cr>:set paste!<cr>
        nnoremap <silent><nowait> d :call GuideEsc()<cr>:call NumToggle()<cr>
        nnoremap <silent><nowait> f :call GuideEsc()<cr>:set list!<cr>
        nnoremap <silent><nowait> g <nop>
        nnoremap <silent><nowait> w <nop>
        nnoremap <silent><nowait> q :call GuideEsc()<cr>
        nnoremap <silent><nowait> <esc> :call GuideEsc()<cr>
endfunction

function MenuWS()
        echo "[a] 文档注释  [s] 折叠  [d]展开  [q] 取消"
        nnoremap <silent><nowait> a <nop>
        nnoremap <silent><nowait> s :call GuideEsc()<cr>:zf%<cr>
        nnoremap <silent><nowait> d :call GuideEsc()<cr>:zo<cr>
        nnoremap <silent><nowait> f <nop>
        nnoremap <silent><nowait> g <nop>
        nnoremap <silent><nowait> w <nop>
        nnoremap <silent><nowait> q :call GuideEsc()<cr>
        nnoremap <silent><nowait> <esc> :call GuideEsc()<cr>
        " TODO 快速注释和格式整理
endfunction

function GuideMapTopMenu()
        nnoremap <silent><nowait> a :call MenuA()<cr>
        nnoremap <silent><nowait> s :call MenuS()<cr>
        nnoremap <silent><nowait> d :call MenuD()<cr>
        nnoremap <silent><nowait> f :call MenuF()<cr>
        nnoremap <silent><nowait> t :call Terminal()<cr>
        nnoremap <silent><nowait> g :call MenuWA()<cr>
        nnoremap <silent><nowait> w :call MenuWS()<cr>
        nnoremap <silent><nowait> q :call GuideEsc()<cr>
        nnoremap <silent><nowait> <esc> :call GuideEsc()<cr>
endfunction

nnoremap <silent><nowait> <space> :call GuideEntry()<cr>
function GuideEntry()
        " 1. 重新映射相关快捷键到 space
        call GuideMapTopMenu()
        " 2. 打印菜单
        echo "[a] 语义  [s] 查找  [d] 调试  [f] 窗口  [g] 切换  [w] 其它  [q] 取消  [t] 终端"
endfunction

" 快速缩进
vnoremap < <gv
vnoremap > >gv

"https://blog.csdn.net/u013408061/article/details/81905053
":tabnew [++opt选项] ［＋cmd］ 文件            建立对指定文件新的tab
":tabc       关闭当前的tab
":tabo       关闭所有其他的tab
":tabs       查看所有打开的tab
":tabp      前一个
":tabn      后一个

":vsplit 这个命令太长，没人用的。大家都用 :vsp ，:sp filename来分屏。
"分屏的相关动作都是ctrl+w 开始的，然后再跟一个其他字母
"ctrl+w = ：让左右上下各个分屏宽度，高度均等。
"ctrl+w _(shift + -) :当前屏幕高度扩展到最大
"ctrl+w |(shift + \) :当前屏幕宽度扩展到最大
"ctrl+w c：关闭当前屏幕

"A buffer is the in-memory text of a file.
"A window is a viewport on a buffer.
"A tab page is a collection of windows.

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

function! NewFile()
    let new_name = input('New file name:')
    exec ':new ' . new_name
endfunction

function! PatternSearch()
    let patter_expr = input('String to search: ', expand('<cword>'))
    exec ':Leaderf rg -e ' . patter_expr
endfunction

