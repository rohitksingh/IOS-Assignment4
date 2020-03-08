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
    
    @IBOutlet weak var placeTableListView: UITableView!
    var placesList:[String:PlaceDescription] = [String:PlaceDescription]()
    var names:[String] = [String]()
    
    let controller = PlaceLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
        placesList =  controller.getData()
        self.names = Array(placesList.keys).sorted()
        self.title = "Places"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let selectedPlace:String = names[indexPath.row]
            placesList.removeValue(forKey: selectedPlace)
            names = Array(placesList.keys)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceList", for: indexPath)
        let places = placesList[names[indexPath.row]]! as PlaceDescription
        cell.textLabel?.text = places.name
        cell.detailTextLabel?.text = "\(places.category)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "DetailSegue" {
            let viewController:PlaceDetailViewController = segue.destination as! PlaceDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            viewController.place = self.placesList
            viewController.selectedPlace = self.names[indexPath.row]
            viewController.placesNames = names
        }
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        
        guard let place = notification.object as? PlaceDescription else {
            return
        }
        
        let newPlace:PlaceDescription = PlaceDescription(name: place.name, description: place.description,
                                                         category: place.category, address_title: place.address_title,
                                                         address_street: place.address_street , elevation: place.elevation,
                                                         latitude: place.latitude, longitude: place.longitude)
        self.placesList[place.name] = newPlace
        self.names = Array(self.placesList.keys).sorted()
        self.tableView.reloadData()
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
}
