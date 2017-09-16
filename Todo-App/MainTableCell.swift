//
//  MainTableCell.swift
//  Todo-App
//
//  Created by kerberos-mac on 9/16/17.
//  Copyright © 2017 kerberos-mac. All rights reserved.
//

import UIKit
import RealmSwift

protocol DeleteCellDelegate {
    func deleteCell(dbIndex: String)
}

class MainTableCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    var delegate: DeleteCellDelegate?
    var dbIndex: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProperties(todoData: TodoModel) {
        labelTitle.text = todoData.title
        labelDate.text = todoData.date
        dbIndex = todoData.dbId
    }

    @IBAction func OnPressDelete(_ sender: UIButton) {
        delegate?.deleteCell(dbIndex: dbIndex!)
    }
}


class TodoModel: Object {
    @objc dynamic var dbId: String!
    @objc dynamic var title: String!
    @objc dynamic var date: String!
//    var index: Int!
}
