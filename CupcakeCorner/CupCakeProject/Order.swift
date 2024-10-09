//
//  Order.swift
//  CupcakeCorner
//
//  Created by mac on 28/09/2024.
//

import Foundation

@Observable
class Order: Codable {
    static let types = [
        "Vanilla",
        "Strawberry",
        "Chocolate",
        "Rainbow"
    ]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        //$2 per cake
        var cost = Decimal(quantity) * 2
        
        //complicated cakes cost more
        cost += Decimal(type) / 2
        
        //$1 cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        //$0.50 cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
