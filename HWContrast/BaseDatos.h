#include <unordered_map>
#include <set>
#include "iostream"
#include "DatosCPU.h"
#include "DatosDiscos.h"
#include "DatosRAMs.h"
#include "DatosGPU.h"
#include "string"
#include <vector>
using namespace std;




class BaseDatos
{
private:

  // Maps donde se guardan los datos capturados de CPUs.txt, GPUs.txt, Discos.txt, RAMsEsc.txt y RAMsLec.txt
  unordered_map<string, DatosCPU> mapDatosCPU;
  unordered_map<string, DatosGPU> mapDatosGPU;
  unordered_map<string, DatosDiscos> mapDatosDiscos;
  unordered_map<string, DatosRAMs> mapDatosRAMs;


  // Métodos para que los set sepan cómo ordenar los datos
  struct ordersetCPU{
    bool operator()( const pair<string,DatosCPU> &d, const pair<string,DatosCPU> &d2 )
    {
      return d.second.puntos >= d2.second.puntos;
    }
  };
  struct ordersetGPU{
    bool operator()( const pair<string,DatosGPU> &d, const pair<string,DatosGPU> &d2 )
    {
      return d.second.puntos >= d2.second.puntos;
    }
  };
  struct ordersetDiscos{
    bool operator()( const pair<string,DatosDiscos> &d, const pair<string,DatosDiscos> &d2 )
    {
      return d.second.puntos >= d2.second.puntos;
    }
  };
  struct ordersetRAMs{
    bool operator()( const pair<string,DatosRAMs> &d, const pair<string,DatosRAMs> &d2 )
    {
      return d.second.velocidad_lec >= d2.second.velocidad_lec;
    }
  };


  // Set para hacer los tops, ordenados de mayor a menor puntuación
  set<pair<string,DatosCPU>,ordersetCPU> CPUsLeidos;
  set<pair<string,DatosGPU>,ordersetGPU> GPUsLeidos;
  set<pair<string,DatosDiscos>,ordersetDiscos> DiscosLeidos;
  set<pair<string,DatosRAMs>,ordersetRAMs> RAMsLeidos;




public:

  BaseDatos();

  // Gets y Sets de los datos
  DatosCPU GetDatosCPU( string nombre_tecnico );
  void SetDatosCPU( string nombre_tecnico, const DatosCPU &datoscpu );

  DatosGPU GetDatosGPU( string nombre_tecnico );
  void SetDatosGPU( string nombre_tecnico, const DatosGPU &datosgpu );

  DatosDiscos GetDatosDiscos( string nombre_tecnico );
  void SetDatosDiscos( string nombre_tecnico, const DatosDiscos &datosdiscos );

  DatosRAMs GetDatosRAMs( string nombre_tecnico );
  void SetDatosRAMs( string nombre_tecnico, const DatosRAMs &datosrams);
  void UpdateVelLec( string nombre_tecnico, int lec );  // Actualiza la velocidad de lectura de la RAM



  // Busca los componentes que estén en la frase pasada como argumento
  void BuscarYMostrarItem( string frase );


  // Muestran en pantalla todos los componentes de esa categoría
  void PrintCPUs();
  void PrintGPUs();
  void PrintDiscos();
  void PrintRAMs();

  // Muestran en pantalla un componente específico
  void PrintCPU( string nombre );
  void PrintGPU( string nombre );
  void PrintDisco( string nombre );
  void PrintRAM( string nombre );
  void PrintItem( string nombre );

  bool Existe( string nombre );

  // Muestra en pantalla los tops
  void PrintTops();

  // Intro del programa
  void PrintIntro();




};
