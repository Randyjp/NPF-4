//
//  ParkDetailTableVC.swift
//  NPF-4
//
//  Created by Randy Perez on 4/26/16.
//  Copyright © 2016 Randy Perez. All rights reserved.
//

import UIKit

let INFO_SECTION = 0
let IMG_SECTION = 1
let DESC_SECTION = 2
let URL_SECTION = 3
let MAP_SECTION = 4
let FAV_SECTION = 5


class ParkDetailTableVC: UITableViewController {
    
    var park: Park!
    var dataSource : [[String]]!
    var zoomDelegate:ZoomimgProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
//        return 3
        return dataSource.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return 3 // this is only detail for one park ???
        return dataSource[section].count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")

        // Configure the cell...
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        }
        
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell?.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        cell?.textLabel?.textAlignment = .Center
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
        case MAP_SECTION:
            zoomDelegate?.zoomOnAnnotation(park)
        case URL_SECTION:
            UIApplication.sharedApplication().openURL(NSURL(string: park.getLink())!)
        case FAV_SECTION:
            let defaults = NSUserDefaults.standardUserDefaults()
            let encondedObj = NSKeyedArchiver.archivedDataWithRootObject(park)
            defaults.setObject(encondedObj, forKey: park.getParkName())
            
            let alert = UIAlertController(title: "Favorites", message: "\(park.getParkName()) was added to Favorites", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        default:
            print("mierda esto no es \(indexPath.section)")
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case DESC_SECTION:
            return 88
        default:
            return 44
        }
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
