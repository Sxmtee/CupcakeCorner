//
//  FormView.swift
//  CupcakeCorner
//
//  Created by mac on 28/09/2024.
//

//Validating and disabling forms

import SwiftUI

struct FormView: View {
    @State private var username = ""
    @State private var email = ""
    
    var disabledForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button ("Create Acount") {
                    //
                }
            }
            .disabled(disabledForm)
        }
    }
}

#Preview {
    FormView()
}
