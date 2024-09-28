//
//  AsyncImages.swift
//  CupcakeCorner
//
//  Created by mac on 28/09/2024.
//

//Loading an image from a remote server

import SwiftUI

struct AsyncImages: View {
    var body: some View {
        AsyncImage(
            url: URL(string: "https://hws.dev/img/logo.png")
        ) { phase in
            if let image = phase.image {
                image.resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    AsyncImages()
}
