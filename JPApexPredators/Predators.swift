//
//  Predators.swift
//  JPApexPredators
//
//  Created by Filip Simandl on 08.08.2024.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredator] = []
    var allApexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() -> Void {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return self.apexPredators
        } else {
            return self.apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { pred1, pred2 in
            if alphabetical {
                pred1.name < pred2.name
            } else {
                pred1.id < pred2.id
            }
        }
    }
    
    func filter(by type: PredatorType, by movie: PredatorMovie.RawValue) {
        if type == .all && movie == PredatorMovie.all.rawValue {
            apexPredators = allApexPredators
        } else if type == .all && movie != PredatorMovie.all.rawValue {
            apexPredators = allApexPredators.filter { predator in
                predator.movies.contains(PredatorMovie(rawValue: movie)!)
            }
        } else if type != .all && movie == PredatorMovie.all.rawValue {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        } else {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type && predator.movies.contains(PredatorMovie(rawValue: movie)!)
            }
        }
    }
}
