/*
		Julio A. Fresneda	-	49215154F	-	juliofresnedag@correo.ugr.es	-	github.com/juliofgx17
	


	Crear una plantilla en Lex para encontrar direcciones de correo electrónico, de páginas
web, fechas, números de teléfono, matrículas, códigos postales y NIF en un fichero
texto.


*/





	/*----- Sección de Declaraciones --------------*/
%{
#include <stdio.h>
int cl;
%}
%%
s


	/*----- Sección de Reglas ----------------*/
[^ \t\n\b]+[@][^ \t\n\b]+["."][^ \t\n\b]+					        { printf("Correo: %s en la línea %d\n",yytext, cl); }
[^ \t\n\b]+["."](es|com|org|info|net|eu|mobi|tv|co|biz)(["/"][^ \t\n\b]*)?              { printf("Web: %s en la línea %d\n",yytext,cl); }		
([0-2][0-9]|30|31)[/-]([0]?[0-9]|10|11|12)[/-]([0-9]{2,4})				{ printf("Fecha: %s en la línea %d\n",yytext, cl); }     
([0]?[0-9]|10|11|12)[/-]([0-2][0-9]|30|31)[/-]([0-9]{2,4})				{ printf("Fecha: %s en la línea %d\n",yytext, cl); }
("+34"|"(+34)"|"( +34 )")?[ ]?[6789]([0-9]{2})[ ]?([0-9]{3})[ ]?([0-9]{3})	        { printf("Tlfn: %s en la línea %d\n",yytext, cl); }
(([A-Za-z]?[ -]?([0-9]{4})[ -]?([A-Za-z]{2}))|(([0-9]{4})[ -]?([A-Za-z]{3})))	        { printf("Matrícula: %s en la línea %d\n",yytext, cl); }
([0-4][0-9]|50|51|52)([0-9]{3})								{ printf("CP: %s en la línea %d\n",yytext, cl); }
([0-9]{8})[ -]?[A-Za-z]								        { printf("NIF: %s en la línea %d\n",yytext, cl); }
\n											{ cl++; }
.											{}
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
cl = 1;



yylex ();

return 0;
}


