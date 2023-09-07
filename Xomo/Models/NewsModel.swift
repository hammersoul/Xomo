//
//  ParseNewsModel.swift
//  Xomo
//

import Foundation

struct NewsModel {
    let title: String
    let url: String
    let data: String
    
    init(title: String, url: String, data: String) {
        self.title = title
        self.url = url
        self.data = data
    }
}
