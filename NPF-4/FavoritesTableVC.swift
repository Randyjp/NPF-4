//
//  FavoritesTableVC.swift
//  NPF-4
//
//  Created by Randy Perez on 4/27/16.
//  Copyright © 2016 Randy Perez. All rights reserved.
//

import UIKit

class FavoritesTableVC: UITableViewController {
    
    var parks: [Park]?
    var favorites:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let array = NSUserDefaults.standardUserDefaults().arrayForKey("favorites") as? [String]
        
        if array != nil {
            favorites = array
        } else {
            favorites = []
        }
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let decoded  = defaults.objectForKey("Acadia National Park") as! NSData
//        let decodedTeams = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! Park
//        print(decodedTeams)
//        print(NSUserDefaults.standardUserDefaults().dictionaryRepresentation())//        if let name = defaults.objectForKey("Acadia National Park") as! NSData {
//            let decodedTeams = NSKeyedUnarchiver.unarchiveObjectWithData(name) as! [Park]
//            print(name)
//        }
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteCell", forIndexPath: indexPath)
        
        // Configure the cell...
        let park = favorites![indexPath.row]
        cell.textLabel?.text = park
//        cell .detailTextLabel?.text = landmark.state //this is the subtitle
        cell.accessoryType = .DisclosureIndicator
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
