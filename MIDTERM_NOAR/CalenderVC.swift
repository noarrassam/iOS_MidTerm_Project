//
//  CalenderViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-08.
//

import UIKit

class CalenderVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource ,AddEventDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var tasks: [Task] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Date()
        return "\(date)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarTableViewCell
        
        let dateFormt = DateFormatter()
        dateFormt.dateFormat = "yyyy, mm, dd 'at' hh:mm:ss"
       
        cell.name.text = tasks[indexPath.row].events.name
        cell.note.text = tasks[indexPath.row].events.note
        cell.details?.text = dateFormt.string(from: tasks[indexPath.row].events.detail!)
        
        return cell
    }
    
    func onAddEvent(event: Event) {
        tasks.append(Task(eventName: event))
        table.reloadData()
        
        setMonthView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details"{
            let adeventVC = segue.destination as! AddEventCalViewController

            adeventVC.delegate = self
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    @IBOutlet weak var monthLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
        self.table.rowHeight = 130
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView()
    {
        totalSquares.removeAll()
        
        let daysInMonth = CalenderHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalenderHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalenderHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        while (count <= 42 )
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append("")
            }else{
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        monthLabel.text = CalenderHelper().monthString(date: selectedDate) + " " + CalenderHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalenderCell
            
        for task in tasks {
            if totalSquares[indexPath.item] == CalenderHelper().dayString(date: task.events.detail!) && (monthLabel.text == (CalenderHelper().monthString(date: task.events.detail!) + " " + CalenderHelper().yearString(date: task.events.detail!))) {
                cell.contentView.layer.cornerRadius =  cell.contentView.bounds.height / 2
                cell.contentView.layer.borderWidth = 1.0
                cell.contentView.layer.borderColor = UIColor.red.cgColor
                break
            } else {
                cell.contentView.layer.borderWidth = 0.0
            }
        }
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        return cell
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalenderHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalenderHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}

class Task {
    var events = Event()
    
    convenience init(eventName: Event) {
        self.init()
        self.events = eventName
    }
}
