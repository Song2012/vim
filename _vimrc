if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif

set nocompatible
set go=
"source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
"设置字体
set guifont=Yahei_Consolas_Hybrid:h13
"vim打开文件时从上次编辑出继续编辑
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

colo desert
set nocp
set nobackup
set nu
"基本配置
set wildmenu "增强模式中的命令行自动完成操作
"set foldmethod=manual "设定折叠方式为手动
set helplang=cn "设置帮助的语言为中文
set cin     "实现C程序的缩进
set sw=4   "设计(自动) 缩进使用4个空格
set sta    "插入时使用'shiftwidth'
set backspace=2 "指明在插入模式下可以使用删除光标前面的字符
syntax enable "设置高亮关键字显示
set nocompatible "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set number "显示行号
filetype on"检测文件的类型
filetype plugin on
set history=1000 ""记录历史的行数
syntax on "语法高亮度显示

set autoindent
set smartindent
"上面两行在进行编写代码时，在格式对起上很有用；
"第一行，vim使用自动对起，也就是把当前行的对起格式应用到下一行；
"第二行，依据上面的对起格式，智能的选择对起方式，对于类似C语言编写上很有用
"第一行设置tab键为4个空格，第二行设置当行之间交错时使用4个空格
set tabstop=4
set shiftwidth=4
set showmatch "设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
set ruler "在编辑过程中，在右下角显示光标位置的状态行
set incsearch "查询时非常方便，如要查找book单词，当输入到/b时，会自动找到第一 个b开头的单词，当输入到/bo时，会自动找到第一个bo开头的单词，依
"次类推，进行查找时，使用此设置会快速找到答案，当你找要匹配的单词
"时，别忘记回车。
 set enc=chinese "设置编码为中文
set winaltkeys=no "Alt组合键不映射到菜单上
set helplang=cn
set autoread   "自动加载
set autowriteall "自动保存
set tags+=C:\Progra~1\Vim\vim73\ctags58\tags,C:\Progra~1\Vim\vim73\cpp_src\stl_tags,C:\Progra~1\Vim\vim73\taggs;
set autochdir
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Show_One_File=0
let Tlist_Exit_OnlyWindow=1

map <F12> :Tlist<CR>

map <F3> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        let tagsdeleted=delete(dir."\\"."tags")
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" => omnicppcomplete 设置 2011-6-4 1:29:01  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
set completeopt=menu,menuone
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype  in popup window
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_DisplayMode=1
let OmniCpp_DefaultNamespaces=["std"]

map <F5> :call CompileRunGpp()<CR>
func! CompileRunGpp()
exec "w"
if(g:iswindows)
	exec "!cl /Fe%<.exe %"
elseif &filetype=="c"
	exec "!gcc % -o %<"
elseif &filetype=="cpp"
	exec "!g++ % -o %<"
endif
endfunc

map <F6> :call Run()<CR>

func! Run()
	exec "w"
	exec "!%<"
endfunc

let g:C_Comments = "no"         " 用C++的注释风格
let g:C_BraceOnNewLine = "no"   " '{'是否独自一行
let g:C_AuthorName = "Wu Yin"
let g:C_Project="F9"
let g:Cpp_Template_Function = "c-function-description-wuyin"
let g:C_TypeOfH = "c"           " *.h文件的文件类型是C还是C++


function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")] " 取得当前光标后一个字符
    if a:char == l:next_char
        execute "normal! l"
    else
        execute "normal! i" . a:char . ""
    end
endfunction
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a

":inoremap { {<CR><CR>}<UP><TAB><TAB><ESC>i
inoremap ( ()<LEFT>
nnoremap wh :VimwikiAll2HTML
inoremap jj <ESC>
nnoremap ; :
"禁用光标键
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <F4> gg=G
nnoremap <tab> :tabn<CR>

function! RemovePairs()
    let l:line = getline(".")
    let l:previous_char = l:line[col(".")-1] " 取得当前光标前一个字符
    if index(["(", "[", "{"], l:previous_char) != -1
        let l:original_pos = getpos(".")
        execute "normal %"
        let l:new_pos = getpos(".")
        " 如果没有匹配的右括号
        if l:original_pos == l:new_pos
            execute "normal! a\<BS>"
            return
        end
        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            " 如果右括号是当前行最后一个字符
            execute "normal! v%xa"
        else
            " 如果右括号不是当前行最后一个字符
            execute "normal! v%xi"
        end
   else
       execute "normal! a\<BS>"
    end
endfunction
" 用退格键删除一个左括号时同时删除对应的右括号
"inoremap <BS> <ESC>:call RemovePairs()<CR>a

"关闭菜单栏
"set go= "无菜单、工具栏"
"vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path': 'E:/vimwiki/',
\ 'path_html': 'E:/vimwiki/html/',
\ 'html_header': 'E:/vimwiki/template/header.tpl',}]

