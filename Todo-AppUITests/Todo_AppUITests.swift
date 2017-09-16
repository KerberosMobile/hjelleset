//
//  Todo_AppUITests.swift
//  Todo-AppUITests
//
//  Created by kerberos-mac on 9/15/17.
//  Copyright © 2017 kerberos-mac. All rights reserved.
//

import XCTest

class Todo_AppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainViewController() {
        let app = XCUIApplication()
        
        let tableview = app.tables.matching(identifier: "mainVCTableview")
        let cell = tableview.cells.element(matching: .cell, identifier: "mainVCTableviewCell")//MainTableCell
        cell.tap()
        let labelCellTitle = cell.staticTexts["mainVCCellTitleLabel"]
        XCTAssertFalse(labelCellTitle.exists)
        let labelCellDate = cell.staticTexts["mainVCCellDateLabel"]
        XCTAssertFalse(labelCellDate.exists)
        
        let btnDelete = cell.buttons["mainVCCellDeleteButton"]
        btnDelete.tap()
        
        let btnSearch = app.buttons["mainVCSearchButton"]
        btnSearch.tap()
        
        let btnBack = app.buttons["mainVCBackButton"]
        btnBack.tap()
        
        let btnSearchDone = app.buttons["mainVCSearchDoneButton"]
        btnSearchDone.tap()
        
        let btnAdd = app.buttons["mainVCAddButton"]
        btnAdd.tap()
        
    }
    
    func testAddViewController() {
        let app = XCUIApplication()
        
        let labelTitle = app.staticTexts["AddVCTitleLabel"]
        XCTAssertFalse(labelTitle.exists)
        let btnBack = app.buttons["AddVCBackButton"]
        btnBack.tap()
        let btnSave = app.buttons["AddVCSaveButton"]
        btnSave.tap()
        let textField = app.textFields["AddVCInputTextField"]
        textField.tap()
    }
    
}


