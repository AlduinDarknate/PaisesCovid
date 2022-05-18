//
//  CovidDatos.swift
//  ListaPaisesCovid
//
//  Created by Mac13 on 25/04/22.
//

import Foundation

struct CovidDatos: Decodable {
    let country: String?
    let active: Double?
    let countryInfo: CountryInfo?
    let recovered: Double
}

struct CountryInfo: Decodable {
    let flag: String?
}
