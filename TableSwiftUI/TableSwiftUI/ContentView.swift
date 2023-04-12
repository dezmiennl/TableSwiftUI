//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Dezmien Lugo on 4/11/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Wake the Dead Coffee House", neighborhood: "Alamo", desc: "Wake the Dead coffee house is a local San Marcos coffee shop open for late night studying until midnight. The coffee house has some art and interesting decor to enjoy while you drink your coffee or enjoy one of the food options they have. You can listen to the hip music playing indoors or in the patio area outdoors. It's a great working environment that celebrates local artisit and provides a welcoming atmosphere.", lat: 29.90212, long: -97.988086, imageName: "rest1"),
    Item(name: "The Native Blends", neighborhood: "Downtown", desc: "The Native Blends has a variety of drink options and flavors of protein waffles to choose from! Their menu items are delicious and their staff is extremely friendly and welcoming to students in the area. It can be empty at times and at most have a a few small groups of friends chatting alongside some chill study music at a reasonable volume to cover conversation but not distract you from work. Their teas are excellent for students as they're energizing and support brain function!", lat: 29.885309, long: -97.939484, imageName: "rest2"),
    Item(name: "Cheatham Street Flats", neighborhood: "East Guadalupe", desc: "This is is a study spot exclusive to Cheatham Street Flats residents and their guests. The study room at Cheatham has seating and a large tv for you to play your choice of music, watch your favorite show, or nothing at all while you get your work done. The study room has a large sliding door to let some fresh air and street noise in if you prefer. The lounge is just across the hall to relax once you finish your study session. ", lat: 29.87642, long: -97.9401, imageName: "rest3"),
    Item(name: "LazyDaze", neighborhood: "Rio Vista", desc: "Lazydaze is one of the chillest and most inviting coffee houses in San Marcos. The environement feels judgement-free and extremely comfortable. The vibe is amzing and added to by the friendly staff. The coffee house is also CBD friendly, relaxing and spacious for cutstomers to enjoy, even with your pets! ", lat: 29.88365, long: -97.92372, imageName: "rest4"),
    Item(name: "Rio Vista Park", neighborhood: "Rio Vista", desc: "Rio vista park is a local San Marcos with an extremely relaxing atmosphere that let's you appreciate the natural beauty of San Marcos while studying and getting work done. You can walk the short trail for a brain break in between and even walk to the park depending on what area of San Marcos you live in. The sounds of the leaves blowing and water crashing is extremely calming and allows for efficient work to be done without distracting noise. ", lat: 29.878533, long: -97.931734, imageName: "rest5")
   
]
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let neighborhood: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }





struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.87642, longitude: -97.9401), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.neighborhood)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                               MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                   Image(systemName: "mappin.circle.fill")
                                       .foregroundColor(.red)
                                       .font(.title)
                                       .overlay(
                                           Text(item.name)
                                               .font(.subheadline)
                                               .foregroundColor(.black)
                                               .fixedSize(horizontal: true, vertical: false)
                                               .offset(y: 25)
                                       )
                               }
                           }
                           .frame(height: 300)
                           .padding(.bottom, -30)
                           
            }
            .listStyle(PlainListStyle())
            .navigationTitle("San Mo Study Spots")
        }
    }
}



struct DetailView: View {
    @State private var region: MKCoordinateRegion
          
          init(item: Item) {
              self.item = item
              _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
          }
    
    
         let item: Item
               
       var body: some View {
           VStack {
               Image(item.imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: 200)
               Text("Neighborhood: \(item.neighborhood)")
                   .font(.subheadline)
               Text("Description: \(item.desc)")
                   .font(.subheadline)
                   .padding(10)
                   }
           .navigationTitle(item.name)
                    Spacer()
           Map(coordinateRegion: $region, annotationItems: [item]) { item in
                 MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                     Image(systemName: "mappin.circle.fill")
                         .foregroundColor(.red)
                         .font(.title)
                         .overlay(
                             Text(item.name)
                                 .font(.subheadline)
                                 .foregroundColor(.black)
                                 .fixedSize(horizontal: true, vertical: false)
                                 .offset(y: 25)
                         )
                 }
             }
                 .frame(height: 300)
                 .padding(.bottom, -30)
        }
     }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
