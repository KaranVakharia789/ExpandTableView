//
//  ViewController.swift
//  ExpandTableView
//
//  Created by Karan Vakharia on 18/08/21.
//

import UIKit
struct Section {
    let title: String
    let option: [String]
    var isOpened: Bool = false
    
    init(title: String, option: [String], isOpened: Bool) {
        self.title = title
        self.option = option
        self.isOpened = isOpened
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!

    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        sections = [Section(title: "Section 1", option: [1,2,3].compactMap({return "Cell \($0)"}), isOpened: false),
                   Section(title: "Section 2", option: [1,2,3].compactMap({return "Cell \($0)"}), isOpened: false),
                   Section(title: "Section 3", option: [1,2,3].compactMap({return "Cell \($0)"}), isOpened: false)]
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        if section.isOpened {
            return section.option.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

        if indexPath.row == 0 {
            cell.textLabel?.text = sections[indexPath.section].title
        } else {
            cell.textLabel?.text = sections[indexPath.section].option[indexPath.row - 1]
        }
        
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            print("Sub cell")
        }
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
}
