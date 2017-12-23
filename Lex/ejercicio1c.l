/*
		Julio A. Fresneda	-	49215154F	-	juliofresnedag@correo.ugr.es	-	github.com/juliofgx17
	


	Hacer una plantilla Lex que lea un fichero de texto, realice las siguientes acciones y
presente los resultados por pantalla:

	->Contar el número de secuencias de caracteres escritas completamente en
		mayúsculas.
	
	->Contar el número de secuencias de caracteres escritas completamente en
		minúsculas.

	->Contar el número de secuencias de caracteres que mezclen mayúsculas y
		minúsculas.

	->Contar el número de números enteros.	

	->Contar el número de números reales (Deberá aceptar números reales
		escritos con punto decimal (34.54, 3.00) y números con exponente (1.5E4, 2e-4, ...))

	->Calcular la suma de todos los números enteros encontrados.

	->Calcular la suma de todos los números reales encontrados.

*/





	/*----- Sección de Declaraciones --------------*/
%{
#include <stdio.h>
int nscM, nscm, nscmix, ne, nr, sume, sumeaux;
double sumr, sumraux;
void escribir_datos( int ncM, int ncm, int ncmix, int ne, int nr, int sume, double sumr );
%}
%%

	/*----- Sección de Reglas ----------------*/

("+"|"-")?[0-9]+(["."][0-9]+)((E|e)("+"|"-")?[0-9]+)?	{ nr++;  printf( "Real: %s\n", yytext ); sumraux = atof(yytext); sumr+=sumraux; }
("+"|"-")?[0-9]+((E|e)("+"|"-")?[0-9]+)?		{ ne++; printf( "Entero: %s\n", yytext ); sscanf( yytext, "%d", &sumeaux ); sume+=sumeaux; }
([^ \t\n\b[0-9]*[A-Z]+[^ \t\n\b[0-9]]*[a-z]+[^ \t\n\b[0-9]]*|[^ \t\n\b[0-9]]*[a-z]+[^ \t\n\b[0-9]]*[A-Z]+[^ \t\n\b[0-9]]*)		{ nscmix++; }
[A-Z]+		{ nscM++; }
[a-z]+		{ nscm++; }
\n		{}
.		{}
	
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

nscM = nscm = nscmix = ne = nr = sume = sumr = 0;

yylex ();

escribir_datos( nscM, nscm, nscmix, ne, nr, sume, sumr );

return 0;
}


void escribir_datos( int ncM, int ncm, int ncmix, int ne, int nr, int sume, double sumr ) {
	printf("Num palabras en Mayus = %d\nNum palabras en minus = %d\nNum palabras con mayus y minus = %d\n", nscM, nscm, nscmix );
	printf("Num enteros = %d\nNum reales = %d\nSuma enteros = %d\nSuma reales = %e\n", ne, nr, sume, sumr );
}
