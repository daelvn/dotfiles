if exists("b:current_syntax") && b:current_syntax == "amulet"
  finish
endif

" OCaml is case sensitive.
syn case match

" Access to the method of an object
syn match    amuletMethod       "#"

" Script headers highlighted like comments
syn match    amuletComment   "^#!.*" contains=@Spell

" Scripting directives
syn match    amuletScript "^#\<\(quit\|labels\|warnings\|directory\|cd\|load\|use\|install_printer\|remove_printer\|require\|thread\|trace\|untrace\|untrace_all\|print_depth\|print_length\|camlp4o\)\>"

" lowercase identifier - the standard way to match
syn match    amuletLCIdentifier /\<\(\l\|_\)\(\w\|'\)*\>/

syn match    amuletKeyChar    "|"

" Errors
syn match    amuletBraceErr   "}"
syn match    amuletBrackErr   "\]"
syn match    amuletParenErr   ")"
syn match    amuletArrErr     "|]"

syn match    amuletCommentErr "\*)"

syn match    amuletCountErr   "\<downto\>"
syn match    amuletCountErr   "\<to\>"

if !exists("amulet_revised")
  syn match    amuletDoErr      "\<do\>"
endif

syn match    amuletDoneErr    "\<done\>"
syn match    amuletThenErr    "\<then\>"

" Error-highlighting of "end" without synchronization:
" as keyword or as error (default)
if exists("amulet_noend_error")
  syn match    amuletKeyword    "\<end\>"
else
  syn match    amuletEndErr     "\<end\>"
endif

" Some convenient clusters
syn cluster  amuletAllErrs contains=amuletBraceErr,amuletBrackErr,amuletParenErr,amuletCommentErr,amuletCountErr,amuletDoErr,amuletDoneErr,amuletEndErr,amuletThenErr

syn cluster  amuletAENoParen contains=amuletBraceErr,amuletBrackErr,amuletCommentErr,amuletCountErr,amuletDoErr,amuletDoneErr,amuletEndErr,amuletThenErr

syn cluster  amuletContained contains=amuletTodo,amuletPreDef,amuletModParam,amuletModParam1,amuletPreMPRestr,amuletMPRestr,amuletMPRestr1,amuletMPRestr2,amuletMPRestr3,amuletModRHS,amuletFuncWith,amuletFuncStruct,amuletModTypeRestr,amuletModTRWith,amuletWith,amuletWithRest,amuletModType,amuletFullMod,amuletVal


" Enclosing delimiters
syn region   amuletEncl transparent matchgroup=amuletKeyword start="(" matchgroup=amuletKeyword end=")" contains=ALLBUT,@amuletContained,amuletParenErr
syn region   amuletEncl transparent matchgroup=amuletKeyword start="{" matchgroup=amuletKeyword end="}"  contains=ALLBUT,@amuletContained,amuletBraceErr
syn region   amuletEncl transparent matchgroup=amuletKeyword start="\[" matchgroup=amuletKeyword end="\]" contains=ALLBUT,@amuletContained,amuletBrackErr
syn region   amuletEncl transparent matchgroup=amuletKeyword start="\[|" matchgroup=amuletKeyword end="|\]" contains=ALLBUT,@amuletContained,amuletArrErr


" Comments
syn region   amuletComment start="(\*" end="\*)" contains=@Spell,amuletComment,amuletTodo
syn keyword  amuletTodo contained TODO FIXME XXX NOTE


" Objects
syn region   amuletEnd matchgroup=amuletObject start="\<object\>" matchgroup=amuletObject end="\<end\>" contains=ALLBUT,@amuletContained,amuletEndErr


" Blocks
if !exists("amulet_revised")
  syn region   amuletEnd matchgroup=amuletKeyword start="\<begin\>" matchgroup=amuletKeyword end="\<end\>" contains=ALLBUT,@amuletContained,amuletEndErr
endif


" "for"
syn region   amuletNone matchgroup=amuletKeyword start="\<for\>" matchgroup=amuletKeyword end="\<\(to\|downto\)\>" contains=ALLBUT,@amuletContained,amuletCountErr


" "do"
if !exists("amulet_revised")
  syn region   amuletDo matchgroup=amuletKeyword start="\<do\>" matchgroup=amuletKeyword end="\<done\>" contains=ALLBUT,@amuletContained,amuletDoneErr
endif

" "if"
syn region   amuletNone matchgroup=amuletKeyword start="\<if\>" matchgroup=amuletKeyword end="\<then\>" contains=ALLBUT,@amuletContained,amuletThenErr


"" Modules

" "sig"
syn region   amuletSig matchgroup=amuletModule start="\<sig\>" matchgroup=amuletModule end="\<end\>" contains=ALLBUT,@amuletContained,amuletEndErr,amuletModule
syn region   amuletModSpec matchgroup=amuletKeyword start="\<module\>" matchgroup=amuletModule end="\<\u\(\w\|'\)*\>" contained contains=@amuletAllErrs,amuletComment skipwhite skipempty nextgroup=amuletModTRWith,amuletMPRestr

" "open"
syn region   amuletNone matchgroup=amuletKeyword start="\<open\>" matchgroup=amuletModule end="\<\u\(\w\|'\)*\( *\. *\u\(\w\|'\)*\)*\>" contains=@amuletAllErrs,amuletComment

" "include"
syn match    amuletKeyword "\<include\>" skipwhite skipempty nextgroup=amuletModParam,amuletFullMod

" "module" - somewhat complicated stuff ;-)
syn region   amuletModule matchgroup=amuletKeyword start="\<module\>" matchgroup=amuletModule end="\<\u\(\w\|'\)*\>" contains=@amuletAllErrs,amuletComment skipwhite skipempty nextgroup=amuletPreDef
syn region   amuletPreDef start="."me=e-1 matchgroup=amuletKeyword end="\l\|=\|)"me=e-1 contained contains=@amuletAllErrs,amuletComment,amuletModParam,amuletModTypeRestr,amuletModTRWith nextgroup=amuletModPreRHS
syn region   amuletModParam start="([^*]" end=")" contained contains=@amuletAENoParen,amuletModParam1,amuletVal
syn match    amuletModParam1 "\<\u\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=amuletPreMPRestr

syn region   amuletPreMPRestr start="."me=e-1 end=")"me=e-1 contained contains=@amuletAllErrs,amuletComment,amuletMPRestr,amuletModTypeRestr

syn region   amuletMPRestr start=":" end="."me=e-1 contained contains=@amuletComment skipwhite skipempty nextgroup=amuletMPRestr1,amuletMPRestr2,amuletMPRestr3
syn region   amuletMPRestr1 matchgroup=amuletModule start="\ssig\s\=" matchgroup=amuletModule end="\<end\>" contained contains=ALLBUT,@amuletContained,amuletEndErr,amuletModule
syn region   amuletMPRestr2 start="\sfunctor\(\s\|(\)\="me=e-1 matchgroup=amuletKeyword end="->" contained contains=@amuletAllErrs,amuletComment,amuletModParam skipwhite skipempty nextgroup=amuletFuncWith,amuletMPRestr2
syn match    amuletMPRestr3 "\w\(\w\|'\)*\( *\. *\w\(\w\|'\)*\)*" contained
syn match    amuletModPreRHS "=" contained skipwhite skipempty nextgroup=amuletModParam,amuletFullMod
syn keyword  amuletKeyword val
syn region   amuletVal matchgroup=amuletKeyword start="\<val\>" matchgroup=amuletLCIdentifier end="\<\l\(\w\|'\)*\>" contains=@amuletAllErrs,amuletComment,amuletFullMod skipwhite skipempty nextgroup=amuletMPRestr
syn region   amuletModRHS start="." end=". *\w\|([^*]"me=e-2 contained contains=amuletComment skipwhite skipempty nextgroup=amuletModParam,amuletFullMod
syn match    amuletFullMod "\<\u\(\w\|'\)*\( *\. *\u\(\w\|'\)*\)*" contained skipwhite skipempty nextgroup=amuletFuncWith

syn region   amuletFuncWith start="([^*]"me=e-1 end=")" contained contains=amuletComment,amuletWith,amuletFuncStruct skipwhite skipempty nextgroup=amuletFuncWith
syn region   amuletFuncStruct matchgroup=amuletModule start="[^a-zA-Z]struct\>"hs=s+1 matchgroup=amuletModule end="\<end\>" contains=ALLBUT,@amuletContained,amuletEndErr

syn match    amuletModTypeRestr "\<\w\(\w\|'\)*\( *\. *\w\(\w\|'\)*\)*\>" contained
syn region   amuletModTRWith start=":\s*("hs=s+1 end=")" contained contains=@amuletAENoParen,amuletWith
syn match    amuletWith "\<\(\u\(\w\|'\)* *\. *\)*\w\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=amuletWithRest
syn region   amuletWithRest start="[^)]" end=")"me=e-1 contained contains=ALLBUT,@amuletContained

" "struct"
syn region   amuletStruct matchgroup=amuletModule start="\<\(module\s\+\)\=struct\>" matchgroup=amuletModule end="\<end\>" contains=ALLBUT,@amuletContained,amuletEndErr

" "module type"
syn region   amuletKeyword start="\<module\>\s*\<type\>\(\s*\<of\>\)\=" matchgroup=amuletModule end="\<\w\(\w\|'\)*\>" contains=amuletComment skipwhite skipempty nextgroup=amuletMTDef
syn match    amuletMTDef "=\s*\w\(\w\|'\)*\>"hs=s+1,me=s+1 skipwhite skipempty nextgroup=amuletFullMod

syn keyword  amuletKeyword  as assert class
syn keyword  amuletKeyword  else
syn keyword  amuletKeyword  external fun

syn keyword  amuletKeyword  in 
syn keyword  amuletKeyword  let match
syn keyword  amuletKeyword  type instance forall
syn keyword  amuletKeyword  when with
syn keyword  amuletKeyword  ref of

syn keyword  amuletKeyword  function
syn keyword  amuletBoolean  true false
syn match    amuletKeyChar  "!"

syn keyword  amuletType     array bool char exn float format format4
syn keyword  amuletType     int int32 int64 lazy list nativeint option
syn keyword  amuletType     string unit either functor applicative monad

syn match    amuletConstructor  "(\s*)"
syn match    amuletConstructor  "\[\s*\]"
syn match    amuletConstructor  "\[|\s*>|]"
syn match    amuletConstructor  "\[<\s*>\]"
syn match    amuletConstructor  "\u\(\w\|'\)*\>"

" Infix names
syn match    amuletOperator  "`\w\(\w\|'\)*\>`"

" Infix names
syn match    amuletTyvar  "\v'(\w+)"

" Module prefix
syn match    amuletModPath      "\u\(\w\|'\)* *\."he=e-1

syn match    amuletCharacter    "'\\\d\d\d'\|'\\[\'ntbr]'\|'.'"
syn match    amuletCharacter    "'\\x\x\x'"
syn match    amuletCharErr      "'\\\d\d'\|'\\\d'"
syn match    amuletCharErr      "'\\[^\'ntbr]'"
syn region   amuletString       start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell

syn match    amuletFunDef       "->"
syn match    amuletRefAssign    ":="
syn match    amuletTopStop      ";;"
syn match    amuletOperator     "\^"
syn match    amuletOperator     ":"
syn match    amuletOperator     "\$"
syn match    amuletOperator     "%"
syn match    amuletOperator     "&"
syn match    amuletOperator     "\."
syn match    amuletOperator     "/"
syn match    amuletOperator     "@"
syn match    amuletOperator     ","
syn match    amuletOperator     "+"
syn match    amuletOperator     "-"

syn match    amuletOperator     "&&"
syn match    amuletOperator     "<"
syn match    amuletOperator     ">"
syn match    amuletAnyVar       "\<_\>"
syn match    amuletKeyChar      "|[^\]]"me=e-1
syn match    amuletTopStop      ";"
syn match    amuletKeyChar      "\~"
syn match    amuletKeyChar      "?"
syn match    amuletKeyChar      "\*"
syn match    amuletKeyChar      "="

syn match    amuletOperator   "<-"

syn match    amuletNumber        "\<-\=\d\(_\|\d\)*[l|L|n]\?\>"
syn match    amuletNumber        "\<-\=0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syn match    amuletNumber        "\<-\=0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syn match    amuletNumber        "\<-\=0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syn match    amuletFloat         "\<-\=\d\(_\|\d\)*\.\?\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"

" Labels
syn match    amuletLabel        "\~\(\l\|_\)\(\w\|'\)*"lc=1
syn match    amuletLabel        "?\(\l\|_\)\(\w\|'\)*"lc=1
syn region   amuletLabel transparent matchgroup=amuletLabel start="?(\(\l\|_\)\(\w\|'\)*"lc=2 end=")"me=e-1 contains=ALLBUT,@amuletContained,amuletParenErr


" Synchronization
syn sync minlines=50
syn sync maxlines=500

if !exists("amulet_revised")
  syn sync match amuletDoSync      grouphere  amuletDo      "\<do\>"
  syn sync match amuletDoSync      groupthere amuletDo      "\<done\>"
endif

if exists("amulet_revised")
  syn sync match amuletEndSync     grouphere  amuletEnd     "\<\(object\)\>"
else
  syn sync match amuletEndSync     grouphere  amuletEnd     "\<\(begin\|object\)\>"
endif

syn sync match amuletEndSync     groupthere amuletEnd     "\<end\>"
syn sync match amuletStructSync  grouphere  amuletStruct  "\<struct\>"
syn sync match amuletStructSync  groupthere amuletStruct  "\<end\>"
syn sync match amuletSigSync     grouphere  amuletSig     "\<sig\>"
syn sync match amuletSigSync     groupthere amuletSig     "\<end\>"

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

hi def link amuletBraceErr	   Error
hi def link amuletBrackErr	   Error
hi def link amuletParenErr	   Error
hi def link amuletArrErr	   Error

hi def link amuletCommentErr   Error

hi def link amuletCountErr	   Error
hi def link amuletDoErr	   Error
hi def link amuletDoneErr	   Error
hi def link amuletEndErr	   Error
hi def link amuletThenErr	   Error

hi def link amuletCharErr	   Error

hi def link amuletErr	   Error

hi def link amuletComment	   Comment

hi def link amuletModPath	   Include
hi def link amuletObject	   Include
hi def link amuletModule	   Include
hi def link amuletModParam1    Include
hi def link amuletModType	   Include
hi def link amuletMPRestr3	   Include
hi def link amuletFullMod	   Include
hi def link amuletModTypeRestr Include
hi def link amuletWith	   Include
hi def link amuletMTDef	   Include

hi def link amuletScript	   Include

hi def link amuletConstructor  Constant

hi def link amuletVal          Keyword
hi def link amuletModPreRHS    Keyword
hi def link amuletMPRestr2	   Keyword
hi def link amuletKeyword	   Keyword
hi def link amuletMethod	   Include
hi def link amuletFunDef	   Keyword
hi def link amuletRefAssign    Keyword
hi def link amuletKeyChar	   Operator
hi def link amuletAnyVar	   Keyword
hi def link amuletTopStop	   Keyword
hi def link amuletOperator	   Operator

hi def link amuletBoolean	   Boolean
hi def link amuletCharacter    Character
hi def link amuletNumber	   Number
hi def link amuletFloat	   Float
hi def link amuletString	   String

hi def link amuletLabel	   Identifier

hi def link amuletType	   Special
hi def link amuletTyvar	   Type

hi def link amuletTodo	   Todo

hi def link amuletEncl	   Keyword


let b:current_syntax = "amulet"

" vim: ts=8
