/*
		Julio A. Fresneda	-	49215154F	-	juliofresnedag@correo.ugr.es	-	github.com/juliofgx17
		Añadir los discos a la base de datos


*/

/*----- Sección de Declaraciones --------------*/
%{
#include <stdio.h>
#include <string>
#include "BaseDatos.h"
bool meterdatos;
string nombre;

DatosDiscos datosDiscos;
DatosCPU datosCPU;
DatosGPU datosGPU;
DatosRAMs datosRAMs;



BaseDatos baseDatos;
bool cpus, gpus, discos, rams_esc, rams_lec;
bool leyendo_doc;

string analizando[8];
%}


%%

	/*----- Sección de Reglas ----------------*/

("$"[^\n]+)						{	// PRECIO
								string p="";
								for( int i=1; i<yyleng; i++ )
								{
									if( yytext[i] != ',' && yytext[i] != '*' ){
										p+=yytext[i];
									}
								}
								//cout << "PRECIO: " << p << "$ DOLARES" << endl << endl;
								if( p != "" )
								{
									if( cpus ) datosCPU.precio = stof( p );					
									if( gpus ) datosGPU.precio = stof( p );	
									if( discos ) datosDiscos.precio = stof( p );
									if( rams_esc ) datosRAMs.precio = stof( p );		
								}
								//cout << datosCPU.precio << endl;
								meterdatos=true;
								
								
							
							}
[\t]*(NA)$						{	// PRECIO NA
								if( cpus ) datosCPU.precio = 0.0f;
								if( gpus ) datosGPU.precio = 0.0f;
								if( discos ) datosDiscos.precio = 0.0f;	
								if( rams_esc ) datosRAMs.precio = 0.0f;

								meterdatos = true;
								//cout << "PRECIO: NA" << endl << endl;
							}
^[0-9|","|"."]+$					{	// PUNTOS					
								string numero = "";
								for( int i=0; i<yyleng; i++ )
								{
									if( yytext[i] != ',' && yytext[i] != 'M' && yytext[i] != 'B' ){
										if( yytext[i] != '/' && yytext[i] != 's' ) numero+=yytext[i];
									}
								}
								if( cpus ) datosCPU.puntos = stoi( numero );
								if( gpus ) datosGPU.puntos = stoi( numero );
								if( discos ) datosDiscos.puntos = stoi( numero );
								if( rams_esc ) datosRAMs.velocidad_esc = stoi( numero );
								if( rams_lec ) baseDatos.UpdateVelLec( nombre, stoi( numero ) );

								//cout << "PUNTOS: " << datosCPU.puntos << endl;
							}
^[^@\n"$" ]+" "[^@\n"$"]*[^"@"\n"$" ]+			{	// NOMBRE COMPUESTO
								string nomtec = yytext;
								while( nomtec[0] == ' ' || nomtec[0] == '	' ) nomtec = nomtec.substr(1);
								while( nomtec[nomtec.size()-1] == ':' || nomtec[nomtec.size()-1] == ';' || nomtec[nomtec.size()-1] == '.' ||nomtec	[nomtec.size()-1] == ',' || nomtec[nomtec.size()-1] == ' ' || nomtec[nomtec.size()-1] == '	' )
									nomtec.resize(nomtec.size()-1);

								string marca = nomtec;
								bool fin = false;
								for( int i=0; i<yyleng && !fin; i++ )
								{
									if( i > 1 && nomtec[i] == ' ' || nomtec[i] == '	' )
									{
										fin = true;
										marca = nomtec.substr(0,i);
										nomtec = nomtec.substr(i+1);
									}
								}


								nombre = nomtec;
								//cout << "|" << marca << "|" << nombre << "|" << endl;
								if( cpus ) datosCPU.marca = marca;
								if( gpus ) datosGPU.marca = marca;
								if( discos ) datosDiscos.marca = marca;
								if( rams_esc )
								{
									datosRAMs.marca = marca;
									if(nombre.substr(nombre.size()-2)=="MB"||nombre.substr(nombre.size()-2)=="GB")
									{
										for( int i=nombre.size()-1; i>=0; i-- )
										{
											if( nombre[i] == ' ' || nombre[i] == '	' ) 
											{
												datosRAMs.capacidad = nombre.substr(i+1);
												nombre.resize(i);
												i = -1;
											}
										}
									}

								}
								if( rams_lec )
								{
									if(nombre.substr(nombre.size()-2)=="MB"||nombre.substr(nombre.size()-2)=="GB")
									{
										for( int i=nombre.size()-1; i>=0; i-- )
										{
											if( nombre[i] == ' ' || nombre[i] == '	' ) 
											{
												nombre.resize(i);
												i = -1;
											}
										}
									}

								}
								if( leyendo_doc )
								{
									nombre = marca + " " + nombre;
									baseDatos.BuscarYMostrarItem( nombre );
								
								}


						
								// cout << "MARCA: " << datos.marca << endl;	
								//cout << "NOMBRE: " << nombre << endl;
									
							}	
