//
//  CovidManager.swift
//  ListaPaisesCovid
//
//  Created by Mac13 on 25/04/22.
//

import Foundation

protocol covidManagerDelegado{
    func actualizar(paises: [CovidDatos])
}

struct CovidManager {
    var delegado: covidManagerDelegado?
    
    func buscarEstadisticas(){
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries/"
        
        if let url = URL(string: urlString){
            let sesion = URLSession(configuration: .default)
            
            let tarea = sesion.dataTask(with: url) { (datos, respuesta, error) in
                if error != nil{
                    print("error al buscar datos: \(error?.localizedDescription)")
                }//if error
                if let datosSeguros = datos{
                    print("Datos seguros")
                    print(datosSeguros)
                    if let listaPaises = self.parsearJSON(datosCovid: datosSeguros){
                        //no importa quien es el delegado, solo se manda la lista de paises
                        delegado?.actualizar(paises: listaPaises)
                        //print("Lista paises: \(listaPaises)")
                    }//fin if let lista paises
                }
            }//let tarea
            
            tarea.resume()
        }//if let url
    }//func buscar estadisticas
    
    //FUNCION PARA PARSEAR UN ARREGLO CON Covid datos
    func parsearJSON(datosCovid: Data) -> [CovidDatos]? {
        let decodificador = JSONDecoder()
        do{
            let datosDecodificados: [CovidDatos] = try decodificador.decode([CovidDatos].self, from: datosCovid)
            
            //se crea array de paises
            let paises: [CovidDatos] = datosDecodificados
            return paises
        }catch{
            print("Error al decodificar JSON: \(error.localizedDescription)")
            return nil
        }
    }//fin parsearJSON
    
}//covid manager
