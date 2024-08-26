//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Filip Simandl on 18.08.2024.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    
    @State var position: MapCameraPosition
    @State var satellite: Bool = false
    @State var selectedPredator: ApexPredator? = nil
    @State var showDinoInfo: Bool = false
    
    // custom colors
    let darkBlue = Color(.sRGB, red: 0, green: 0, blue: 0.5, opacity: 1.0)
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    if selectedPredator?.name == predator.name && showDinoInfo {
                        HStack(alignment: .center) {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .shadow(color: .white, radius: 3)
                                .scaleEffect(x: -1)
                                .padding(.trailing, 25)
                            
                            
                            VStack(alignment: .leading) {
                                Text(selectedPredator!.name + "\n")
                                    .font(.headline)
                                    .foregroundStyle(LinearGradient(
                                        colors: [.black, darkBlue, .purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                                
                                Text("The movies this Apex Predator is in:")
                                    .font(.subheadline)
                                
                                ForEach(predator.movies, id: \.self) { movie in
                                    Text("•" + movie.rawValue)
                                        .font(.caption)
                                }
                            }
                            .frame(width: 200, height: 200)
                            .background(.white.opacity(0.6))
                            .clipShape(.rect(cornerRadius: 10))
                        }
                        .foregroundStyle(.black)
                        .padding()
                        .onTapGesture {
                            selectedPredator = predator
                            showDinoInfo.toggle()
                        }
                        
                        
                    } else  {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .shadow(color: .white, radius: 3)
                            .scaleEffect(x: -1)
                            .onTapGesture {
                                selectedPredator = predator
                                showDinoInfo.toggle()
                            }
                    }
                }
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding(.trailing, 15)
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 1200, heading: 250, pitch: 80))
    )
    .preferredColorScheme(.dark)
}
