//
//  TableViewCell.swift
//  IOS Assignment3
//
//  Created by Xueyan Yang on 2022/5/15.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //消息内容视图
    var customView:UIView!
    //消息背景
    var bubbleImage:UIImageView!
    //头像
    var avatarImage:UIImageView!
    //消息数据结构
    var msgItem:MessageItem!
    

    init(data: MessageItem, reuseIdentifier: String)
    {
        self.msgItem = data
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        rebuildUserInterface()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func rebuildUserInterface()
    {
        self.selectionStyle = .none
        if self.bubbleImage == nil {
            self.bubbleImage = UIImageView()
            self.addSubview(self.bubbleImage)
        }
        
        let type = msgItem.chatType
        let width = msgItem.view.frame.size.width
        let height = msgItem.view.frame.size.height
        
        var x = (type == .someone) ? 0 : self.frame.size.width - msgItem.insets.left - msgItem.insets.right - width
        var y: CGFloat = 0
        
        if (msgItem.userInfo.username != "")
        {
            let user = msgItem.userInfo
            
            let imageName = user.avatar == "" ? "noAvatar.png" : user.avatar
            self.avatarImage = UIImageView(image: UIImage(named: imageName))
            
            self.avatarImage.layer.cornerRadius = 10
            self.avatarImage.layer.masksToBounds = true
            self.avatarImage.layer.borderColor = UIColor(white: 0.0, alpha: 0.2).cgColor
            self.avatarImage.layer.borderWidth = 1.0
            
            //计算x:别人头像，在左边，我的头像在右边
            let avatarX: CGFloat = (type == .someone) ? 2 : self.frame.size.width - 52;
            //头像居于消息顶部
            let avatarY: CGFloat = 0.0;
            self.avatarImage.frame = CGRect(x: avatarX, y: avatarY, width: 50, height: 50)
            self.addSubview(self.avatarImage)
            
             //如果只有一行消息（消息框高度不大于头像）则将消息框居中于头像位置
            let delta = (50 - (self.msgItem.insets.top + self.msgItem.insets.bottom + self.msgItem.view.frame.size.height)) / 2
            if delta > 0 {
                y = delta
            }
            
            if (type == .someone)
            {
                x += 54
            } else {
                x -= 54
            }
            
            self.customView = msgItem.view
            self.customView.frame = CGRect(x: x + msgItem.insets.left, y: y + msgItem.insets.top, width: width, height: height)
            self.addSubview(self.customView)
            
            //如果是别人的消息，在左边，如果是我输入的消息，在右边
            if type == .mine {
                self.bubbleImage.image = UIImage(named:"mebubble.png")!
                .stretchableImage(withLeftCapWidth: 15, topCapHeight:25)
            } else {
                self.bubbleImage.image = UIImage(named:("yoububble.png"))!
                .stretchableImage(withLeftCapWidth: 21,topCapHeight:25)
            }
            
            self.bubbleImage.frame = CGRect(x: x, y: y, width: width + msgItem.insets.left + msgItem.insets.right, height: height + msgItem.insets.top + msgItem.insets.bottom)
            
        }
    }
    
    // 让单元格宽度始终为屏幕宽
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.size.width = UIScreen.main.bounds.size.width
            super.frame = frame
        }
    }
    
}
