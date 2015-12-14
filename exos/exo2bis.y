%{
	#include <stdlib.h>
	#include <stdio.h>
%}
%start text
%token NOM PRONOM VERBE ADJECTIF ADVERBE
%%
text : 	phrase {printf("La phrase est correcte\n");}
		 | text phrase {printf("La phrase est correcte\n");}
		;
phrase : 	sujet VERBE complement
			;
sujet : 	NOM
		| PRONOM 
		;
complement : 	ADJECTIF
				| ADVERBE
				;	
%%
#include "lex.yy.c"