//
//  AddVC.swift
//  Todo-App
//
//  Created by kerberos-mac on 9/16/17.
//  Copyright © 2017 kerberos-mac. All rights reserved.
//

import UIKit

class AddVC: UIViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textInPut: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    
    var appInfo = AppInfo.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textInPut.returnKeyType = .done
//        textInPut.isAccessibilityElement = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if appInfo.isCreate {
            labelTitle.text = "Create"
            buttonSave.isUserInteractionEnabled = false
            buttonSave.setTitleColor(UIColor.gray, for: .normal)
        } else {
            labelTitle.text = "Edit"
            textInPut.text = appInfo.selecetedObj.title
            buttonSave.isUserInteractionEnabled = true
            buttonSave.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func createNewDataInRealm() {
        
    }
    
    @IBAction func OnPressBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }

    @IBAction func OnPressSave(_ sender: UIButton) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        if appInfo.isCreate {
            //add to db
            let model = TodoModel()
            model.dbId = stringDate
            model.title = textInPut.text!
            model.date = stringDate
            try! appInfo.realm.write {
                appInfo.realm.add(model)
            }
            
        } else {
            // change db
            try! appInfo.realm.write {
                appInfo.selecetedObj.title = textInPut.text!
                appInfo.selecetedObj.date = stringDate
            }
        }
        
        self.navigationController?.popViewController(animated: true);
    }
}

extension AddVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count == 0 {
            buttonSave.isUserInteractionEnabled = false
            buttonSave.setTitleColor(UIColor.gray, for: .normal)
        } else {
            buttonSave.isUserInteractionEnabled = true
            buttonSave.setTitleColor(UIColor.white, for: .normal)
        }
        
        return true
    }
}
