//
//  ExchangeCell.swift
//  ExchangeList
//
//  Created by Fabricio Padua on 8/28/24.
//

import Foundation
import UIKit

class ExchangeCell: UITableViewCell {
    
    var formater = format()
    
    let img_icon: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let name_exchange: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let volume_1day_usd: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews() {
        addSubview(img_icon)
        addSubview(name_exchange)
        addSubview(volume_1day_usd)
        
        img_icon.translatesAutoresizingMaskIntoConstraints = false
        name_exchange.translatesAutoresizingMaskIntoConstraints = false
        volume_1day_usd.translatesAutoresizingMaskIntoConstraints = false
        
        // Definir constraints
        NSLayoutConstraint.activate([
            img_icon.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            img_icon.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            img_icon.heightAnchor.constraint(equalToConstant: 20),
            img_icon.widthAnchor.constraint(equalToConstant: 20),
            
            name_exchange.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            name_exchange.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            name_exchange.leftAnchor.constraint(equalTo: img_icon.rightAnchor, constant: 8),
            
            volume_1day_usd.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            volume_1day_usd.rightAnchor.constraint(equalTo: rightAnchor, constant:  -15),
            volume_1day_usd.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    func configure(with exchange: Exchange) {
        //        exchange_id.text = exchange.exchange_id
        name_exchange.text = exchange.name
        
        if let url = URL(string: exchange.icon_url ?? "") {
            img_icon.loadImage(from: url, placeholder: UIImage(named: "placeholder"))
        }
        
        guard let volume1Day = exchange.volume_1day_usd else {
            volume_1day_usd.text = "USD N/A"
            return
        }
    
        let formattedVolume = formater.formatNumberSort(volume1Day)
        volume_1day_usd.text = "$ \(formattedVolume)"
    }
}

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        // Defina uma imagem de placeholder, se houver
        self.image = placeholder
        
        // Armazene a URL associada para evitar a troca de imagens
        let urlString = url.absoluteString
        let currentTag = self.tag
        self.tag = urlString.hash
        
        // Crie a sessão de URL para buscar a imagem
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Verifique se há dados e se não houve erro
            guard let data = data, error == nil else {
                print("Failed to load image: \(error?.localizedDescription ?? "No error description")")
                return
            }
            
            // Converta os dados recebidos em uma UIImage
            if let downloadedImage = UIImage(data: data) {
                // Verifique se a URL ainda é a correta
                DispatchQueue.main.async {
                    if self?.tag == urlString.hash {
                        self?.image = downloadedImage
                    }
                }
            }
        }.resume() // Inicie a tarefa de download
    }
}
