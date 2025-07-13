//
//  CityData.swift
//  CitiesListDemo
//
//  Created by Omkar Jadhav on 08/05/24.
//

import Foundation

struct CityData: Codable, Identifiable {
    let id = UUID()
    let city: String
    let lat: String
    let lng: String
    let country: String
    let iso2: String
    let adminName: String
    let capital: String
    let population: String
    let populationProper: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case city
        case lat
        case lng
        case country
        case iso2
        case adminName = "admin_name"
        case capital
        case population
        case populationProper = "population_proper"
    }
}

struct AllCitiesTableInfo {
    var mStateNames: Array<String>
    var mAllSectionsInfo: [String:[CityData]]
}
