//
//  XYChatViewController.swift
//  IOS Assignment3
//
//  Created by Xueyan Yang on 2022/5/15.
//

import UIKit

class XYChatViewController: UIViewController, ChatDataSource,UITextFieldDelegate {
    
    var Chats:NSMutableArray!
    var tableView:TableView!
    var me:UserInfo!
    var you:UserInfo!
    var txtMsg:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupChatTable()
        setupSendPanel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK:Set input field
extension XYChatViewController
{
    func setupSendPanel()
    {
        let screenWidth = UIScreen.main.bounds.width
        let sendView = UIView(frame:CGRect(x: 0,y: self.view.frame.size.height - 56,width: screenWidth,height: 56))
        
        sendView.backgroundColor=UIColor.lightGray
        sendView.alpha=0.9
        
        txtMsg = UITextField(frame:CGRect(x: 7,y: 10,width: screenWidth - 95,height: 36))
        txtMsg.backgroundColor = UIColor.white
        txtMsg.textColor=UIColor.black
        txtMsg.font=UIFont.boldSystemFont(ofSize: 12)
        txtMsg.layer.cornerRadius = 10.0
        txtMsg.returnKeyType = UIReturnKeyType.send
        
        txtMsg.delegate=self
        sendView.addSubview(txtMsg)
        self.view.addSubview(sendView)
        
        let sendButton = UIButton(frame:CGRect(x: screenWidth - 80,y: 10,width: 72,height: 36))
        sendButton.backgroundColor=UIColor(red: 0x37/255, green: 0xba/255, blue: 0x46/255, alpha: 1)
        sendButton.addTarget(self, action:#selector(XYChatViewController.sendMessage) ,
                             for:UIControl.Event.touchUpInside)
        sendButton.layer.cornerRadius=6.0
        sendButton.setTitle("send", for:UIControl.State())
        sendView.addSubview(sendButton)
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        sendMessage()
        return true
    }
    
    @objc func sendMessage()
    {
        //composing=false
        let sender = txtMsg
        let thisChat =  MessageItem(body:(sender!.text! as NSString) as String, userInfo:me, date:Date(), mtype:ChatType.mine)
        let thatChat =  MessageItem(body:("It is as you say：\(sender!.text!)" as NSString) as String, userInfo:you, date:Date(), mtype:ChatType.someone)
        
        Chats.add(thisChat)
        Chats.add(thatChat)
        self.tableView.chatDataSource = self
        self.tableView.reloadData()
        
        //self.showTableView()
        sender?.resignFirstResponder()
        sender?.text = ""
    }
}

//MARK:Set up chat fake data and data source
extension XYChatViewController
{
    
     func setupChatTable()
     {
         self.tableView = TableView(frame:CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height - 76), style: .plain)
         
         //Create a cell for reuse
         self.tableView!.register(TableViewCell.self, forCellReuseIdentifier: "ChatCell")
         me = UserInfo(name:"Xiaoming" ,avatar:("xiaoming.png"))
         you  = UserInfo(name:"Xiaohua", avatar:("xiaohua.png"))
         
         let zero =  MessageItem(body:"Hello, are you also studying this course？", userInfo:you,  date:Date(timeIntervalSinceNow:-96400), mtype:.someone)
         
         let zero1 =  MessageItem(body:"Yeah, did you, too？", userInfo:me,  date:Date(timeIntervalSinceNow:-86400), mtype:.mine)
         
         let first =  MessageItem(body:"This is a beautiful picture！", userInfo:me,  date:Date(timeIntervalSinceNow:-70600), mtype:.mine)
         
         let second =  MessageItem(image:UIImage(named:"xiaohua.png")!,userInfo:me, date:Date(timeIntervalSinceNow:-60290), mtype:.mine)
         
         let third =  MessageItem(body:"Thank you. It was nice meeting you",userInfo:you, date:Date(timeIntervalSinceNow:-60060), mtype:.someone)
         
         let fouth =  MessageItem(body:"me，too",userInfo:me, date:Date(timeIntervalSinceNow:-60020), mtype:.mine)
         
         let fifth =  MessageItem(body:"We can all communicate with each other",userInfo:you, date:Date(timeIntervalSinceNow:0), mtype:.someone)
         

         Chats = NSMutableArray()
         Chats.addObjects(from: [first,second, third, fouth, fifth, zero, zero1])
         
         self.tableView.chatDataSource = self
         
         self.tableView.reloadData()
         
         self.view.addSubview(self.tableView)
     }
     
     func rowsForChatTable(_ tableView:TableView) -> Int
     {
         return self.Chats.count
     }
     
     func chatTableView(_ tableView:TableView, dataForRow row:Int) -> MessageItem
     {
         return Chats[row] as! MessageItem
     }
}
