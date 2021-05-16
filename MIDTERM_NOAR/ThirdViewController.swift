//
//  ThirdViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-14.
//

import UIKit

class ThirdViewController: UIViewController {
    
    //var views: [UIView]!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //let nib = UINib(nibName: "MoneyTrackerViewController", bundle: nil)
        //table.register(nib, forCellReuseIdentifier: "cell")
    }
    
    private lazy var firstViewController: MoneyTrackerViewController = {
        let viewController = MoneyTrackerViewController.loadFromNib()

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var secondViewController: StatisticsViewController = {
        
        let viewController = StatisticsViewController.loadFromNib()

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {

           // Add Child View Controller
        addChild(viewController)

           // Add Child View as Subview
           viewContainer.addSubview(viewController.view)

           // Configure Child View
        viewController.view.frame = viewContainer.bounds
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

    private func updateView() {
        if segmentControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: secondViewController)
            add(asChildViewController: firstViewController)
        } else {
            remove(asChildViewController: firstViewController)
            add(asChildViewController: secondViewController)
        }
    }

    func setupView() {
        updateView()
    }

    @IBAction func didTapSegment(_ sender: UISegmentedControl) {
        updateView()
    }
}

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
