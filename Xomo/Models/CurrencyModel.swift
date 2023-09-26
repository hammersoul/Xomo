//
//  CurrenciesModel.swift
//  Xomo
//

import Foundation

struct CurrencyModel {
    let name: String
    let ticker: String
    let priceOne: String
    let priceTwo: String
    
    init(name: String, ticker: String, priceOne: String, priceTwo: String) {
        self.name = name
        self.ticker = ticker
        self.priceOne = priceOne
        self.priceTwo = priceTwo
    }
}
