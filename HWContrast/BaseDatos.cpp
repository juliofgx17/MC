#include "BaseDatos.h"


BaseDatos::BaseDatos(){}

DatosCPU BaseDatos::GetDatosCPU( string nombre_tecnico )
{
  return mapDatosCPU[ nombre_tecnico ];
}

void BaseDatos::SetDatosCPU( string nombre_tecnico, const DatosCPU &datoscpu )
{
  mapDatosCPU.insert( pair<string,DatosCPU>( nombre_tecnico, datoscpu ) );
}




DatosGPU BaseDatos::GetDatosGPU( string nombre_tecnico )
{
  return mapDatosGPU[ nombre_tecnico ];
}

void BaseDatos::SetDatosGPU( string nombre_tecnico, const DatosGPU &datosgpu )
{
  mapDatosGPU.insert( pair<string,DatosGPU >( nombre_tecnico, datosgpu ) );
}




DatosDiscos BaseDatos::GetDatosDiscos( string nombre_tecnico )
{
  return mapDatosDiscos[ nombre_tecnico ];
}

void BaseDatos::SetDatosDiscos( string nombre_tecnico, const DatosDiscos &datosdiscos )
{
  mapDatosDiscos.insert( pair<string,DatosDiscos>( nombre_tecnico, datosdiscos ) );
}





DatosRAMs BaseDatos::GetDatosRAMs( string nombre_tecnico )
{
  return mapDatosRAMs[ nombre_tecnico ];
}

void BaseDatos::SetDatosRAMs( string nombre_tecnico, const DatosRAMs &datosrams )
{
  mapDatosRAMs.insert( pair<string,DatosRAMs>( nombre_tecnico, datosrams ) );
}

void BaseDatos::UpdateVelLec( string nombre_tecnico, int lec )
{
  mapDatosRAMs[nombre_tecnico].velocidad_lec = lec;
}












void BaseDatos::PrintCPUs()
{
  for( unordered_map<string,DatosCPU>::iterator it = mapDatosCPU.begin(); it != mapDatosCPU.end(); ++it )
  {
    cout << "Marca: " << it->second.marca << endl;
    cout << "Modelo: " << it->first << endl;
    cout << "Puntos: " << it->second.puntos << endl;
    if( it->second.ghz != "" ) cout << "Frecuencia: " << it->second.ghz << endl;
    if( it->second.precio != 0.0f ) cout << "Precio: " << it->second.precio << endl;
    else cout << "Precio: NA" << endl;
    cout << endl << endl;
  }
}

void BaseDatos::PrintCPU( string nombre )
{
  	DatosCPU datos = this->GetDatosCPU( nombre );

  CPUsLeidos.insert( pair<string,DatosCPU>( nombre, datos ) );
	cout << "Marca: " << datos.marca << endl;
	cout << "Modelo: " << nombre << endl;
	cout << "Puntos: " << datos.puntos << "pts" << endl;
	if( datos.ghz != "" ) cout << "Frecuencia: " << datos.ghz << endl;
	if( datos.precio != 0.0f ) cout << "Precio: " << datos.precio << "$" << endl;
	else cout << "Precio: NA" << endl;
	cout << endl << endl;

}






void BaseDatos::PrintGPUs()
{
  for( unordered_map<string,DatosGPU >::iterator it = mapDatosGPU.begin(); it != mapDatosGPU.end(); ++it )
  {
    cout << "Modelo: " << it->first << endl;
    cout << "Marca: " << it->second.marca << endl;
    cout << "Puntos: " << it->second.puntos << endl;
    if( it->second.precio != 0.0f ) cout << "Precio: " << it->second.precio << endl;
    else cout << "Precio: NA" << endl;
    cout << endl << endl;
  }
}
void BaseDatos::PrintGPU( string nombre )
{
  	DatosGPU datos = this->GetDatosGPU( nombre );

  GPUsLeidos.insert( pair<string,DatosGPU>( nombre, datos ) );
	cout << "Modelo: " << nombre << endl;
	cout << "Marca: " << datos.marca << endl;
	cout << "Puntos: " << datos.puntos << "pts" << endl;
	if( datos.precio != 0.0f ) cout << "Precio: " << datos.precio << "$" << endl;
	else cout << "Precio: NA" << endl;
	cout << endl << endl;

}





