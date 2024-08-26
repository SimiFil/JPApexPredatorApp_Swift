//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Filip Simandl on 08.08.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = PredatorType.all
    @State var selectedMovie = PredatorMovie.all.rawValue
    
    var predators = Predators()
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection, by: selectedMovie)
        
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    @State private var isWiggling = true
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                } label: {
                    HStack {
//                        if isWiggling {
//                            // delete button - had to use just image because it interfered with the "NavigationLink"
//                            Image(systemName: "x.square.fill")
//                                .font(.title)
//                                .padding(.trailing, 13)
//                                .foregroundStyle(Color(.sRGB, red: 0.595, green: 0, blue: 0, opacity: 1.0))
//                                .onTapGesture {
//                                    withAnimation {
//                                        print("removing \(predator.name)")
//                                    }
//                                }
//                            
//                        }
                        
                        
                        // dino image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            // name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                    //                    .scaleEffect(isWiggling ? 1.005 : 1.0)  // Scale for wiggle effect
                    //                    .rotationEffect(Angle.degrees(isWiggling ? 5 : 0))  // Rotate for wiggle effect
                    //                    .animation(.easeInOut(duration: 0.1).repeatForever(autoreverses: true), value: isWiggling) // Continuous animation
//                    .onLongPressGesture {
//                        isWiggling = true
//                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        //                        alphabetical ? Image(systemName: "film") : Image(systemName: "textformat")
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Text("Type Filter")
                        
                        Picker("TypeFilter", selection: $currentSelection.animation()) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                        //                        
                        Text("Movie Filter")
                        
                        Picker("MovieFilter", selection: $selectedMovie) {
                            ForEach(PredatorMovie.allCases) { movie in
                                Label(movie.rawValue, systemImage: "film")
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
