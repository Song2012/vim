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
"��������
set guifont=Yahei_Consolas_Hybrid:h13
"vim���ļ�ʱ���ϴα༭�������༭
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

colo desert
set nocp
set nobackup
set nu
"��������
set wildmenu "��ǿģʽ�е��������Զ���ɲ���
"set foldmethod=manual "�趨�۵���ʽΪ�ֶ�
set helplang=cn "���ð���������Ϊ����
set cin     "ʵ��C���������
set sw=4   "���(�Զ�) ����ʹ��4���ո�
set sta    "����ʱʹ��'shiftwidth'
set backspace=2 "ָ���ڲ���ģʽ�¿���ʹ��ɾ�����ǰ����ַ�
syntax enable "���ø����ؼ�����ʾ
set nocompatible "ȥ��������й�viһ����ģʽ��������ǰ�汾��һЩbug�;���
set number "��ʾ�к�
filetype on"����ļ�������
filetype plugin on
set history=1000 ""��¼��ʷ������
syntax on "�﷨��������ʾ

set autoindent
set smartindent
"���������ڽ��б�д����ʱ���ڸ�ʽ�����Ϻ����ã�
"��һ�У�vimʹ���Զ�����Ҳ���ǰѵ�ǰ�еĶ����ʽӦ�õ���һ�У�
"�ڶ��У���������Ķ����ʽ�����ܵ�ѡ�����ʽ����������C���Ա�д�Ϻ�����
"��һ������tab��Ϊ4���ո񣬵ڶ������õ���֮�佻��ʱʹ��4���ո�
set tabstop=4
set shiftwidth=4
set showmatch "����ƥ��ģʽ�����Ƶ�����һ��������ʱ��ƥ����Ӧ���Ǹ�������
set ruler "�ڱ༭�����У������½���ʾ���λ�õ�״̬��
set incsearch "��ѯʱ�ǳ����㣬��Ҫ����book���ʣ������뵽/bʱ�����Զ��ҵ���һ ��b��ͷ�ĵ��ʣ������뵽/boʱ�����Զ��ҵ���һ��bo��ͷ�ĵ��ʣ���
"�����ƣ����в���ʱ��ʹ�ô����û�����ҵ��𰸣�������Ҫƥ��ĵ���
"ʱ�������ǻس���
 set enc=chinese "���ñ���Ϊ����
set winaltkeys=no "Alt��ϼ���ӳ�䵽�˵���
set helplang=cn
set autoread   "�Զ�����
set autowriteall "�Զ�����
set tags+=C:\Progra~1\Vim\vim73\ctags58\tags,C:\Progra~1\Vim\vim73\cpp_src\stl_tags,C:\Progra~1\Vim\vim73\taggs;
set autochdir
let Tlist_Ctags_Cmd='ctags' "��Ϊ���Ƿ��ڻ�����������Կ���ֱ��ִ��
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
" => omnicppcomplete ���� 2011-6-4 1:29:01  
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

let g:C_Comments = "no"         " ��C++��ע�ͷ��
let g:C_BraceOnNewLine = "no"   " '{'�Ƿ����һ��
let g:C_AuthorName = "Wu Yin"
let g:C_Project="F9"
let g:Cpp_Template_Function = "c-function-description-wuyin"
let g:C_TypeOfH = "c"           " *.h�ļ����ļ�������C����C++


function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")] " ȡ�õ�ǰ����һ���ַ�
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
"���ù���
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
    let l:previous_char = l:line[col(".")-1] " ȡ�õ�ǰ���ǰһ���ַ�
    if index(["(", "[", "{"], l:previous_char) != -1
        let l:original_pos = getpos(".")
        execute "normal %"
        let l:new_pos = getpos(".")
        " ���û��ƥ���������
        if l:original_pos == l:new_pos
            execute "normal! a\<BS>"
            return
        end
        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            " ����������ǵ�ǰ�����һ���ַ�
            execute "normal! v%xa"
        else
            " ��������Ų��ǵ�ǰ�����һ���ַ�
            execute "normal! v%xi"
        end
   else
       execute "normal! a\<BS>"
    end
endfunction
" ���˸��ɾ��һ��������ʱͬʱɾ����Ӧ��������
"inoremap <BS> <ESC>:call RemovePairs()<CR>a

"�رղ˵���
"set go= "�޲˵���������"
"vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path': 'E:/vimwiki/',
\ 'path_html': 'E:/vimwiki/html/',
\ 'html_header': 'E:/vimwiki/template/header.tpl',}]

