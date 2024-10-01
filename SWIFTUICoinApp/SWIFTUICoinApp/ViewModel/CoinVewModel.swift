//
//  CoinVewMode.swift
//  SWIFTUICoinApp
//
//  Created by michael on 29/09/2024.
//

import Foundation



class CoinVewModel: ObservableObject {
    @Published var price: String = "..."
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "c2fc277e-2210-415a-ba8e-eaf59c3045d0"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    func fitchData(currncy:String){
        let url = "\(baseURL)/\(currncy)"
        performRequest(with : url)
    }
    func performRequest(with url : String){
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let saveData = data{
                    if let dataModel = self.parseData(parseWith : saveData){
                        DispatchQueue.main.async {
                            self.price = String(format: "%.2f", dataModel.price) // Update price on the main thread
                        }
                    }
                }
            }
            task.resume()
        }
    }
    func parseData(parseWith data : Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try (decoder.decode(CoinData.self, from: data))
            let Btcprice = decodedData.rate
            let dataModel = CoinModel(price: Btcprice)
            return dataModel
        }
        catch{
            print(error)
            return nil
        }
    }
}
