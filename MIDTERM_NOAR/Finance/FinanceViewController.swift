//
//  FinanceViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-06.
//

import UIKit

class FinanceViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private lazy var moneyTrackerViewController: MoneyTrackerViewController = {
        let viewController = MoneyTrackerViewController.loadFromNib()

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var statisticsViewController: StatisticsViewController = {
        
        let viewController = StatisticsViewController.loadFromNib()

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    @IBAction func segmentedControlValueDidChange(_ sender: Any) {
        switchController(to: segmentedControl.selectedSegmentIndex)
    }
}

extension FinanceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchController(to: 0)
    }
}

extension FinanceViewController {
    private func switchController(to index: Int) {
        if index == 0 {
            remove(asChildViewController: statisticsViewController)
            add(asChildViewController: moneyTrackerViewController)
        } else {
            remove(asChildViewController: moneyTrackerViewController)
            add(asChildViewController: statisticsViewController)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        containerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }
}
