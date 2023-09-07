//
//  ParseNews.swift
//  Xomo
//

import Foundation
import SwiftSoup

final class ParseNews {
    
    static let shared = ParseNews()
    
    let url = "https://bits.media/cryptocurrency/?nav_main=page-"
    public  var news = [NewsModel]()

    func parse(completion: @escaping (([NewsModel]) -> Void), page: String = "1") {
        DispatchQueue.global().asyncAfter(deadline: .now()) { [weak self] in
            if let url = URL(string: self!.url + page) {
                do {
                    let html = try String(contentsOf: url)
                    let document: Document = try SwiftSoup.parse(html)

                    let elementsTitle: Elements = try document.getElementsByClass("news-name")
                    let elementsData: Elements = try document.getElementsByClass("news-date")
                    let elementsUrl: Elements = try document.getElementsByClass("news-link")

                    for index in 0..<elementsTitle.count {
                        let oneNews = try NewsModel(title: elementsTitle[index].text(), url: "https://bits.media" + elementsUrl[index].attr("href"), data: elementsData[index].text())

                        self?.news.append(oneNews)
                    }
                    
                    completion(self?.news ?? [])
                } catch {
                    print("Error get news")
                }
            }
        }
    }
}
