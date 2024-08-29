//
//  ExchangeViewModel.swift
//  ExchangeList
//
//  Created by Fabricio Padua on 8/27/24.
//

import Foundation

class ExchangeListViewModel {
    
    var exchanges: [Exchange] = []
    
    func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void) {
        NetworkService.shared.fetchExchangesAndIcons { [weak self] exchanges in
            self?.exchanges = exchanges
            completion(.success(exchanges))
        }
    }
    
    func numberOfExchanges() -> Int {
        return exchanges.count
    }
    
    func exchange(at index: Int) -> Exchange {
        return exchanges[index]
    }
}
