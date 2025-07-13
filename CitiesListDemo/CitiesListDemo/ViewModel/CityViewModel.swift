//
//  CityViewModel.swift
//  CitiesListDemo
//
//  Created by Omkar Jadhav on 08/05/24.
//

import Foundation

@MainActor
class CityViewModel: ObservableObject {
    
    var arrayAllCities: [CityData] = []
    @Published var mAllCitiesInfo: AllCitiesTableInfo = AllCitiesTableInfo(mStateNames: [], mAllSectionsInfo: [:])
    
    init() {
        if let cities = loadDataFromJsonFile()
        {
            self.arrayAllCities = cities
            self.setUpAllEventDataSource()
        }
    }
    
    // Fetch cities list
    func fetchCitiesData() 
    {
        Task {
            do {
                let responseData = try await NetworkService.shared.fetchCities()
                self.saveCitiesDataToFile(data: responseData)
                let cities = try JSONDecoder().decode([CityData].self, from: responseData)
                self.arrayAllCities = cities
                self.setUpAllEventDataSource()
            }
            catch {
                print("Error fetching cities: \(error.localizedDescription)")
                
                // Check for cache data
                if let cacheData = self.readCitiesDataFromFile()
                {
                    let cities = try JSONDecoder().decode([CityData].self, from: cacheData)
                    self.arrayAllCities = cities
                    self.setUpAllEventDataSource()
                }
            }
        }
    }
    
    // Parse cities data acording to state
    func setUpAllEventDataSource()
    {
        var states: Array<String> = []
        var allSectionsInfo = [String:[CityData]]()
        
        for cityInfo in self.arrayAllCities
        {
            let stateName = cityInfo.adminName
            
            if states.contains(stateName) == false
            {
                states.append(stateName)
                let sectionInfo: [CityData] = []
                allSectionsInfo[stateName] = sectionInfo
            }
            
            if var sectionInfo = allSectionsInfo[stateName]
            {
                sectionInfo.append(cityInfo)
                allSectionsInfo[stateName] = sectionInfo
            }

        }
        
        let sortedNames = states.sorted(by: <)
        
        self.mAllCitiesInfo.mStateNames = sortedNames
        self.mAllCitiesInfo.mAllSectionsInfo = allSectionsInfo
    }
    
    // Caching cities list data fetched from api
    func saveCitiesDataToFile(data: Data)
    {
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("CitiesList") {
            do {
                // Write data to file
                try data.write(to: fileURL)
            } catch {
                print("Error writing JSON data:", error)
            }
            print("JSON data written to file:")
        } else {
            print("Error: Couldn't create file URL.")
        }
    }
    
    // Read cache data of cities list
    func readCitiesDataFromFile() -> Data?
    {
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("CitiesList") {
            do {
                // Read data from the file
                let data = try Data(contentsOf: fileURL)
                return data
            } catch {
                print("Error reading data from file:", error)
            }
        }

        return nil
    }
}
