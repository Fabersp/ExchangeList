//
//  ExchangeDetailView.swift
//  ExchangeList
//
//  Created by Fabricio Padua on 8/29/24.
//

import UIKit

class ExchangeDetailView: UIView {
    
    let text_Total_traiding = UILabel()
    let text_Total_24h = UILabel()
    let volume_24h = UILabel()
    let line1 = UIView()
    let text_Total_1h = UILabel()
    let volume_1h = UILabel()
    let line2 = UIView()
    let text_Total_30d = UILabel()
    let volume_30d = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Configure the views here like setting text, color, etc.
        text_Total_traiding.textColor = .black
        text_Total_traiding.text = "Total traiding"
        text_Total_traiding.font = UIFont.systemFont(ofSize: 15)
        text_Total_traiding.translatesAutoresizingMaskIntoConstraints = false
        
        text_Total_24h.textColor = .black
        text_Total_24h.text = "Volume (24h)"
        text_Total_24h.font = UIFont.systemFont(ofSize: 11)
        text_Total_24h.translatesAutoresizingMaskIntoConstraints = false
        
        volume_24h.textColor = .black
        volume_24h.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        volume_24h.translatesAutoresizingMaskIntoConstraints = false
        
        line1.backgroundColor = .gray
        line1.translatesAutoresizingMaskIntoConstraints = false
        
        text_Total_1h.textColor = .black
        text_Total_1h.text = "Volume (1h)"
        text_Total_1h.font = UIFont.systemFont(ofSize: 11)
        text_Total_1h.translatesAutoresizingMaskIntoConstraints = false
        
        volume_1h.textColor = .black
        volume_1h.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        volume_1h.translatesAutoresizingMaskIntoConstraints = false
        
        line2.backgroundColor = .gray
        line2.translatesAutoresizingMaskIntoConstraints = false
        
        text_Total_30d.textColor = .black
        text_Total_30d.text = "Volume (30 days)"
        text_Total_30d.font = UIFont.systemFont(ofSize: 10)
        text_Total_30d.translatesAutoresizingMaskIntoConstraints = false
        
        volume_30d.textColor = .black
        volume_30d.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        volume_30d.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(text_Total_traiding)
        addSubview(text_Total_24h)
        addSubview(volume_24h)
        addSubview(text_Total_1h)
        addSubview(volume_1h)
        addSubview(text_Total_30d)
        addSubview(volume_30d)
       
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            text_Total_traiding.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            text_Total_traiding.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            text_Total_traiding.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            
            text_Total_24h.topAnchor.constraint(equalTo: text_Total_traiding.bottomAnchor, constant: 10),
            text_Total_24h.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            text_Total_24h.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            
            volume_24h.topAnchor.constraint(equalTo: text_Total_24h.bottomAnchor, constant: 5),
            volume_24h.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            volume_24h.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            
            text_Total_1h.topAnchor.constraint(equalTo: volume_24h.bottomAnchor, constant: 20),
            text_Total_1h.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            text_Total_1h.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            
            volume_1h.topAnchor.constraint(equalTo: text_Total_1h.bottomAnchor, constant: 5),
            volume_1h.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            volume_1h.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            
            text_Total_30d.topAnchor.constraint(equalTo: volume_1h.bottomAnchor, constant: 20),
            text_Total_30d.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            text_Total_30d.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            
            volume_30d.topAnchor.constraint(equalTo: text_Total_30d.bottomAnchor, constant: 5),
            volume_30d.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            volume_30d.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14)
            
           
        ])
    }
}
