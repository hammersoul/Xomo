//
//  ParseNews.swift
//  Xomo
//

import Foundation
import SwiftSoup

final class ParseNews {
    
    static let shared = ParseNews()
    
    private let url = "https://bits.media/cryptocurrency/?nav_main=page-"
    var news = [NewsModel]()
    var page = 1
    
    // MARK: News Parsing
    
    func parse(completion: @escaping (([NewsModel]) -> Void), page: Int) {
        DispatchQueue.global().asyncAfter(deadline: .now()) { [weak self] in
            if let url = URL(string: self!.url + String(page)) {
                do {
                    let html = try String(contentsOf: url)
                    let document: Document = try SwiftSoup.parse(html)
                    
                    let elementsTitle: Elements = try document.getElementsByClass("news-name")
                    let elementsDate: Elements = try document.getElementsByClass("news-date")
                    let elementsURL: Elements = try document.getElementsByClass("news-link")
                    
                    if elementsTitle.count == elementsDate.count && elementsTitle.count == elementsURL.count {
                        for index in 0..<elementsTitle.count {
                            let oneNews = try NewsModel(title: elementsTitle[index].text(), url: "https://bits.media" + elementsURL[index].attr("href"), data: elementsDate[index].text())
                            
                            self?.news.append(oneNews)
                        }
                    } else {
                        completion([])
                    }
                    
                    completion(self?.news ?? [])
                } catch {
                    completion([])
                }
            }
        }
    }
}
