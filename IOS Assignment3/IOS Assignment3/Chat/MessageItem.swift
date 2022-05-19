//
//  MessageItem.swift
//  IOS Assignment3
//
//  Created by Xueyan Yang on 2022/5/15.
//

import UIKit

//Message type, mine or someone else's
enum ChatType {
    case mine
    case someone
}

class MessageItem {
    // The user information
    var userInfo: UserInfo
    
    // Message type
    var chatType: ChatType
    
    // The message of time
    var date:Date
    
    // Content view, tag or image
    var view: UIView
    
    // padding
    var insets: UIEdgeInsets
    
    // Gets my text message content margin
    class func getTextInsetsMine() -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 9, left: 10, bottom: 9, right: 17)
    }
    
    // Gets the margin of someone else's text message content
    class func getTextInsetsSomeOne() -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 9, left: 15, bottom: 9, right: 10)
    }
    
    // Gets my picture message content margin
    class func getImageInsetsMine() -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 9, left: 10, bottom: 9, right: 17)
    }
    
    // Gets the margins of other people's picture message content
    class func getImageInsetsSomeOne() -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 9, left: 15, bottom: 9, right: 10)
    }
    
    init(userInfo: UserInfo, date: Date, mtype: ChatType, view: UIView, insets: UIEdgeInsets) {
        self.userInfo = userInfo
        self.date = date
        self.chatType = mtype
        self.view = view
        self.insets = insets
    }
    
    // Constructing text information
    convenience init(body: String, userInfo: UserInfo, date: Date, mtype: ChatType)
    {
        let font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        let width = 225, height = 1000.0
        let atts =  [NSAttributedString.Key.font: font]
        let size = body.boundingRect(with:
            CGSize(width: CGFloat(width), height: CGFloat(height)),
            options: .usesLineFragmentOrigin, attributes:atts, context:nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.numberOfLines = 0;
        label.font = font
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = body.count > 0 ? body : ""
        label.backgroundColor = UIColor.clear
        
        let insets = (mtype == .mine) ? MessageItem.getTextInsetsMine() : MessageItem.getTextInsetsSomeOne()
        
        self.init(userInfo: userInfo, date: date, mtype: mtype, view: label, insets: insets)
        
    }
    
    // Constructing picture messages
    convenience init(image: UIImage, userInfo: UserInfo, date:Date, mtype: ChatType)
    {
        var size = image.size
        
        if size.width > 200 {
            size.height /= size.width / 200
            size.width = 200
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        imageView.image = image
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        
        let insets = (mtype == .mine) ? MessageItem.getImageInsetsMine() : MessageItem.getImageInsetsSomeOne()

        self.init(userInfo: userInfo, date: date, mtype: mtype, view: imageView, insets: insets)
    }
}
