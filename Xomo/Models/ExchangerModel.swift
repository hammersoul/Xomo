//
//  ExchangerModel.swift
//  Xomo
//

import Foundation

struct ExchangerModel {
    let name: String
    let reserve: String
    let give: String
    let receive: String
    let url: String
    
    init(name: String, reserve: String, give: String, receive: String, url: String) {
        self.name = name
        self.reserve = reserve
        self.give = give
        self.receive = receive
        self.url = url
    }
}
