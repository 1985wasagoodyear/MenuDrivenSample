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

class SubtitleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class SimpleTableViewController: UIViewController {
    
    private enum Constants {
        static let cellID = "CellID"
    }
    
    public lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.fillIn(self.view)
        table.estimatedRowHeight = 100.0
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView()
        table.register(SubtitleTableViewCell.self,
                       forCellReuseIdentifier: Constants.cellID)
        return table
    }()
    
    public let viewModel: SimpleTableViewModelProtocol
    
    public init(viewModel: SimpleTableViewModelProtocol) {
        self.viewModel = viewModel
        
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
    
    deinit {
        viewModel.unbind()
    }

}

extension SimpleTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionCount
    }
    
    open func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount(in: section)
    }
    
    open func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            let cellId = Constants.cellID
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
                let subtitleCell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
                return subtitleCell
            }
            return cell
        }()
        cell.textLabel?.text = viewModel.title(for: indexPath)
        cell.detailTextLabel?.text = viewModel.subtitle(for: indexPath)
        viewModel.image(for: indexPath) { data in
            let image: UIImage?
            defer {
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                }
            }
            guard let data = data else {
                image = nil
                return
            }
            image = UIImage(data: data)
        }
        return cell
    }

}
