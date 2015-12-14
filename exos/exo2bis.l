%{
	#include <stdio.h>
	#include "exo2bis.tab.h"
	typedef struct maillon {
		char* mot;
		int categorie;
		struct maillon *suiv;
	}MAILLON;
	typedef MAILLON* Liste;
	Liste L = NULL;
	int enApprentissage = 0;
	int currentCat;

void inserer(char* mot, int cat, int longueur) {
	MAILLON *p;
	p = malloc(sizeof(MAILLON));
	p->mot = malloc(longueur * (sizeof(char)));
	strcpy(p->mot, mot);
	p->categorie = cat;
	p->suiv = L;
	L = p;
};

int afficherMot(char* mot) {
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
			return tmp->categorie;			
		}
		else {
			return -1;
		}
	}
};
%}
%%

^nom {currentCat = 1; enApprentissage = 1;}
^pronom {currentCat = 2; enApprentissage = 1;}
^adjectif {currentCat = 3; enApprentissage = 1;}
^adverbe {currentCat = 4; enApprentissage = 1;}
^verbe {currentCat = 5; enApprentissage = 1;}
[a-zA-Z]+ {
	if (enApprentissage == 1) {
		inserer(yytext, currentCat, yyleng);
	}
	else {
		switch (afficherMot(yytext))
		{
			case 1 :
				return (NOM);

			case 2:
				return (PRONOM);

			case 3:
				return (ADJECTIF);

			case 4 :
				return (ADVERBE);

			case 5 :
				return (VERBE);

			default :
				break;			
		}
	}
}
\n {enApprentissage = 0;}
. ;

%%