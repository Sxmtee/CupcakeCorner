//
//  CodableConformance.swift
//  CupcakeCorner
//
//  Created by mac on 28/09/2024.
//

//Adding Codable conformance to an @Observable class

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name = "Taylor"
}

struct CodableConformance: View {
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
    
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
}

#Preview {
    CodableConformance()
}
