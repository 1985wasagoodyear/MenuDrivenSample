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

class MainMenuViewController: UIViewController {

    @IBOutlet var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func menuButtonAction(_ sender: Any) {
        let optionsVM = APIOptionsViewModel()
        let popoverContent = SimpleTableViewController(viewModel: optionsVM,
                                                delegate: self)
        popoverContent.modalPresentationStyle = .popover
        
        if let popover = popoverContent.popoverPresentationController {
            
            let viewForSource = sender as? UIView
            popover.sourceView = viewForSource
            
            // the position of the popover where it's showed
            popover.sourceRect = viewForSource?.bounds ?? .zero
            
            // the size you want to display
            popoverContent.preferredContentSize = CGSize(width: 200,
                                                         height: 500)
            popover.delegate = self
        }
        
        self.present(popoverContent, animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
}

extension MainMenuViewController: SimpleTableDelegate {
    
    func didSelect(at indexPath: IndexPath) {
        print(indexPath)
    }
    
}

extension MainMenuViewController: UIPopoverPresentationControllerDelegate { }