void BaseDatos::PrintDiscos()
{
  for( unordered_map<string,DatosDiscos >::iterator it = mapDatosDiscos.begin(); it != mapDatosDiscos.end(); ++it )
  {
    cout << "Marca: " << it->second.marca << endl;
    cout << "Modelo: " << it->first << endl;
    cout << "Puntos: " << it->second.puntos << endl;
    if( it->second.precio != 0.0f ) cout << "Precio: " << it->second.precio << endl;
    else cout << "Precio: NA" << endl;
    cout << endl << endl;
  }
}
void BaseDatos::PrintDisco( string nombre )
{
  	DatosDiscos datos = this->GetDatosDiscos( nombre );

  DiscosLeidos.insert( pair<string,DatosDiscos>( nombre, datos ) );
	cout << "Marca: " << datos.marca << endl;
	cout << "Modelo: " << nombre << endl;
	cout << "Puntos: " << datos.puntos << "pts" << endl;
	if( datos.precio != 0.0f ) cout << "Precio: " << datos.precio << "$" << endl;
	else cout << "Precio: NA" << endl;
	cout << endl << endl;

}







void BaseDatos::PrintRAMs()
{
  for( unordered_map<string,DatosRAMs >::iterator it = mapDatosRAMs.begin(); it != mapDatosRAMs.end(); ++it )
  {
    cout << "Marca: " << it->second.marca << endl;
    cout << "Modelo: " << it->first << endl;
    cout << "Velocidad de escritura: " << it->second.velocidad_esc << endl;
    cout << "Velocidad de lectura: " << it->second.velocidad_lec << endl;
    cout << "Capacidad: " << it->second.capacidad << endl;
    if( it->second.precio != 0.0f ) cout << "Precio: " << it->second.precio << endl;
    else cout << "Precio: NA" << endl;
    cout << endl << endl;
  }
}
void BaseDatos::PrintRAM( string nombre )
{
  	DatosRAMs datos = this->GetDatosRAMs( nombre );

  RAMsLeidos.insert( pair<string,DatosRAMs>( nombre, datos ) );
	cout << "Marca: " << datos.marca << endl;
	cout << "Modelo: " << nombre << endl;
	cout << "Velocidad de lectura: " << datos.velocidad_lec << endl;
	cout << "Velocidad de escritura: " << datos.velocidad_esc << endl;
	cout << "Capacidad: " << datos.capacidad << endl;
	if( datos.precio != 0.0f ) cout << "Precio: " << datos.precio << "$" << endl;
	else cout << "Precio: NA" << endl;
	cout << endl << endl;

}








void BaseDatos::PrintItem( string nombre )
{
	if( mapDatosCPU.find( nombre ) != mapDatosCPU.end() ) this->PrintCPU( nombre );
	if( mapDatosGPU.find( nombre ) != mapDatosGPU.end() ) this->PrintGPU( nombre );
	if( mapDatosDiscos.find( nombre ) != mapDatosDiscos.end() ) this->PrintDisco( nombre );
	if( mapDatosRAMs.find( nombre ) != mapDatosRAMs.end() ) this->PrintRAM( nombre );
}


bool BaseDatos::Existe( string nombre )
{
	bool existe = false;
	if( mapDatosCPU.find( nombre ) != mapDatosCPU.end() ) existe = true;
	if( mapDatosGPU.find( nombre ) != mapDatosGPU.end() ) existe = true;
	if( mapDatosDiscos.find( nombre ) != mapDatosDiscos.end() ) existe = true;
	if( mapDatosRAMs.find( nombre ) != mapDatosRAMs.end() ) existe = true;

	return existe;
}










void BaseDatos::BuscarYMostrarItem( string frase )
{
  vector<string> palabras;
  string palabra = "";
  for( int i=0; i<frase.size(); i++ )
  {
    if( frase[i] != ' ' && frase[i] != '\t' && frase[i] != ',' && frase[i] != '.' && frase[i] != ';' && frase[i] != ':' ) palabra+=frase[i];
    else
    {
      palabras.push_back(palabra);
      palabra = "";
    }
    if( i==frase.size()-1 ) palabras.push_back(palabra);
  }

  palabra = "";
  int amplitud = palabras.size();
  if( 9 < amplitud ) amplitud = 9;

  for( int i=0; i<palabras.size(); i++ )
  {
    for( int j=0; j<amplitud && j+i<palabras.size(); j++ )
    {
      if( j != 0 ) palabra += " ";
      palabra += palabras[i+j];
      //cout << "PALABRA: |" << palabra << "|" << endl;
      if( palabra.size() > 1 ) this->PrintItem( palabra );
    }
    palabra = "";
  }
}






