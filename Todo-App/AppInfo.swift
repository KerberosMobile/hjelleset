//
//  AppInfo.swift
//  Todo-App
//
//  Created by kerberos-mac on 9/16/17.
//  Copyright © 2017 kerberos-mac. All rights reserved.
//

import UIKit
import RealmSwift

class AppInfo: NSObject {
    static let shared = AppInfo()
    
    var realm: Realm!
    var selecetedObj: TodoModel!
    
//    var todoDatas = [TodoModel]()
    var isCreate = true
}
