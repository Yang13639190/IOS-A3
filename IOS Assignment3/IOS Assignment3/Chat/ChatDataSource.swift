//
//  ChatDataSource.swift
//  IOS Assignment3
//
//  Created by Xueyan Yang on 2022/5/15.
//

import Foundation

protocol ChatDataSource {
    /*Returns the total number of lines in the conversation record*/
    func rowsForChatTable( _ tableView:TableView) -> Int
    /*Returns the contents of a row*/
    func chatTableView(_ tableView:TableView, dataForRow:Int)-> MessageItem
}
