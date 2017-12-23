/*
		Julio A. Fresneda	-	49215154F	-	juliofresnedag@correo.ugr.es	-	github.com/juliofgx17
	


	Hacer una plantilla Lex que tras leer un texto nos diga el número de caracteres,
palabras y líneas de dicho texto, entendiéndose por palabra toda secuencia de
caracteres que no posea ni espacios ni tabuladores ni retornos de carro. Se supone que
toda línea está acabada por un retorno de carro (\n).

*/





	/*----- Sección de Declaraciones --------------*/
%{
#include <stdio.h>
int nc, np, nl;
void escribir_datos (int dato1, int dato2, int dato3);
%}
%%

	/*----- Sección de Reglas ----------------*/
[^ \t\n]+	{ np++; nc += yyleng; }
[ \t]+		{ nc += yyleng; }
\n		{ nl++; nc++; }
	
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

nc = np = nl = 0;

yylex ();

escribir_datos(nc,np,nl);

return 0;
}


void escribir_datos (int dato1, int dato2, int dato3) {
	printf ("Num_caracteres=%d\nNum_palabras=%d\nNum_líneas=%d\n", dato1,dato2,dato3);
}
