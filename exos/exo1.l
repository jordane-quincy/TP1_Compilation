%{
	#include <stdio.h>
	#define MAX 30
	int T[MAX];
%}
%%
[a-zA-Z]+ {T[yyleng]++;}
. | \n ;
%%
int main ()
{

	int i;
	yylex();
	for (i = 0; i < MAX; i++) {
		if (T[i] != 0) {
			printf("Il y a %d mots de longueur %d\n", T[i], i);
		}
	}
	return 0;
}
