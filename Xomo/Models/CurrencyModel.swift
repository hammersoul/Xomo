//
//  CurrenciesModel.swift
//  Xomo
//

import Foundation

struct CurrencyModel {
    let name: String
    let ticker: String
    let price: String
    let change: String
    let url: String
    
    init(name: String, ticker: String, price: String, change: String, url: String) {
        self.name = name
        self.ticker = ticker
        self.price = price
        self.change = change
        self.url = url
    }
}
