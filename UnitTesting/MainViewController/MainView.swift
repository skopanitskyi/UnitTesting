//
//  MainView.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import UIKit

class MainView: UIView {
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelfView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSelfView()
    }
    
    private func setupSelfView() {
        setupSelf()
        registerCells()
        setupTableView()
    }
    
    private func setupSelf() {
        backgroundColor = .white
    }
    
    private func registerCells() {
        tableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.identifier)
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
