//
//  ContentView.swift
//  CitiesListDemo
//
//  Created by Omkar Jadhav on 08/05/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CityViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(self.viewModel.mAllCitiesInfo.mStateNames), id: \.self) { section in
                    Section(header: Text(section)) {
                        ForEach(self.viewModel.mAllCitiesInfo.mAllSectionsInfo[section] ?? []) { city in
                            NavigationLink {
                                CityDetailsView(city: city)
                            } label: {
                                Text(city.city)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Cities", displayMode: .inline)
            .navigationBarColor(backgroundColor: UIColor(red: 68.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 1.0), titleColor: .white)
        }
        .onAppear {
            // It will use when we fetch cities list from api
            self.viewModel.fetchCitiesData()
        }
    }
}


#Preview {
    ContentView()
}
