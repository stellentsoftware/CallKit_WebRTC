//
//  UsersListViewController.swift
//  CallKitWithWebRTC
//
//  Created by Venkatrao on 18/12/17.
//  Copyright © 2017 Stellent Soft Pvt Ltd. All rights reserved.
//

import UIKit
import Apollo

class UsersListViewController: UITableViewController {
    
    
    var users: [ListUsersQuery.Data.ListUser]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.hidesBackButton = true
        loadData()
    }
    // MARK: - Button Actions
    @objc func call(_ sender:UIButton)
    {
        guard let user = users?[sender.tag] else {
            fatalError("Could not find user at row \(sender.tag)")
        }
        self.performSegue(withIdentifier: "dialCallVC", sender: user)
    }
    @IBAction func logOutAction(_ sender: Any) {
        let userID = UserDefaults.standard.value(forKey: "userID") as! String
        let logOutMutation = LogOutMutation(_id: userID)
        apolloClient.perform(mutation: logOutMutation)
        { (result, error) in
            if let error = error
            {
                self.showAlert(withMessage: error.localizedDescription)
            }
            else
            {
                guard let error = result?.data?.logOut?.error else {return}
                if error
                {
                    self.showAlert(withMessage: (result?.data?.logOut?.message)!)
                }
                else
                {
                    UserDefaults.standard.removeObject(forKey: "userID")
                    UserDefaults.standard.removeObject(forKey: "userName")
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.synchronize()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    // MARK: - Data loading
    func loadData()
    {
        // Query initialisation with input parameters
        let listUsersQuery = ListUsersQuery(limit: 100)
        // Fetching query results with default cachePolicy and default queue
        apolloClient.fetch(query: listUsersQuery)
        { (result, error) in
            if let error = error
            {
                self.showAlert(withMessage: error.localizedDescription)
            }
            else
            {
                self.users = (result?.data?.listUsers as! [ListUsersQuery.Data.ListUser])
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? ProfileCell else {
            fatalError("Could not dequeue ProfileCell")
        }
        guard let user = users?[indexPath.row] else {
            fatalError("Could not find user at row \(indexPath.row)")
        }
        cell.configure(with: user.fragments.userDetails)
        cell.callButton.tag = indexPath.row
        cell.callButton.addTarget(self, action: #selector(call(_:)), for: .touchUpInside)
        cell.callButton.isEnabled = user.loginStatus ?? false
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dailCallVC = segue.destination as! DialCallViewController
        dailCallVC.currentUser = sender as? ListUsersQuery.Data.ListUser
    }
}
extension UIViewController
{
    func showAlert(withMessage message:String)
    {
        let alertController = UIAlertController(title: "CallKitWithWebRTC", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
