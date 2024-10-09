//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by mac on 08/10/2024.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingMessage = false
    @State private var isError = false
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(
                for: request, from: encoded
            )
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            
            showingMessage = true
            isError = false
            
        } catch {
            print("CheckOut failed: \(error.localizedDescription)")
            confirmationMessage = "Failed to place order: \(error.localizedDescription)"
            isError = true
            showingMessage = true
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(
                    url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                    scale: 3
                ) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text(
                    "Your total cost is \(order.cost, format: .currency(code: "USD"))"
                )
                .font(.title)
                
                Button("Place order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                    .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(isError ? "Error" : "Thank you!", isPresented: $showingMessage) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
