//
//  ViewController.swift
//  ListaPaisesCovid
//
//  Created by Mac13 on 25/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tablaPaises: UITableView!
    
    //Instancia del manager
    var covidManager = CovidManager()
    
    //Arreglo que llena la tabla
    var listaPaises: [CovidDatos] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //1.- registrar en la tabla la celda
        tablaPaises.register(UINib(nibName: "CeldaPaisTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        
        //Delegados de tabla
        covidManager.delegado = self
        tablaPaises.delegate = self //hace ref a ViewController
        tablaPaises.dataSource = self
        
        covidManager.buscarEstadisticas()
        
    }//viewdidload
}//viewController

extension ViewController: covidManagerDelegado {
    func actualizar(paises: [CovidDatos]) {
        print("Total de paises: \(paises.count)")
        
        //asigna el array la lista que recibe como parametro
        listaPaises = paises
        
        //Actualizar UI desde algo en segundo plano
        DispatchQueue.main.async {
            self.tablaPaises.reloadData()
        }
    }//func actualizar
}//fin extension covid manager


// MARK: - TABLEVIEW
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaPaises.count
    }//fin table view rows
    
    //2.- Paso 2 para castear celda
    //Metodo para crear celda personalizada: "as! CeldaPaisTableViewCell"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPaises.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPaisTableViewCell
        
        celda.nombrePaisLbl.text = listaPaises[indexPath.row].country
        celda.activosLbl.text = "Casos activos: \(listaPaises[indexPath.row].active ?? 0)"
        celda.recuperadosLbl.text = "Casos Recuperados: \(listaPaises[indexPath.row].recovered)"
        
        //mostrar imagen de api
        if let urlString = listaPaises[indexPath.row].countryInfo?.flag {
            if let imagenURL = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL) else {
                        return
                    }//fin guard let
                    
                    let image = UIImage(data: imagenData)
                    
                    DispatchQueue.main.async {
                        celda.banderaPais.image = image
                    }
                }//dispatch queue
            }//if let imagenurl
        }//if let urlstring
        //celda.imageView?.image = UIImage(systemName: "flag")
        return celda
    }//fin tableview cells
}//fin extension
