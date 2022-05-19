//
//  RegisterViewController.swift
//  IOS Assignment3
//
//  Created by 阳力强 on 11/5/2022.
//

import UIKit

protocol RegisterProtocol:NSObjectProtocol {
    func fillUserData(name:String, pwd:String)
}

//register
class RegisterViewController: UIViewController {

    var userName : UITextField!
    var userPwd : UITextField!
    var confirmPwd : UITextField!
    var commit : UIButton!
    
    weak var delegate: RegisterProtocol?
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        
        self.title = "Register";
        
        let size = UIScreen.main.bounds.size;
        
        userName = UITextField()
        userPwd = UITextField()
        confirmPwd = UITextField()
        commit = UIButton()
        
        var frame = CGRect(x:24, y:160, width:size.width - 48, height:40)
        initTextField(_textField: &userName, frame: frame, placeholder: "Please enter your account number")
        
        frame = CGRect(x:24, y:220, width:size.width - 48, height:40)
        initTextField(_textField: &userPwd, frame: frame, placeholder: "Please enter your password")
        
        frame = CGRect(x:24, y:280, width:size.width - 48, height:40)
        initTextField(_textField: &confirmPwd, frame: frame, placeholder: "Please enter your password again")
        
        frame = CGRect(x:24, y:350, width:size.width - 48, height:36)
        commit.frame = frame
        commit.setTitle("Confirm", for:.normal)
        commit.layer.cornerRadius = 5
        commit.backgroundColor = UIColor.orange
        commit.addTarget(self, action: #selector(commitRegist(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(commit)
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.title = "Register"
    }
    
    @objc func commitRegist(_ sender:UIButton?){
        let defaults = UserDefaults.standard
        
        let userNameStr = userName.text
        let userPwdStr = userPwd.text
        let confirmPwdStr = confirmPwd.text
        let isSomeValueNil = checkNil(name: userNameStr!, pwd: userPwdStr!, cPwd: confirmPwdStr!)
        if(isSomeValueNil == true){
            return
        }
        
        if(userPwdStr != confirmPwdStr){
            alert(message: "The passwords are different")
            return
        }
        
        // 读取
        if defaults.string(forKey: userPwdStr!) != nil {
            return alert(message: "Account already exists")
        }
        
        
        
        //UserDefaults
        
        
        //The account and password are saved locally
        
        // write
        defaults.setValue(userPwdStr, forKey: userNameStr!)
        
        
        let alert = UIAlertController(title:"Reminder",message:"Registration successful",preferredStyle:UIAlertController.Style.alert)
      
        let no  = UIAlertAction(title:"Confirm",style:UIAlertAction.Style.destructive,handler:{(alerts:UIAlertAction) -> Void in
                print("Confirm")
            //dismiss
            
            self.dismiss(animated: true)
        })
            
        let unKnown = UIAlertAction(title:"Cancel" ,style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                print("Cancel")
            })
            
            
            
            alert.addAction(no)
            alert.addAction(unKnown)
            
            self.present(alert,animated: true,completion: nil)
        
       
         
        
        
        
    }
    
    
    
    func checkNil(name:String, pwd:String, cPwd:String) -> Bool{
        if(name == ""){
            alert(message: "The account cannot be empty")
            return true
        }
        if(pwd == ""){
            alert(message: "The password cannot be empty")
            return true
        }
        if(pwd == ""){
            alert(message: "The password cannot be empty")
            return true
        }
        return false;
    
    }
    
    func alert(message: String){
      
        let alert = UIAlertController(title:"Reminder",message:"Registration successful",preferredStyle:UIAlertController.Style.alert)
      
        let no  = UIAlertAction(title:"Confirm",style:UIAlertAction.Style.destructive,handler:{(alerts:UIAlertAction) -> Void in
                print("Confirm")
            //dismiss
            
            self.dismiss(animated: true)
        })
            
        let unKnown = UIAlertAction(title:"Cancel" ,style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                print("Cancel")
            })
            
            
            
            alert.addAction(no)
            alert.addAction(unKnown)
            
            self.present(alert,animated: true,completion: nil)

    }
    
    
    func initTextField(_textField tf: inout UITextField!, frame f: CGRect, placeholder p: String) -> Void{
        tf.frame = f
        tf.placeholder = p
        tf.layer.cornerRadius = 5
        tf.layer.borderColor = UIColor.brown.cgColor
        tf.layer.borderWidth = 1.0
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(tf)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
