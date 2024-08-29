//
//  ListAllExchangeService.swift
//  MyCoins
//
//  Created by Fabricio Padua on 8/27/24.
//

import Foundation

class NetworkService {
    static let apiKey = "46440F20-6A7A-4618-B8D8-B641D3CDC92C"
    static let shared = NetworkService()

    private let session: URLSession

    // Dependency Injection for URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchExchangesAndIcons(completion: @escaping ([Exchange]) -> Void) {
        let exchangesURL = URL(string: "https://rest.coinapi.io/v1/exchanges")!
        let iconsURL = URL(string: "https://rest.coinapi.io/v1/exchanges/icons/32")!
        var exchanges: [Exchange] = []
        var icons: [ExchangeIcon] = []
        
        let dispatchGroup = DispatchGroup()
        
        // Fetch exchanges
        dispatchGroup.enter()
        var requestExchanges = URLRequest(url: exchangesURL)
        requestExchanges.addValue(NetworkService.apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
        session.dataTask(with: requestExchanges) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to fetch exchanges: \(error?.localizedDescription ?? "No error description")")
                dispatchGroup.leave()
                return
            }
            
            do {
                exchanges = try JSONDecoder().decode([Exchange].self, from: data)
            } catch {
                print("Failed to decode exchanges: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }.resume()
        
        // Fetch icons
        dispatchGroup.enter()
        var requestIcon = URLRequest(url: iconsURL)
        requestIcon.addValue(NetworkService.apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
        session.dataTask(with: requestIcon) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to fetch icons: \(error?.localizedDescription ?? "No error description")")
                dispatchGroup.leave()
                return
            }
            
            do {
                icons = try JSONDecoder().decode([ExchangeIcon].self, from: data)
            } catch {
                print("Failed to decode icons: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }.resume()
        
        // Combine data
        dispatchGroup.notify(queue: .main) {
            for i in 0..<exchanges.count {
                if let matchingIcon = icons.first(where: { $0.exchange_id == exchanges[i].exchange_id }) {
                    exchanges[i].icon_url = matchingIcon.url
                }
            }
            completion(exchanges)
        }
    }
}