^[^"@"\n"$"\t ]+\n					{	// NOMBRE ÚNICO
								if( discos )
								{	
									nombre = yytext;							
									nombre.resize(nombre.size()-1);
									datosDiscos.marca = nombre; 
									// cout << "MARCA: " << datosDiscos.marca << endl;	
									// cout << "NOMBRE: " << nombre << endl;	
								}
								if( leyendo_doc ){
									baseDatos.PrintItem( nombre );
									nombre = yytext;							
									nombre.resize(nombre.size()-1);
									for( int i=0; i<7; i++ ) analizando[i] = analizando[i+1];
									analizando[7] = nombre;
									for( int i=6; i>=0; i-- )
									{
										nombre = analizando[i] + " " + nombre;
										baseDatos.PrintItem( nombre );
									}
								}
												
							}
"@"[^\n]+						{
								if( cpus )
								{	
									string g = yytext;
									datosCPU.ghz = g.substr(2);
								}
							}
\n							{	// SALTO DE LINEA
								if( meterdatos )
								{
									meterdatos = false;
									while( nombre[nombre.size()-1] == ' ' || nombre[nombre.size()-1] == '	' ) 
										nombre.resize( nombre.size()-1 ); 
									if( cpus ) baseDatos.SetDatosCPU( nombre, datosCPU );
									if( discos ) baseDatos.SetDatosDiscos( nombre, datosDiscos );
									if( gpus ) baseDatos.SetDatosGPU( nombre, datosGPU );
									if( rams_esc ) baseDatos.SetDatosRAMs( nombre, datosRAMs );
									nombre = "";
								}
							}
.							{
								if( leyendo_doc )
								{									
									for( int i=0; i<7; i++ ) analizando[i] = analizando[i+1];
									analizando[7] = nombre;
									for( int i=6; i>=0; i-- )
									{
										nombre = analizando[i] + " " + nombre;
										baseDatos.PrintItem( nombre );
									}
								}
							}

%%

	/*----- Sección de Procedimientos --------*/
const char* filename = "CPUs.txt";
const char* doc;

int main (int argc, char *argv[]) {

	FILE *file;
	
	if( argc != 2 )
	{
		cout << "Error en argumentos" << endl << flush;
		exit(1);
	}	

	doc = argv[1];
	

	
	file = fopen (filename, "rt");
 

  	yyrestart(file);

	meterdatos = false;
	nombre = "";

	gpus = discos = rams_esc = rams_lec = leyendo_doc = false;
	cpus = true;

	for( int i=0; i<8; i++ ) analizando[i]="";


	baseDatos.PrintIntro();

	yylex ();
	//baseDatos.PrintRAMs();
	//baseDatos.PrintItem("Core i7-5930K");
	baseDatos.PrintTops();

	return 0;
}




int yywrap () {
	FILE *file;
	fclose( yyin );
	if( cpus ){
		cpus = false;
		gpus = true;
		filename = "GPUs.txt";
		file = fopen( filename, "rt" );
		yyrestart(file);
	}
	else if( gpus ){
		gpus = false;
		discos = true;
		filename = "Discos.txt";
		file = fopen( filename, "rt" );
		yyrestart(file);
	}
	else if( discos ){
		discos = false;
		rams_esc = true;
		filename = "RAMsEsc.txt";
		file = fopen( filename, "rt" );
		yyrestart(file);
	}
	else if( rams_esc ){
		rams_esc = false;
		rams_lec = true;
		filename = "RAMsLec.txt";
		file = fopen( filename, "rt" );
		yyrestart(file);
	}
	else if( rams_lec ){
		rams_lec = false;
		leyendo_doc = true;
		file = fopen( doc, "rt" );
		yyrestart(file);
	}
	else if( leyendo_doc ) return 1; 
}











