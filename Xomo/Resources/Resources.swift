//
//  Resources.swift
//  Xomo
//

import UIKit

final class Resources {
    
    // MARK: Menu Title
    
    enum MenuTitle {
        static var currencies = "Валюты"
        static var news = "Новости"
        static var home = "Обменники"
        static var history = "История"
        static var profile = "Профиль"
    }
    
    // MARK: Fonts & Color
    
    static let tabBarItemLight = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    
    // MARK: Get Today Day
    
    static func getDate() -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter.string(from: time as Date)
    }
    
    // MARK: Formatter Price
    
    static func formatterPrice(price: String) -> String {
        if let priceFormatter = Double(price) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            formatter.maximumFractionDigits = 2

            let result = formatter.string(from: NSNumber(value: priceFormatter))
            
            return result ?? price
        } else {
            return price
        }
    }
    
    // MARK: Picker Model Exchangers

    static let pickerModelValue = [
        "Сбербанк RUB", "Bitcoin BTC", "QIWI RUB", "Tether USDT", "Тинькофф RUB", "Приват24 UAH", "Ethereum ETH", "Tron TRX", "ЮMoney RUB", "Litecoin LTC", "Dogecoin DOGE", "Monobank UAH", "Ripple XRP", "DASH", "Bitcoin BEP20 BTC", "Ethereum BEP20 ETH", "Ethereum Classic ETC", "Tether ERC USDT", "Tether BEP20 USDT", "Tether Omni USDT", "Bitcoin Cash BCH", "Bitcoin SV BSV", "Binance Coin BNB", "Binance Coin BEP20 BNB", "USD Coin USDC", "USD Coin ERC20 USDC", "Cardano ADA", "Monero XMR", "Stellar XLM", "EOS EOS", "Lisk LSK", "Qtum QTUM", "TrueUSD TUSD", "Verge XVG", "WAVES (WAVES)", "Zcash ZEC", "Decred DCR", "IOTA MIOTA", "NEM XEM", "Bitcoin Gold BTG", "OmiseGO OMG", "VeChain VET", "Pax Dollar USDP", "0x ZRX", "Basic Attention Token BAT", "Cosmos ATOM", "Chainlink LINK", "Tezos XTZ", "Komodo KMD", "ICON (ICX)", "Ontology ONT", "Polkadot DOT", "Algorand ALGO", "Uniswap UNI", "Binance USD BUSD", "Solana SOL", "SHIBA INU SHIB", "Polygon MATIC", "Polygon MATIC ERC20", "Decentraland MANA", "Avalanche AVAX", "AVAX C-Chain AVAXC", "AAVE", "KAVA", "Wrapped BTC ERC20 WBTC", "ApeCoin APE", "1inch Network 1INCH", "Aptos APT", "Fantom FTM", "BNB Smart Chain BSC",
        
        "Сбербанк KZT", "Альфа Банк RUB", "Sense Банк (Альфа) UAH", "Приват24 USD", "Беларусбанк BYN", "Райффайзен RUB", "Райффайзен UAH", "Kaspi Bank KZT", "Jysan Bank KZT", "ForteBank KZT", "ПУМБ UAH", "ОТП Банк RUB", "UniCredit RUB", "UkrSibBank UAH", "Ак Барс Банк RUB", "Visa/Master UAH", "Visa/Master RUB", "Visa/Master USD", "Visa/Master EUR", "Visa/Master KZT", "Visa/Master BYN", "Visa/Master AMD", "Visa/Master MDL", "Перевод UAH", "Перевод USD", "Перевод RUB", "Перевод EUR", "Перевод KZT", "Перевод GBP", "Перевод CNY", "Перевод THB", "Перевод PLN",
        
        "QIWI KZT", "Wise USD", "Wise EUR", "WebMoney WMZ", "WebMoney WMK", "WebMoney WMX", "Paymer USD", "Perfect Money USD", "Perfect Money EUR", "Perfect Money BTC", "PM e-Voucher USD", "AdvCash USD", "AdvCash RUB", "AdvCash UAH", "AdvCash EUR", "AdvCash KZT", "Payeer USD", "Payeer RUB", "Payeer EUR", "Capitalist USD", "Capitalist RUB", "PayPal USD", "PayPal EUR", "PayPal RUB", "PayPal GBP", "Skrill USD", "Skrill EUR", "Epay USD", "Epay EUR", "NixMoney USD", "NixMoney EUR", "Neteller USD", "Neteller EUR", "PaySera USD", "PaySera EUR",
        
        "Наличные USD", "Наличные RUB", "Наличные EUR", "Наличные UAH", "Наличные KZT",
        
        "EXMO USD", "EXMO RUB", "EXMO EUR", "EXMO UAH", "EXMO BTC", "Cryptex USD", "KUNA UAH"
    ]
    
    static let pickerModelKey = [
        "SBERRUB", "BTC", "QWRUB", "USDTTRC20", "TCSBRUB", "P24UAH", "ETH", "TRX", "YAMRUB", "LTC", "DOGE", "MONOBUAH", "XRP", "DASH", "BTCBEP20", "ETHBEP20", "ETC", "USDTERC20", "USDTBEP20", "USDTOMNI", "BCH", "BSV", "BNB", "BNBBEP20", "USDC", "USDCERC20", "ADA", "XMR", "XLM", "EOS", "LSK", "QTUM", "TUSD", "XVG", "WAVES", "ZEC", "DCR", "IOTA", "XEM", "BTG", "OMG", "VET", "USDP", "ZRX", "BAT", "ATOM", "LINK", "XTZ", "KMD", "ICX", "ONT", "DOT", "ALGO", "UNI", "BUSD", "SOL", "SHIB", "MATIC", "MATICERC20", "MANA", "AVAX", "AVAXC", "AAVE", "KAVA", "WBTERC20", "APE", "1INCH", "APT", "FTM", "BSC",
        
        "SBERKZT", "ACRUB", "ACUAH", "P24USD", "BLRBBYN", "RFBRUB", "RFBUAH", "KSPBKZT", "JSNBKZT", "FRTBKZT", "PMBBUAH", "OTPBRUB", "UNCBRUB", "USBUAH", "AKBRSBRUB", "CARDUAH", "CARDRUB", "CARDUSD", "CARDEUR", "CARDKZT", "CARDBYN", "CARDAMD", "CARDMDL", "WIREUAH", "WIREUSD", "WIRERUB", "WIREEUR", "WIREKZT", "WIREGBP", "WIRECNY", "WIRETHB", "WIREPLN",
        
        "QWKZT", "WISEUSD", "WISEEUR", "WMZ", "WMK", "WMX", "PMRUSD", "PMUSD", "PMEUR", "PMBTC", "PMVUSD", "ADVCUSD", "ADVCRUB", "ADVCUAH", "ADVCEUR", "ADVCKZT", "PRUSD", "PRRUB", "PREUR", "CPTSUSD", "CPTSRUB", "PPUSD", "PPEUR", "PPRUB", "PPGBP", "SKLUSD", "SKLEUR", "EPAYUSD", "EPAYEUR", "NIXUSD", "NIXEUR", "NTLRUSD", "NTLREUR", "PSRUSD", "PSREUR",
        
        "CASHUSD", "CASHRUB", "CASHEUR", "CASHUAH", "CASHKZT",
        
        "EXMUSD", "EXMRUB", "EXMEUR", "EXMUAH", "EXMBTC", "CRXUSD", "KUNAUAH"
    ]
    
    static let pickerModel = [pickerModelValue, pickerModelValue]
    static let pickerModelDictionary = Dictionary(uniqueKeysWithValues: zip(pickerModelKey, pickerModelValue))
    
    // MARK: Picker Model Converter
    
    static let pickerModelConverterGive = ["RUB", "USD", "AED", "AMD", "AUD", "AZN", "BGN", "BRL", "BYN", "CAD", "CHF", "CNY", "CZK", "DKK", "GBR", "GEL", "HKD", "HUF", "IDR", "INR", "JPY", "KGS", "KRW", "KZT", "MDL", "NOK", "PLN", "QAR", "RON", "RSD", "SEK", "SGD", "THB", "TJS", "TMT", "TRY", "UAH", "UZS", "VND", "XDR", "ZAR"]
    static let pickerModelConverterReceive = pickerModelConverterGive
    
    static let pickerModelConverter = [pickerModelConverterGive, pickerModelConverterReceive]
}
