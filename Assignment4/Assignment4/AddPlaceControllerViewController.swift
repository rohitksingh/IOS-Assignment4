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
 * @version February 2016
 */

import UIKit

class AddPlaceControllerViewController: UIViewController {
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeDesc: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var strretAddress: UITextField!
    @IBOutlet weak var streetTitle: UITextField!
    @IBOutlet weak var elevation: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    var place:PlaceDescription!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "save":
            
            setValuesForPlace(placeName: (placeName.text ?? nil)!,placeDesc: (placeDesc.text ?? nil)!,category: (category.text ?? nil)!,streetTitle: (streetTitle.text ?? nil)!, strretAddress: (strretAddress.text ?? nil)!,
                              elevation: (elevation.text! as NSString).floatValue,latitude: (latitude.text! as NSString).floatValue,longitude: (longitude.text! as NSString).floatValue)
            
            
        case "cancel":
            print("cancel bar item")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    func setValuesForPlace(placeName: String,placeDesc : String,category : String,
                           streetTitle: String, strretAddress : String,elevation :Float,
                           latitude: Float, longitude: Float){
        
        place = PlaceDescription(name: placeName,description: placeDesc,category: category,address_title: streetTitle,
                                 address_street: strretAddress,elevation: elevation,latitude: latitude,longitude: longitude)
        
        NotificationCenter.default.post(name: .didReceiveData, object: place)
        
    }
    
}

public extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
}
