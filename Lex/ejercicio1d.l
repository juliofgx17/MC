/*
		Julio A. Fresneda	-	49215154F	-	juliofresnedag@correo.ugr.es	-	github.com/juliofgx17
	


	Hacer una plantilla Lex, de manera que se cifre el texto de entrada, convirtiendo cada
palabra en su inversa. El concepto de palabra es el mismo que en el apartado b).
*/





	/*----- Sección de Declaraciones --------------*/
%{
#include <stdio.h>

%}
%%

	/*----- Sección de Reglas ----------------*/
[^ \t\n\b]+	{ for( int i=yyleng-1; i>=0; i-- ) printf( "%c", yytext[i] ); }
[ \t\b]+		{ for( int i=0; i<yyleng; i++ ){ printf( "%s", yytext ); };  }
\n		{ printf( "\n" ); }
	
%%

	/*----- Sección de Procedimientos --------*/
int main (int argc, char *argv[]) {
if (argc == 2) {
	yyin = fopen (argv[1], "rt");
	
	if (yyin == NULL) {
		printf ("El fichero %s no se puede abrir\n", argv[1]);
		exit (-1);
		}	
}
else yyin = stdin;


yylex ();


return 0;
}


