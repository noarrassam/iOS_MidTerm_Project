//
//  CalenderViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-06.
//
import UserNotifications
import UIKit

class CalenderViewController: UIViewController {

    @IBOutlet var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    public var models = [MyReminder]()
    public var tableList = [MyReminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
        searchBar.autocapitalizationType = .none
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        table.reloadData()
    }
    
    @IBAction func didTappedAdd() {
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        
        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                let new = MyReminder(title: title, date: date, identifier: "id_\(body)")
                self.models.append(new)
                self.tableList.append(new)
                self.table.reloadData()

                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body

                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)

                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTappedTest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
        if success {
            self.scheduleTest()
        }else if error != nil {
            print("error occurred")
        }
        })
    }
    
    func scheduleTest(){
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.sound = .default
        content.body = "My long body. My long body"
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("something went wrong")
            }
        })
    }
}

extension CalenderViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = tableList[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? ToDoListCellViewController else {
            return
        }
    
        vc.reminder = item

        navigationController?.pushViewController(vc, animated: true)
    
    }
}

extension CalenderViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if(searchText.isEmpty){
            // show whole list
            tableList.removeAll()
            tableList+=models
        }else{

            tableList = models.filter{$0.title.starts(with: searchText)}
           // print(tableList)
        }
        self.table.reloadData()
    }
}


extension CalenderViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            tableList.remove(at: indexPath.row)
            table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableList[indexPath.row].title
        let dateFormt = DateFormatter()
        dateFormt.dateFormat = "yyyy, mm, dd 'at' hh:mm:ss"
        cell.detailTextLabel?.text = dateFormt.string(from: tableList[indexPath.row].date)
        return cell
    }
}

struct MyReminder {
    let title: String
    let date: Date
    let identifier: String
}
