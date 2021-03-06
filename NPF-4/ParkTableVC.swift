//
//  ParkTableVC.swift
//  NPF-4
//
//  Created by Randy Perez on 4/25/16.
//  Copyright © 2016 Randy Perez. All rights reserved.
//

import UIKit

class ParkTableVC: UITableViewController {
    
    var mapVC:MapVC!
    var parkList = Parks()
    var parks : [Park] {
        get  {
            return self.parkList.parkList!
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
    
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
        return 1 //I just have one section so far 
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parks.count // need a row for each park
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParkCell", forIndexPath: indexPath)

        // Configure the cell...
        let park = parks[indexPath.row]
        let distance = mapVC?.locationManager?.location?.distanceFromLocation(park.getLocation()!)
        
        cell.textLabel?.text = park.getParkName()
        cell.detailTextLabel?.text = convertStringMetersToMiles((distance?.description)!) + " miles" //subtitle for now gotta change to distance
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
    
    func convertStringMetersToMiles(distance:String) -> String {
        let meterDistance = Double(distance)
        let milesDistance = round(meterDistance! * 0.00062137)
        return String(milesDistance)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let park = parks[indexPath.row]
        let ds: [[String]] = [[park.getParkName(),park.getParkLocation(), park.getArea(), "Date Formed: " + park.getDateFormed()], [park.getImageLink()], [park.getParkDescription()], [park.getLink()], ["Show MAP"], ["Add to Favorites"]]
        let detailVC = ParkDetailTableVC(style: .Grouped)
        detailVC.title = park.getParkName()
        detailVC.park = park
        detailVC.dataSource = ds
        detailVC.zoomDelegate = mapVC
        navigationController?.pushViewController(detailVC, animated: true)
    }

    @IBAction func sortDistance(sender: AnyObject) {
        
    }
    @IBAction func sortZA(sender: AnyObject) {
        parks.sortInPlace({$0.getParkName() > $1.getParkName()})
        self.tableView.reloadData()
    }
    
    @IBAction func sortAZ(sender: AnyObject) {
        parks.sortInPlace({$0.getParkName() < $1.getParkName()})
        self.tableView.reloadData()
    }
}
