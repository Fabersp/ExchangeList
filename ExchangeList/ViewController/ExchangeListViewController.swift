//
//  TableViewController.swift
//  ExchangeList
//
//  Created by Fabricio Padua on 8/27/24.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class ExchangeListViewController: UITableViewController {
    
    private var viewModel: ExchangeListViewModel!
    weak var coordinator: MainCoordinator?
    
    private var exchangeListView: ExchangeListView! {
        return self.view as? ExchangeListView
    }
    
    var exchanges: [Exchange] = []
    
    override func loadView() {
        self.view = ExchangeListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exchangeListView.tableView.register(ExchangeCell.self, forCellReuseIdentifier: "cell")
        exchangeListView.tableView.delegate = self
        exchangeListView.tableView.dataSource = self
        
        title = "CoinAPI Exchanges"
        
        viewModel = ExchangeListViewModel()
        loadData()
    }
    
    func loadData() {
        viewModel.fetchExchanges { [weak self] result in
            switch result {
            case .success(let exchanges):
                print(exchanges)
                DispatchQueue.main.async {
                    self?.exchangeListView?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching exchanges:", error)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfExchanges()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExchangeCell
        
        let exchange = viewModel.exchange(at: indexPath.row)
        cell.configure(with: exchange)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExchange = viewModel.exchange(at: indexPath.row)
        coordinator?.showDetail(for: selectedExchange)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let nameLabel = UILabel()
        nameLabel.text = "Exchange"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nameLabel.textColor = .black
        
        let periodLabel = UILabel()
        periodLabel.text = "24h (USD)"
        periodLabel.font = UIFont.boldSystemFont(ofSize: 12)
        periodLabel.textColor = .black
        
        headerView.addSubview(nameLabel)
        headerView.addSubview(periodLabel)
        
        // Desativando o auto layout
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurando as constraints
        NSLayoutConstraint.activate([
            // Constraints para o nameLabel
            nameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 35),
            nameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // Constraints para o periodLabel
            periodLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            periodLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0 // Defina a altura conforme necessário
    }
}
