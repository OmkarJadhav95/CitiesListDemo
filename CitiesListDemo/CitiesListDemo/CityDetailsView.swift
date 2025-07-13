//
//  CityDetailsView.swift
//  CitiesListDemo
//
//  Created by Omkar Jadhav on 08/05/24.
//

import SwiftUI

struct CityDetailsView: View {
    var city: CityData?
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Name: ")
                Text(city?.city ?? "")
            }
            HStack {
                Text("State: ")
                Text(city?.adminName ?? "")
            }
            HStack {
                Text("Capital: ")
                Text(city?.capital ?? "")
            }
            HStack {
                Text("lat: ")
                Text(city?.lat ?? "")
            }
            HStack {
                Text("lng: ")
                Text(city?.lng ?? "")
            }
            HStack {
                Text("country: ")
                Text(city?.country ?? "")
            }
            HStack {
                Text("iso2: ")
                Text(city?.iso2 ?? "")
            }
            HStack {
                Text("Population: ")
                Text(city?.population ?? "")
            }
            HStack {
                Text("Population proper: ")
                Text(city?.populationProper ?? "")
            }
            
            Spacer()
        }
    }
}

#Preview {
    CityDetailsView(city: nil)
}
