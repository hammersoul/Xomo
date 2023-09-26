//
//  ParseInfo.swift
//  Xomo
//

import Foundation
import SwiftSoup

final class ParseInfo {
    
    static let shared = ParseInfo()
    
    let url = "https://bits.media/beginner/"
    public var info = [InfoModel]()
    
    // MARK: Info Parsing
    
    func parse(completion: @escaping (([InfoModel]) -> Void)) {
        DispatchQueue.global().asyncAfter(deadline: .now()) { [weak self] in
            if let url = URL(string: self!.url) {
                do {
                    let html = try String(contentsOf: url)
                    let document: Document = try SwiftSoup.parse(html)
                    
                    let elementsTitle: Elements = try document.getElementsByClass("news-name")
                    let elementsURL: Elements = try document.getElementsByClass("news-link")
                    
                    for index in 0..<elementsTitle.count {
                        let oneInfo = try InfoModel(title: elementsTitle[index].text(), url: "https://bits.media" + elementsURL[index].attr("href"))
                        
                        self?.info.append(oneInfo)
                    }
                    
                    completion(self?.info ?? [])
                } catch {
                    print("Error get info")
                }
            }
        }
    }
}
