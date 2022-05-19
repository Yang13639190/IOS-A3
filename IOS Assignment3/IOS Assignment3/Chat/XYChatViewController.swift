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

//MARK:设置输入框
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
        sendButton.setTitle("发送", for:UIControl.State())
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
        let thatChat =  MessageItem(body:("你说的是：\(sender!.text!)" as NSString) as String, userInfo:you, date:Date(), mtype:ChatType.someone)
        
        Chats.add(thisChat)
        Chats.add(thatChat)
        self.tableView.chatDataSource = self
        self.tableView.reloadData()
        
        //self.showTableView()
        sender?.resignFirstResponder()
        sender?.text = ""
    }
}

//MARK:设置聊天假数据以及数据源
extension XYChatViewController
{
    
     func setupChatTable()
     {
         self.tableView = TableView(frame:CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height - 76), style: .plain)
         
         //创建一个重用的单元格
         self.tableView!.register(TableViewCell.self, forCellReuseIdentifier: "ChatCell")
         me = UserInfo(name:"Xiaoming" ,avatar:("xiaoming.png"))
         you  = UserInfo(name:"Xiaohua", avatar:("xiaohua.png"))
         
         let zero =  MessageItem(body:"你好同学，你也是学习这个课程吗？", userInfo:you,  date:Date(timeIntervalSinceNow:-90096400), mtype:.someone)
         
         let zero1 =  MessageItem(body:"是的啊，你也是吗？", userInfo:me,  date:Date(timeIntervalSinceNow:-90086400), mtype:.mine)
         
         let first =  MessageItem(body:"这个图片真漂亮！", userInfo:me,  date:Date(timeIntervalSinceNow:-90000600), mtype:.mine)
         
         let second =  MessageItem(image:UIImage(named:"xiaohua.png")!,userInfo:me, date:Date(timeIntervalSinceNow:-90000290), mtype:.mine)
         
         let third =  MessageItem(body:"谢谢，很高兴认识你呢！",userInfo:you, date:Date(timeIntervalSinceNow:-90000060), mtype:.someone)
         
         let fouth =  MessageItem(body:"me，too",userInfo:me, date:Date(timeIntervalSinceNow:-90000020), mtype:.mine)
         
         let fifth =  MessageItem(body:"我们大家可以相互交流",userInfo:you, date:Date(timeIntervalSinceNow:0), mtype:.someone)
         

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
