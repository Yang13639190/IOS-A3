//
//  TableView.swift
//  IOS Assignment3
//
//  Created by Xueyan Yang on 2022/5/15.
//

import UIKit

enum ChatBubbleTypingType {
    case nobody
    case me
    case somebody
}

class TableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // 聊天数据
    var bubbleSection: NSMutableArray!
    // 数据源，与viewController交互数据
    var chatDataSource: ChatDataSource!
    
    var snapInterval: TimeInterval!
    var bubbleTypingType: ChatBubbleTypingType!
    
    

    override init(frame: CGRect, style: UITableView.Style) {
        self.snapInterval = TimeInterval(60 * 60 * 24)
        self.bubbleTypingType = ChatBubbleTypingType.nobody
        self.bubbleSection = NSMutableArray()
        
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor.clear
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.delegate = self
        self.dataSource = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData()
    {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bubbleSection = NSMutableArray()
        var count =  0
        if ((self.chatDataSource != nil))
        {
            count = self.chatDataSource.rowsForChatTable(self)
            
            if(count > 0)
            {
                let bubbleData =  NSMutableArray(capacity:count)
                
                for i in 0 ..< count
                {
                    let object =  self.chatDataSource.chatTableView(self, dataForRow:i)
                    bubbleData.add(object)
                }
                bubbleData.sort(comparator: sortDate)
                
                var last =  ""
                
                var currentSection = NSMutableArray()
                // 创建一个日期格式器
                let dformatter = DateFormatter()
                // 为日期格式器设置格式字符串
                dformatter.dateFormat = "dd"
                
                for i in 0 ..< count
                {
                    let data =  bubbleData[i] as! MessageItem
                    // 使用日期格式器格式化日期，日期不同，就新分组
                    let datestr = dformatter.string(from: data.date as Date)
                    if (datestr != last)
                    {
                        currentSection = NSMutableArray()
                        self.bubbleSection.add(currentSection)
                    }
                    (self.bubbleSection[self.bubbleSection.count-1] as AnyObject).add(data)
                    
                    last = datestr
                }
            }
        }
        super.reloadData()
        
        //滑向最后一部分
        let secno = self.bubbleSection.count - 1
        let indexPath =  IndexPath(row:(self.bubbleSection[secno] as AnyObject).count,section:secno)
        
        self.scrollToRow(at: indexPath,                at:UITableView.ScrollPosition.bottom,animated:true)
    }
    
    //按日期排序方法
    func sortDate(_ m1: Any, m2: Any) -> ComparisonResult {
        if((m1 as! MessageItem).date.timeIntervalSince1970 < (m2 as! MessageItem).date.timeIntervalSince1970)
        {
            return ComparisonResult.orderedAscending
        }
        else
        {
            return ComparisonResult.orderedDescending
        }
    }
    
    
}

//MARK:数据源 & 代理方法
extension TableView {
    
    //用于确定单元格的高度，如果此方法实现得不对，单元格与单元格之间会错位
    func tableView(_ tableView:UITableView,heightForRowAt indexPath:IndexPath)
        -> CGFloat {
        // Header
        if (indexPath.row == 0)
        {
            return TableHeaderViewCell.getHeight()
        }
        let section  =  self.bubbleSection[indexPath.section] as! NSMutableArray
        let data = section[indexPath.row - 1]
        
        let item =  data as! MessageItem
        let height  =  max(item.insets.top + item.view.frame.size.height  + item.insets.bottom, 52) + 17
        print("height:\(height)")
        return height
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = self.bubbleSection.count
        if self.bubbleTypingType != .nobody {
            count += 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section >= self.bubbleSection.count)
        {
            return 1
        }
        
        return (self.bubbleSection[section] as AnyObject).count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellIdentifier = "headerCell"
            let cell = TableHeaderViewCell(reuseIdentifier: cellIdentifier)
            let section = self.bubbleSection[indexPath.section] as! NSMutableArray
            let data = section[indexPath.row ] as! MessageItem
            cell.setDate(data.date)
            return cell
        }
        let cellIdentifier = "ChatCell"
        let section = self.bubbleSection[indexPath.section] as! NSMutableArray
        let data = section[indexPath.row - 1] as! MessageItem
        let cell = TableViewCell(data: data, reuseIdentifier: cellIdentifier)
        return cell
    }
}
