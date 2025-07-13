//
//  SampleTests.swift
//  CitiesListDemoTests
//
//  Created by Omkar Jadhav on 09/05/24.
//

import XCTest
@testable import CitiesListDemo

final class SampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testParseCitiesFromJSON() throws {
        guard let fileURL = Bundle.main.url(forResource: "au_cities", withExtension: "json") else {
            XCTFail("File not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let cities = try JSONDecoder().decode([CityData].self, from: data)
            XCTAssertGreaterThan(cities.count, 0)
        } catch {
            XCTFail("Failed to parse JSON")
        }
    }
    
    func testFetchCitiesListAPI() {
        let exp = expectation(description:"fetching cities list from server")
        let session: URLSession = URLSession(configuration: .default)
        let url = URL(string: "https://api.example.com/cities")
        guard let customUrl = url else { return }
        
        session.dataTask(with: customUrl) { data, response, error in
            XCTAssertNotNil(data)
            exp.fulfill()
        }.resume()
            waitForExpectations(timeout: 5.0) { (error) in
                print(error?.localizedDescription ?? "error")
        }
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
