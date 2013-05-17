lexer grammar DMLexer;

@lexer::header { package com.byond.lexer; }

Ident
  : ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
  ;

Int
  : '1'..'9' ('0'..'9')*
  | '0'
  ;

Octal
  : '0' ('0'..'7')+
  ;
  
Hex
  : '0' 'x' HexDigit+
  ;

Float
  :   Int '.' ('0'..'9')* Exponent?
  |   ('0'..'9')+ Exponent
  ;

Comment
  :   '//' ( options {greedy=false;} : . )* Linebreak {$channel=HIDDEN;}
  |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
  ;

StringDelimiter: '"';

StringEscape: '\\' .;

EmbeddedExpressionStart: '[';
  
EmbeddedExpressionEnd : ']';

Whitespace  : (' '|'\t')+ {skip();};

Linebreak: ('\n'|'\r''\n');
  
fragment
Exponent
  : ('e'|'E') ('+'|'-')? ('0'..'9')+
  ;

fragment
HexDigit
  : ('0'..'9'|'a'..'f'|'A'..'F') ;

