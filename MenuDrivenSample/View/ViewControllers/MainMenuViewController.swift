//
//  MainMenuViewController.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import UIKit
import SimpleTableViewController

class MainMenuViewController: SimpleTableViewController {

    lazy var menuButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .search,
                                     target: self,
                                     action: #selector(menuButtonAction(_:)))
    }()
    
    var popover: UIViewController?
    let menuViewModel: MainMenuViewModel
    
    init(viewModel: MainMenuViewModel,
         delegate: SimpleTableDelegate? = nil) {
        self.menuViewModel = viewModel
        super.init(viewModel: viewModel, delegate: delegate)
        tableView.backgroundView = UIView()
        navigationItem.setRightBarButton(menuButton, animated: false)
        menuViewModel.bind {
            DispatchQueue.main.async {
                self.title = self.menuViewModel.currentTitle
                self.tableView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        viewModel.unbind()
    }
    
    @objc func menuButtonAction(_ sender: UIBarButtonItem) {
        let optionsVM = APIOptionsViewModel()
        let popoverContent = SimpleTableViewController(viewModel: optionsVM,
                                                delegate: self)
        popoverContent.modalPresentationStyle = .popover
        
        if let popover = popoverContent.popoverPresentationController {
            
            popover.barButtonItem = sender
            let size = view.frame.size
            let width = size.width / 2.0
            let height = size.height / 2.0
            popoverContent.preferredContentSize = CGSize(width: width,
                                                         height: height)
            popover.delegate = self
            popover.permittedArrowDirections = .up
        }
        
        self.present(popoverContent, animated: true, completion: nil)
        popover = popoverContent
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
}

extension MainMenuViewController: SimpleTableDelegate {
    
    func didSelect(at indexPath: IndexPath) {
        guard let popover = popover else { return }
        popover.dismiss(animated: true) {
            self.menuViewModel.select(indexPath)
        }
    }
    
}

extension MainMenuViewController: UIPopoverPresentationControllerDelegate { }
