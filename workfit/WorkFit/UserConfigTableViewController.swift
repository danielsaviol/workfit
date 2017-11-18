//
//  UserConfigTableViewController.swift
//  WorkFit
//
//  Created by IFCE on 07/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit

class UserConfigTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.title = "Configurar"
        self.navigationItem.leftBarButtonItem?.title = ""
        tableView.isScrollEnabled = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 12
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath)
            return cell
        }
        if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell6", for: indexPath)
            return cell
        }
        if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell7", for: indexPath)
            return cell
        }
        if indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell8", for: indexPath)
            return cell
        }
        if indexPath.row == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell9", for: indexPath)
            return cell
        }
        if indexPath.row == 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell10", for: indexPath)
            return cell
        }
        if indexPath.row == 11 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell11", for: indexPath)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell10", for: indexPath)
            return cell
        }
    }
    
    @IBAction func btnSair(_ sender: UIButton) {
        appDelegate.handleLogout()
    }


    @IBAction func terms(_ sender: Any) {
        let alert = UIAlertController(title: "Terms and services", message: "Some of our Services allow you to upload, submit, store, send or receive content. You retain ownership of any intellectual property rights that you hold in that content. In short, what belongs to you stays yours. When you upload, submit, store, send or receive content to or through our Services, you give Google (and those we work with) a worldwide license to use, host, store, reproduce, modify, create derivative works (such as those resulting from translations, adaptations or other changes we make so that your content works better with our Services), communicate, publish, publicly perform, publicly display and distribute such content.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    }
    @IBAction func changepass(_ sender: Any) {
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
