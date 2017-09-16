//
//  Todo_AppTests.swift
//  Todo-AppTests
//
//  Created by kerberos-mac on 9/15/17.
//  Copyright © 2017 kerberos-mac. All rights reserved.
//
import UIKit
import XCTest
@testable import Todo_App

class Todo_AppTests: XCTestCase {
//    var calc: TipCalculator!
    var mainVc: MainVC!
    var addVC: AddVC!
    override func setUp() {
        super.setUp()
        mainVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
        addVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddVC") as! AddVC
    }
    
    override func tearDown() {
        print("Finished Unit test.")
        mainVc = nil
        addVC = nil
        super.tearDown()
    }
    
    func testRealmTodos() {
        XCTAssertEqual(AppInfo.shared.realm.objects(TodoModel.self).count, 0, "Realm Todos count")
        XCTAssertEqual(mainVc.todoDatas.count, 0, "showed Todos count")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
