//
//  MessageItem.swift
//  IOS Assignment3
//
//  Created by Xueyan Yang on 2022/5/15.
//

import UIKit

//消息类型，我的还是别人的
enum ChatType {
    case mine
    case someone
}

class MessageItem {
    // 用户信息
    var userInfo: UserInfo
    
    // 消息类型
    var chatType: ChatType
    
    // 消息时间
    var date:Date
    
    // 内容视图，标签或者图片
    var view: UIView
    
    // 内边距
    var insets: UIEdgeInsets
    
    // 获取我的文本消息内容边距
    class func getTextInsetsMine() -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 9, left: 10, bottom: 9, right: 17)
    }
    
    // 获取他人文本消息内容边距
    class func getTextInsetsSomeOne() -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 9, left: 15, bottom: 9, right: 10)
    }
    
    // 获取我的图片消息内容边距
    class func getImageInsetsMine() -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 9, left: 10, bottom: 9, right: 17)
    }
    
    // 获取他人图片消息内容边距
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
    
    // 构造文本信息
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
    
    // 构造图片消息
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
