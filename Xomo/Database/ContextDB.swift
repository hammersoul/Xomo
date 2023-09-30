//
//  ContextDB.swift
//  Xomo
//

import UIKit
import CoreData

final class ContextDB {
    
    static let shared = ContextDB()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: Get All Objects
    
    func allCurrencies() -> [Currencies] {
        var currencies = [Currencies]()
        
        do {
            currencies = try context.fetch(Currencies.fetchRequest())
        } catch {
            
        }
        return currencies
    }
    
    func allCurrenciesURL() -> [String] {
        var url = [String]()
        
        for currency in allCurrencies() {
            url.append(currency.url!)
        }
    
        return url
    }
    
    func allRatingExchangers() -> [RatingExchangers] {
        var exchangers = [RatingExchangers]()
        
        do {
            exchangers = try context.fetch(RatingExchangers.fetchRequest())
        } catch {
            
        }
        return exchangers
    }
    
    func allHistory() -> [History] {
        var history = [History]()
        
        do {
            history = try context.fetch(History.fetchRequest())
        } catch {
            
        }
        return history
    }
    
    // MARK: Create Object
    
    func createCurrency(currency: CurrencyModel) {
        let newCurrency = Currencies(context: context)
        
        newCurrency.name = currency.name
        newCurrency.ticker = currency.ticker
        newCurrency.price = currency.price
        newCurrency.change = currency.change
        newCurrency.url = currency.url
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    func createExchanger(exchanger: RatingExchangersModel) {
        let newExchanger = RatingExchangers(context: context)
        
        newExchanger.name = exchanger.name
        newExchanger.reserve = exchanger.reserve
        newExchanger.reviews = exchanger.reviews
        newExchanger.status = exchanger.status
        newExchanger.url = exchanger.url
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    func createHistory(name: String, give: String, receive: String, reserve: String, url: String) {
        let newHistory = History(context: context)
        
        newHistory.name = name
        newHistory.give = give
        newHistory.receive = receive
        newHistory.reserve = reserve
        newHistory.url = url
        newHistory.date = Resources.getDate()
        
        do {
            try context.save()
            
        } catch {
            
        }
    }
    
    // MARK: Delete Object
    
    func deleteCurrency(ticker: String) {
        for currency in allCurrencies() {
            if currency.ticker == ticker {
                context.delete(currency)
                do {
                    try context.save()
                } catch {
                    
                }
                
                 break
            }
        }
    }
    
    func deleteExchanger(name: String) {
        for exchanger in allRatingExchangers() {
            if exchanger.name == name {
                context.delete(exchanger)
                do {
                    try context.save()
                } catch {
                    
                }
                
                 break
            }
        }
    }
    
    func deleteAllHistory() {
        let fetchRequest = History.fetchRequest()
        let allHistory = try? context.fetch(fetchRequest)
        for history in allHistory ?? [] {
            context.delete(history)
        }
        try? context.save()
    }
    
    func deleteAllExchangers() {
        let fetchRequest = RatingExchangers.fetchRequest()
        let allExchangers = try? context.fetch(fetchRequest)
        for exchangers in allExchangers ?? [] {
            context.delete(exchangers)
        }
        try? context.save()
    }
    
    func deleteAllCurrencies() {
        let fetchRequest = Currencies.fetchRequest()
        let currencies = try? context.fetch(fetchRequest)
        for currency in currencies ?? [] {
            context.delete(currency)
        }
        try? context.save()
    }
    
    // MARK: Check Uniqueness
    
    func checkCurrency(ticker: String) -> Bool {
        return allCurrencies().contains(where: {$0.ticker == ticker})
    }
    
    func checkExchanger(name: String) -> Bool {
        return allRatingExchangers().contains(where: {$0.name == name})
    }
}