void BaseDatos::PrintTops()
{

  cout << endl << endl;

  cout << "                               Top de componentes:" << endl;
  cout << "   -------------------------------------------------------------------------" << endl;
  cout << "###############################################################################>" << endl;




  if( CPUsLeidos.size() > 0 )
  {
    cout << endl << endl << "Top CPUs leídas; de mayor a menor puntuación según benchmarkings: " << endl;
    cout << "--------------------------------------------------------------------------------" << endl;
    for( set<pair<string,DatosCPU>,ordersetCPU>::iterator it = CPUsLeidos.begin(); it != CPUsLeidos.end(); ++it )
    {
      cout << it->second.marca << " " << it->first << ":";
      int espacios = 40 - it->second.marca.size() - it->first.size();
      for( int i=0; i<espacios; i++ ) cout << " ";
      cout << "         " << it->second.puntos << " puntos" << endl;
    }
  }

  if( GPUsLeidos.size() > 0 )
  {
    cout << endl << endl << endl << endl << endl << endl << "Top GPUs leídas; de mayor a menor puntuación según benchmarkings: " << endl;
    cout << "--------------------------------------------------------------------------------" << endl;
    for( set<pair<string,DatosGPU>,ordersetGPU>::iterator it = GPUsLeidos.begin(); it != GPUsLeidos.end(); ++it )
    {
      cout << it->second.marca << " " << it->first << ":";
      int espacios = 40 - it->second.marca.size() - it->first.size();
      for( int i=0; i<espacios; i++ ) cout << " ";
      cout << "         " << it->second.puntos << " puntos" << endl;
    }
  }

  if( DiscosLeidos.size() > 0 )
  {
    cout << endl << endl << endl << endl << endl << endl << "Top discos duros leídos; de mayor a menor puntuación según benchmarkings: " << endl;
    cout << "--------------------------------------------------------------------------------" << endl;
    for( set<pair<string,DatosDiscos>,ordersetDiscos>::iterator it = DiscosLeidos.begin(); it != DiscosLeidos.end(); ++it )
    {
      cout << it->second.marca << " " << it->first << ":";
      int espacios = 40 - it->second.marca.size() - it->first.size();
      for( int i=0; i<espacios; i++ ) cout << " ";
      cout << "         " << it->second.puntos << " puntos" << endl;
    }
  }

  if( GPUsLeidos.size() > 0 )
  {
    cout << endl << endl << endl <<  endl <<endl << endl << "Top memorias RAM leídas; ordenadas por velocidad de lectura según benchmarkings: " << endl;
    cout << "--------------------------------------------------------------------------------" << endl;
    for( set<pair<string,DatosRAMs>,ordersetRAMs>::iterator it = RAMsLeidos.begin(); it != RAMsLeidos.end(); ++it )
    {
      cout << it->second.marca << " " << it->first << " (" << it->second.capacidad << ")" ;
      int espacios = 35 - it->second.marca.size() - it->first.size() - it->second.capacidad.size();
      for( int i=0; i<espacios; i++ ) cout << " ";
      cout << "      " << "Lec: " << it->second.velocidad_lec << " MB/s.";
      cout << "  " << "Esc: " << it->second.velocidad_esc << " MB/s" << endl;
    }
  }



  cout << endl << endl << endl << endl << endl << endl << endl;
  cout << "--------------------------------------------------------------------------------" << endl;
  cout << "                Julio A. Fresneda   ---  github.com/juliofgx17" << endl;
  cout << "                       Fuente de datos: cpubenchmark.net" << endl;
  cout << "--------------------------------------------------------------------------------" << endl;

}




void BaseDatos::PrintIntro()
{
  cout << endl << endl;
  cout << "###############################################################################>" << endl;
  cout << "                                  HWContrast" << endl;
  cout << "   ----------------------------------------------------------------------------" << endl;
  cout << "        Estos son los componentes que se han captado en el documento " << endl;
  cout << "###############################################################################>" << endl;
  cout << endl << endl << endl ;
}
