//
//  ExchangeModel.swift
//  ExchangeList
//
//  Created by Fabricio Padua on 8/27/24.
//

import Foundation

struct Exchange: Codable {
    let exchange_id: String?
    let name: String?
    let volume_1hrs_usd: Double?
    let volume_1day_usd: Double?
    let volume_1mth_usd: Double?
    var icon_url: String?
}

struct ExchangeIcon: Decodable {
    let exchange_id: String
    let url: String
}
