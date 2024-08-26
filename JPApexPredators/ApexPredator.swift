//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Filip Simandl on 08.08.2024.
//

import Foundation
import SwiftUI
import MapKit

// decodable - were gonna be taking data from json or something else
struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [PredatorMovie]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    // if we dont assing the raw values, the word itself will be the string
    case all
    case land
    case air
    case sea
    
    var id: PredatorType {
        self
    }
    
    var background: Color {
        switch self {
        case .all:
            .black
        case .land:
            .brown
        case .air:
            .teal
        case .sea:
            .blue
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}

enum PredatorMovie: String, Decodable, CaseIterable, Identifiable {
    case all = "All Movies"
    case jurassicPark = "Jurassic Park"
    case lostWorld = "The Lost World: Jurassic Park"
    case jurassicPark3 = "Jurassic Park III"
    case jurassicWorld = "Jurassic World"
    case fallenKingdom = "Jurassic World: Fallen Kingdom"
    case dominion = "Jurassic World: Dominion"
    
    var id: String { rawValue }
}
