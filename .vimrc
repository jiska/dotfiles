if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

set ambiwidth=double
set backspace=2
set tabstop=2
set shiftwidth=2
set textwidth=0
set expandtab

set number
set ruler
set smartindent
set showmatch
set showmode
set shellslash
set ff=unix
set nobackup
set noswapfile
set hlsearch
set ignorecase

syntax on
filetype plugin on
filetyp  indent on

" シンタックスチェック機能
nmap ,l :call SyntaxCheck()<CR>
nmap ,e :call ExecuteCode()<CR>
nmap ,t :call ExecuteTest()<CR>

function SyntaxCheck()
  execute ":w"
  if ("php" == &filetype)
    echo system("php -l ".bufname(""))
  elseif ("ruby" == &filetype)
    echo system("ruby -c ".bufname(""))
  elseif ("yaml" == &filetype)
    echo system('ruby -ryaml -e "begin;YAML::load(open(\"'.bufname("").'\",\"r\").read); puts \"ok\"; rescue ArgumentError => e; puts e; end"')
  end
endfunction

function ExecuteCode()
  execute ":w"
  if ("php" == &filetype)
    execute ":! php %"
  elseif ("ruby" == &filetype)
    execute ":! ruby %"
  end
endfunction

function ExecuteTest()
  execute ":w"
  if ("php" == &filetype)
    execute ":! phpunit --colors %"
  end
endfunction

" space可視化の呪文 (via: http://d.hatena.ne.jp/potappo2/20061107/1162862536)
syntax match InvisibleJISX0208Space "　" display containedin=ALL
highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=Blue
syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=Red
syntax match InvisibleTab "\t" display containedin=ALL
highlight InvisibleTab term=underline ctermbg=Cyan guibg=Cyan

if has("syntax")
    syntax on
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=Blue
        syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=Red
        syntax match InvisibleTab "\t" display containedin=ALL
        highlight InvisibleTab term=underline ctermbg=Cyan guibg=Cyan
    endf

    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif
