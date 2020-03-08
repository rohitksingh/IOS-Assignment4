/*
 * Copyright 2020 Rohit Kumar Singh,
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author Rohit Kumar Singh rsingh92@asu.edu
 *
 * @version March 2016
 */
import Foundation
import UIKit

class PlaceListTableViewController: UITableViewController {
    
    
    let controller = PlaceLibrary()
    var placesList:[String:PlaceDescription] = [String:PlaceDescription]()
    var names:[String] = [String]()
    
    @IBOutlet weak var placeTableListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
        placesList =  controller.getData()
        self.names = Array(placesList.keys).sorted()
        self.title = "Places"
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("tableView editing row at: \(indexPath.row)")
        if editingStyle == .delete {
            let selectedPlace:String = names[indexPath.row]
            placesList.removeValue(forKey: selectedPlace)
            names = Array(placesList.keys)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get and configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceList", for: indexPath)
        let places = placesList[names[indexPath.row]]! as PlaceDescription
        cell.textLabel?.text = places.name
        cell.detailTextLabel?.text = "\(places.category)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object (and model) to the new view controller.
        //NSLog("seque identifier is \(String(describing: segue.identifier))")
        if segue.identifier == "DetailSegue" {
            let viewController:PlaceDetailViewController = segue.destination as! PlaceDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            viewController.place = self.placesList
            viewController.selectedPlace = self.names[indexPath.row]
            viewController.placesNames = names
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    
    @objc func onDidReceiveData(_ notification:Notification) {
        
        guard let dic = notification.object as? PlaceDescription else {
            return
        }
        print("Hi i am here 3")

        let newPlace:PlaceDescription = PlaceDescription(name: dic.name, description: dic.description,
                                                         category: dic.category, address_title: dic.address_title,
                                                         address_street: dic.address_street , elevation: dic.elevation,
                                                         latitude: dic.latitude, longitude: dic.longitude)
        self.placesList[dic.name] = newPlace
        self.names = Array(self.placesList.keys).sorted()
        self.tableView.reloadData()
    }
    
}
