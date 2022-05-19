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
    
    // Chat data
    var bubbleSection: NSMutableArray!
    // The data source，with viewController Interactive data
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
                // Create a date formatter
                let dformatter = DateFormatter()
                // Sets the format string for the date formatter
                dformatter.dateFormat = "dd"
                
                for i in 0 ..< count
                {
                    let data =  bubbleData[i] as! MessageItem
                    // Use date formatter to format dates, different dates on new groups
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
        
        //Slide to the last section
        let secno = self.bubbleSection.count - 1
        let indexPath =  IndexPath(row:(self.bubbleSection[secno] as AnyObject).count,section:secno)
        
        self.scrollToRow(at: indexPath,                at:UITableView.ScrollPosition.bottom,animated:true)
    }
    
    //Sort by date
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

//MARK: Data source & proxy method
extension TableView {
    
    //Used to determine the height of a cell. If this method is not implemented correctly, cells will be displaced from one another
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
