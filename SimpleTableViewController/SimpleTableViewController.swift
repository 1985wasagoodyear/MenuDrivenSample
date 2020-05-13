//
//  SimpleTableViewController.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import UIKit
import CommonUtils

private enum Constants {
    static let cellID = "CellID"
}

open class SimpleTableViewController: UIViewController {
    
    public lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.fillIn(self.view)
        table.tableFooterView = UIView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: Constants.cellID)
        return table
    }()
    
    public let viewModel: SimpleTableViewModelProtocol
    weak open var delegate: SimpleTableDelegate?
    
    public init(viewModel: SimpleTableViewModelProtocol,
                delegate: SimpleTableDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        
        viewModel.bindAndFire {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("initWithCoder: not implemented. Please use initWithViewModel:")
    }
}
extension SimpleTableViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionCount
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount(in: section)
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath)
        cell.textLabel?.text = viewModel.title(for: indexPath)
        return cell
    }

}

extension SimpleTableViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(at: indexPath)
    }
    
}
