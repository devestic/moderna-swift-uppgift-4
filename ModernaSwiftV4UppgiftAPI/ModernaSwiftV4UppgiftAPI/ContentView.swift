//
//  ContentView.swift
//  ModernaSwiftV4UppgiftAPI
//
//

import SwiftUI

struct ContentView: View {
    
    @State var duckURL: String = "https://random-d.uk/api/2.jpg"
    
    var body: some View {
 
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Random Ducks")
            AsyncImage(url: URL(string: duckURL))
            Button("Click to change image") {
                Task {
                    await changeImage()
                }
            }
          }
        .padding()
    }
    
    func changeImage() async {
        let randomDuckUrlString = "https://random-d.uk/api/random"
        
        let randomDuckUrl = URL(string: randomDuckUrlString)
        
        do {
            let (randomDuckData, _) = try await URLSession.shared.data(from: randomDuckUrl!)
            
            if let decodedData = try? JSONDecoder().decode(DuckResponse.self, from: randomDuckData) {
                duckURL = decodedData.url
            }
        }
        catch {
            print("No image could be shown.")
        }
    }
}

#Preview {
    ContentView()
}

struct DuckResponse : Codable {
    var message: String
    var url: String
}
