//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by mac on 26/09/2024.
//


// Sending and receiving Codable data with URLSession and SwiftUI

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    
    func loadData() async {
        //step 1 = declare your url
        guard let url = URL(
            string: "https://itunes.apple.com/search?term=taylor+swift&entity=song"
        ) else {
            print("Invalid URL")
            return
        }
        
        //step 2 = fetch the data from the url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(
                Response.self, from: data
            ) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
    
    var body: some View {
        List (results, id: \.trackId) { item in
            VStack (alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
}

#Preview {
    ContentView()
}
