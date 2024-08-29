//
//  ExchangeDetailViewController.swift
//  ExchangeList
//
//  Created by Fabricio Padua on 8/28/24.
//

import Foundation
import UIKit

class ExchangeDetailViewController: UIViewController {
    
    var exchange: Exchange?
    var formater = format()
    
    private var exchangeDetailView: ExchangeDetailView! {
        return self.view as? ExchangeDetailView
    }
       
    override func loadView() {
        self.view = ExchangeDetailView()
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
       
        if let exchange = exchange {
            let formattedVolume24 = formater.formatNumber(exchange.volume_1day_usd ?? 0)
            exchangeDetailView.volume_24h.text = "USD $ \(formattedVolume24)"
            
            let formattedVolume1h = formater.formatNumber(exchange.volume_1hrs_usd ?? 0)
            exchangeDetailView.volume_1h.text = "USD $ \(formattedVolume1h)"
            
            let formattedVolume30d = formater.formatNumber(exchange.volume_1mth_usd ?? 0)
            exchangeDetailView.volume_30d.text = "USD $ \(formattedVolume30d)"
        }
    }
    
    func setupNavigationBar() {
        guard let exchange = exchange else { return }
        
        self.navigationItem.titleView?.accessibilityIdentifier = "exchangeDetailNavigationBar"
        self.navigationItem.title = "Exchange Detail"
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = .black
        
        
        let img_icon = UIImageView()
        img_icon.contentMode = .scaleAspectFit
        img_icon.translatesAutoresizingMaskIntoConstraints = false
        img_icon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        img_icon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        if let iconURLString = exchange.icon_url, let iconURL = URL(string: iconURLString) {
            img_icon.loadImage(from: iconURL, placeholder: UIImage(named: "placeholder"))
        }
        
        let name_exchange = UILabel()
        name_exchange.text = exchange.name
        name_exchange.textColor = .black
        name_exchange.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        name_exchange.translatesAutoresizingMaskIntoConstraints = false
    
        let stackView = UIStackView(arrangedSubviews: [img_icon, name_exchange])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        let titleView = UIView()
        titleView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
        
        self.navigationItem.titleView = titleView
    }
}
