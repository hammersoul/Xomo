//
//  ParseNewsModel.swift
//  Xomo
//

import Foundation

struct NewsModel {
    let title: String
    let url: String
    let date: String
    
    init(title: String, url: String, data: String) {
        self.title = title
        self.url = url
        self.date = data
    }
}
