//
//  ChatDataSource.swift
//  IOS Assignment3
//
//  Created by Xueyan Yang on 2022/5/15.
//

import Foundation

protocol ChatDataSource {
    /*返回对话记录中的全部行数*/
    func rowsForChatTable( _ tableView:TableView) -> Int
    /*返回某一行的内容*/
    func chatTableView(_ tableView:TableView, dataForRow:Int)-> MessageItem
}
