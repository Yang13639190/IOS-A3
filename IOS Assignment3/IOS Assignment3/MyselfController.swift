//
//  MyselfController.swift
//  IOS Assignment3
//
//  Created by 阳力强 on 12/5/2022.
//


import UIKit

class MyselfController: UITableViewController {

    
    
    @IBOutlet weak var headimage: UIImageView!
    @IBOutlet weak var usernamelab: UILabel!
    
    @IBOutlet weak var loginbtn: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delayExecution()
       
        //每秒钟刷新下登陆状态
        var timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector:#selector(self.delayExecution), userInfo: nil, repeats: true)


        RunLoop.current.add(timer, forMode: .common)

    }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func delayExecution(){
        let username = UserDefaults.standard.string(forKey: "username");
        
        
        if (username != nil){
            
            usernamelab.text = username
            loginbtn.setTitle("退出登陆", for: UIControl.State.normal)
                
            loginbtn.titleLabel?.text =  "退出登陆"
        }
        else
        {
            usernamelab.text = "未登录"
            loginbtn.setTitle("登陆", for: UIControl.State.normal)
           
        }
    }
    
    
    @objc func delectusername() {
        
        let alert = UIAlertController(title:"提示",message:"删除成功",preferredStyle:UIAlertController.Style.alert)
      
        let no  = UIAlertAction(title:"确定",style:UIAlertAction.Style.destructive,handler:{(alerts:UIAlertAction) -> Void in
                print("确定")
            
            let userDefaults = UserDefaults.standard
            let dics = userDefaults.dictionaryRepresentation()
            for key in dics { userDefaults.removeObject(forKey: key.key) }
            userDefaults.synchronize()

            
            
            //清楚当前登录信息
            UserDefaults.standard.setValue(nil, forKey: "username")
            UserDefaults.standard.synchronize()
            
            self.usernamelab.text = "未登录"
            self.loginbtn.setTitle("登陆", for: UIControl.State.normal)
        })
            
        let unKnown = UIAlertAction(title:"取消" ,style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                print("取消")
            })
            
            
            
        alert.addAction(no)
        alert.addAction(unKnown)
        
        self.present(alert,animated: true,completion: nil)
        
        
        
    }
    
    
    @IBAction func outlogoin(_ sender: Any) {
        let username = UserDefaults.standard.string(forKey: "username");
        
        
        if (username != nil){
            
            let alert = UIAlertController(title:"提示",message:"是否退出登陆？",preferredStyle:UIAlertController.Style.alert)
          
            let no  = UIAlertAction(title:"确定",style:UIAlertAction.Style.destructive,handler:{(alerts:UIAlertAction) -> Void in
                
                //清除当前登录信息
                UserDefaults.standard.setValue(nil, forKey: "username")
                UserDefaults.standard.synchronize()
                
                self.usernamelab.text = "未登录"
                self.loginbtn.setTitle("登陆", for: UIControl.State.normal)
                
            })
                
            let unKnown = UIAlertAction(title:"取消" ,style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                    print("取消")
                })
                
                
                
            alert.addAction(no)
            alert.addAction(unKnown)
            
            self.present(alert,animated: true,completion: nil)
            
            
        }
        else
        {
            //实例化一个登陆界面
            let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
            //信息界面出现的动画方式
             viewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            //界面跳转
             self.present(viewController, animated:true, completion:nil)
            
           
        }
            
    }
}
