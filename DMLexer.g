lexer grammar DMLexer;

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
	:   '//' (EscSequence | ~(NewLine))* NewLine {$channel=HIDDEN;}
	|   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
	;

String
	:  '"' ( EscSequence | ~('\\'|'"'|NewLine) )* '"'
	| '{' '"' ( EscSequence | ~'\\' )* '"' '}'
	;

fragment
NewLine
	: '\n'	// '\r'? '\n' is giving me an error...
	;
	
fragment
Exponent
	: ('e'|'E') ('+'|'-')? ('0'..'9')+
	;

fragment
HexDigit
	: ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
EscSequence
	:   '\\' ('t'|'n'|'\\'|'\n')	// TODO: Expand on these.
	;
