%{
	#include <stdio.h>
	typedef struct maillon {
		char* mot;
		int categorie;
		struct maillon *suiv;
	}MAILLON;
	typedef MAILLON* Liste;
	Liste L = NULL;
	int enApprentissage = 0;
	int currentCat;
	char *tabCat[] = {
		"",
		"sujet",
		"complement",
		"verbe"
	};

void inserer(char* mot, int cat, int longueur) {
	MAILLON *p;
	p = malloc(sizeof(MAILLON));
	p->mot = malloc(longueur * (sizeof(char)));
	strcpy(p->mot, mot);
	p->categorie = cat;
	p->suiv = L;
	L = p;
};

void afficherMot(char* mot) {
	MAILLON *tmp;
	tmp = L;
	if(tmp == NULL) {
		printf("%s est un mot inconnu\n", mot);
	}
	else {
		while (tmp->suiv != NULL && strcmp(tmp->mot, mot) != 0) {
			tmp = tmp->suiv;
		}
		if (strcmp(tmp->mot, mot) == 0) {
			printf("%s est un %s\n", mot, tabCat[tmp->categorie]);
		}
		else {
			printf("%s est un mot inconnu\n", mot);
		}
	}
};
%}
%%

^sujet {currentCat = 1; enApprentissage = 1;}
^complement {currentCat = 2; enApprentissage = 1;}
^verbe {currentCat = 3; enApprentissage = 1;}
[a-zA-Z]+ {
	if (enApprentissage == 1) {
		inserer(yytext, currentCat, yyleng);
	}
	else {
		afficherMot(yytext);
	}
}
\n {enApprentissage = 0;}
. ;

%%
int main ()
{
	yylex();
	return 0;
}
