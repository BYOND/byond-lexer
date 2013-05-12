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
  :   '//' (EscSequence | ~('\r'|'\n'))* '\r'? '\n' {$channel=HIDDEN;}
  |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
  ;
  
Identifier  :   ('_'? 'a'..'z'|'A'..'Z')+ ;

// String
//  :  '"' ( EscSequence | ~('\\'|'"'|'\r'|'\n') )* '"'
//  | '{' '"' ( EscSequence | ~'\\' )* '"' '}'
//  ;

String
  : '"' (Identifier | StringEscape | ~StringSpecials | StringEmbeddedExpression)* '"'
  | '{"' (Identifier | StringEscape | ~MultilineStringSpecials | StringEmbeddedExpression)* '"}'
  ;
//Test: "This is \"a\" string with a [variable] inside of it."

StringSpecials
  :'"' | '\\' | '[' | '\n'
  ;

StringEscape
  : '\\' StringSpecials
  ;

MultilineStringSpecials
  :'\\' | '['
  ;

/**
<p>
Embedded expressions in strings.<br />
e.g. "Normal string [embedded] normal string."
</p>
*/
StringEmbeddedExpression
  : '[' Identifier ']'
  ;


Whitespace  : (' '|'\t')+ {skip();};

Linebreak:'\r'? '\n' ;

  
fragment
Exponent
  : ('e'|'E') ('+'|'-')? ('0'..'9')+
  ;

fragment
HexDigit
  : ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
EscSequence
  :   '\\' ('t'|'n'|'\\'|'\n')  // TODO: Expand on these.
  ;

