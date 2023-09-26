//
//  AllExchangerModel.swift
//  Xomo
//

import Foundation

struct AllExchangerModel {
    let name: String
    let reserve: String
    let status: String
    let reviews: String
    let url: String
    
    init(name: String, reserve: String, status: String, reviews: String, url: String) {
        self.name = name
        self.reserve = reserve
        self.status = status
        self.reviews = reviews
        self.url = url
    }
}

