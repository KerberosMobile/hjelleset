//
//  MainVC.swift
//  Todo-App
//
//  Created by kerberos-mac on 9/16/17.
//  Copyright © 2017 kerberos-mac. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    var appInfo = AppInfo.shared
    var todoDatas = [TodoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchbar.returnKeyType = .done
        
        // for UI test
//        tableview.accessibilityIdentifier = "mainVCTableview"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if appInfo.isCreate {
            initialSearchBar()
        }
        
        chooseTodos()
    }
    
    func initialSearchBar() {
        searchbar.text = ""
        viewTitle.isHidden = false
        viewSearch.isHidden = true
        searchbar.resignFirstResponder()
    }
    
    func chooseTodos() {
        todoDatas = []
        let allTodos = appInfo.realm.objects(TodoModel.self)
        
        for data in allTodos {
            if searchbar.text!.characters.count > 0 {
                let stringTitle = data.title.lowercased() as NSString
                if stringTitle.range(of: searchbar.text!.lowercased()).location != NSNotFound {
                    todoDatas.append(data)
                }
            } else {
                todoDatas.append(data)
            }
        }
        
        sortTodos()
        tableview.reloadData()
    }
    
    func sortTodos() {
        todoDatas = todoDatas.sorted(by: {
            $0.title < $1.title
        })
    }
    
    
    @IBAction func OnPressSearch(_ sender: UIButton) {
        viewTitle.isHidden = true
        viewSearch.isHidden = false
        
        searchbar.becomeFirstResponder()
    }
    
    
    @IBAction func OnPressAdd(_ sender: UIButton) {
        appInfo.isCreate = true
        
        let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddVC") as? AddVC
        self.navigationController?.pushViewController(addVC!, animated: true)
    }
    
    @IBAction func OnPressBack(_ sender: UIButton) {
        initialSearchBar()
        chooseTodos()
    }
    
    @IBAction func OnPressSearchDone(_ sender: UIButton) {
        searchbar.resignFirstResponder()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell") as? MainTableCell
        cell?.setProperties(todoData: todoDatas[indexPath.row])
        cell?.delegate = self
        
        // for UI test
//        cell?.isAccessibilityElement = true
//        cell?.accessibilityIdentifier = "mainVCTableviewCell"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        searchbar.resignFirstResponder()
        
        appInfo.isCreate = false
        let dbId = todoDatas[indexPath.row].dbId
        if let obj = appInfo.realm.objects(TodoModel.self).filter("dbId = %@", dbId!).first {
            appInfo.selecetedObj = obj
            let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddVC") as? AddVC
            self.navigationController?.pushViewController(addVC!, animated: true)
        }
    }
}

extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        chooseTodos()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
    }
}

extension MainVC: DeleteCellDelegate {
    func deleteCell(dbIndex: String) {
        if let obj = appInfo.realm.objects(TodoModel.self).filter("dbId = %@", dbIndex).first {
            try! appInfo.realm.write {
               appInfo.realm.delete(obj)
            }

            chooseTodos()
        }
    }
}

