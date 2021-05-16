//
//  MoneyTrackerViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-14.
//

import UIKit

class MoneyTrackerViewController: UIViewController {
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var expenseCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var expensesTableView: UITableView!
    
    let expensesService = ExpensesService.shared
    var selectedCategoryIndex = 0 {
        didSet {
            reloadData()
        }
    }
    
    lazy var monthDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        return dateFormatter
    }()
    
    var date = Date().startOfMonth {
        didSet {
            reloadData()
        }
    }
    
    var filteredExpenseCategories: [ExpenseCategory] {
        expensesService.expenseCategories.map { originalCategory in
            ExpenseCategory(
                name: originalCategory.name,
                expenses: originalCategory.expenses.filter { expense in
                    Calendar.current.isDate(expense.date, equalTo: date, toGranularity: .month)
                }
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        reloadData()
    }
    
    @IBAction func touchUpInsidePlusButton(_ sender: Any) {
        
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewAmountViewController") as! NewAmountViewController
        viewController.delegate = self
        
        self.present(viewController, animated: true, completion: nil)
        // let vc = NewAmountViewController()
        // self.navigationController?.pushViewController(vc, animated: true)
        print("Hello")
    }
    
    @IBAction func touchUpInsidePreviousMonthButton(_ sender: Any) {
        date = date.startOfPreviousMonth
    }
    
    @IBAction func touchUpInsideNextMonthButton(_ sender: Any) {
        date = date.startOfNextMonth
    }
}

extension MoneyTrackerViewController {
    func setupUI() {
        expenseCategoriesCollectionView.collectionViewLayout = createCompositionalLayout()
        
        expenseCategoriesCollectionView.register(
            UINib(nibName: "ExpenseCategoryCell", bundle: nil),
            forCellWithReuseIdentifier: "ExpenseCategoryCell"
        )
        
        expensesTableView.register(
            UINib(nibName: "ExpenseCell", bundle: nil),
            forCellReuseIdentifier: "ExpenseCell"
        )
        
        reloadData()
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
      
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.93),
            heightDimension: .estimated(120)
        )
      
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfiguration.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(section: section, configuration: layoutConfiguration)
        
        return layout
    }
    
    func reloadData() {
        monthLabel.text = monthDateFormatter.string(from: date)
        expensesTableView.reloadData()
        
        expensesTableView.reloadData()
        expenseCategoriesCollectionView.reloadData()
    }
}

extension MoneyTrackerViewController: NewAmountViewControllerDelegate {
    func didAddExpense() {
        expenseCategoriesCollectionView.reloadData()
        expensesTableView.reloadData()
    }
}

extension MoneyTrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredExpenseCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let expenseType = filteredExpenseCategories[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpenseCategoryCell", for: indexPath) as! ExpenseCategoryCell
        
        cell.update(with: expenseType)
        
        return cell
    }
}

extension MoneyTrackerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.row
    }
}

extension MoneyTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredExpenseCategories[selectedCategoryIndex].expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = filteredExpenseCategories[selectedCategoryIndex].expenses[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell") as! ExpenseCell
        cell.update(with: expense)
        
        return cell
    }
}

extension MoneyTrackerViewController: UITableViewDelegate {
    
}
