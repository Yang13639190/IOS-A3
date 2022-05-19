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
       
        //Refresh login status every second
        let timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector:#selector(self.delayExecution), userInfo: nil, repeats: true)


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
            loginbtn.setTitle("Logged out", for: UIControl.State.normal)
                
            loginbtn.titleLabel?.text =  "Logged out"
        }
        else
        {
            usernamelab.text = "not log in"
            loginbtn.setTitle("Login", for: UIControl.State.normal)
           
        }
    }
    
    
    @objc func delectusername() {
        
        let alert = UIAlertController(title:"Reminder",message:"Delete the success",preferredStyle:UIAlertController.Style.alert)
      
        let no  = UIAlertAction(title:"Confirm",style:UIAlertAction.Style.destructive,handler:{(alerts:UIAlertAction) -> Void in
                print("Confirm")
            
            let userDefaults = UserDefaults.standard
            let dics = userDefaults.dictionaryRepresentation()
            for key in dics { userDefaults.removeObject(forKey: key.key) }
            userDefaults.synchronize()

            
            
            //Clear the current login information
            UserDefaults.standard.setValue(nil, forKey: "username")
            UserDefaults.standard.synchronize()
            
            self.usernamelab.text = "not log in"
            self.loginbtn.setTitle("Login", for: UIControl.State.normal)
        })
            
        let unKnown = UIAlertAction(title:"Cancel" ,style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                print("Cancel")
            })
            
            
            
        alert.addAction(no)
        alert.addAction(unKnown)
        
        self.present(alert,animated: true,completion: nil)
        
        
        
    }
    
    
    @IBAction func outlogoin(_ sender: Any) {
        let username = UserDefaults.standard.string(forKey: "username");
        
        
        if (username != nil){
            
            let alert = UIAlertController(title:"Reminder",message:"Log out or not？",preferredStyle:UIAlertController.Style.alert)
          
            let no  = UIAlertAction(title:"Confirm",style:UIAlertAction.Style.destructive,handler:{(alerts:UIAlertAction) -> Void in
                
                //Clear the current login information
                UserDefaults.standard.setValue(nil, forKey: "username")
                UserDefaults.standard.synchronize()
                
                self.usernamelab.text = "not log in"
                self.loginbtn.setTitle("Login", for: UIControl.State.normal)
                
            })
                
            let unKnown = UIAlertAction(title:"Cancel" ,style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                    print("Cancel")
                })
                
                
                
            alert.addAction(no)
            alert.addAction(unKnown)
            
            self.present(alert,animated: true,completion: nil)
            
            
        }
        else
        {
            //Instantiate a login interface
            let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
            //How the information interface appears in animation
             viewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            //Interface jump
             self.present(viewController, animated:true, completion:nil)
            
           
        }
            
    }
}
