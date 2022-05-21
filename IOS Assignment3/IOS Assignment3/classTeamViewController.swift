//
//  classTeamViewController.swift
//  IOS Assignment3
//
//  Created by Liu Mr. on 2022/1/9.
//

import UIKit

class classTeamViewController: UIViewController  {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Class Team"
        self.view.backgroundColor = UIColor.white
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(classTeamCell.self, forCellReuseIdentifier: NSStringFromClass(classTeamCell.self))
        return tableView
    }()
}


extension classTeamViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: -  UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: classTeamCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(classTeamCell.self), for: indexPath) as! classTeamCell
        cell.fillCellWith(indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    //MARK: -  UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let alert = UIAlertController(title:"Reminder",message:"Simulated join successful",preferredStyle:UIAlertController.Style.alert)
      
        let no  = UIAlertAction(title:"Confirm",style:UIAlertAction.Style.destructive,handler:{(alerts:UIAlertAction) -> Void in
                print("Confirm")})
            
        let unKnown = UIAlertAction(title:"Cancel" ,style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                print("Cancel")
            })
            
            
            
            
            alert.addAction(unKnown)
            
            self.present(alert,animated: true,completion: nil)
        
//        self.navigationController?.popViewController(animated: true)
    }
    
    //Set the width between the system cell line and the screen
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
    
}

