//
//  TableViewCell.swift
//  IOS Assignment3
//
//  Created by Xueyan Yang on 2022/5/15.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //Message content view
    var customView:UIView!
    //News background
    var bubbleImage:UIImageView!
    //Head portrait
    var avatarImage:UIImageView!
    //Message data structure
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
            
            //Calculate X: Other people's heads on the left, my head on the right
            let avatarX: CGFloat = (type == .someone) ? 2 : self.frame.size.width - 52;
            //The avatar sits at the top of the message
            let avatarY: CGFloat = 0.0;
            self.avatarImage.frame = CGRect(x: avatarX, y: avatarY, width: 50, height: 50)
            self.addSubview(self.avatarImage)
            
             //If there is only one line of messages (the height of the message box is no higher than the head), center the message box in the position of the head
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
            
            //On the left if it's someone else's message, on the right if it's me
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
    
    // Make the cell width always screen wide
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
