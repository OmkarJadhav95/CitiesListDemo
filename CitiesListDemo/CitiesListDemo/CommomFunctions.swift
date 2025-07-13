//
//  CommomFunctions.swift
//  CitiesListDemo
//
//  Created by Omkar Jadhav on 09/05/24.
//

import Foundation

// Load data from file
func loadDataFromJsonFile() -> [CityData]? {
    guard let fileURL = Bundle.main.url(forResource: "au_cities", withExtension: "json") else {
        return nil
    }
    
    do {
        let data = try Data(contentsOf: fileURL)
        let cities = try JSONDecoder().decode([CityData].self, from: data)
        return cities
    } catch {
        print("Error loading data: \(error.localizedDescription)")
    }
    return nil
}
