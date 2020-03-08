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
import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var category: UITextView!
    @IBOutlet weak var addressTitle: UITextView!
    @IBOutlet weak var addressStreet: UITextView!
    @IBOutlet weak var elevation: UITextView!
    @IBOutlet weak var latitude: UITextView!
    @IBOutlet weak var longitude: UITextView!
    @IBOutlet weak var placePicker: UIPickerView!
    @IBOutlet weak var selectplacelabel: UITextField!
    @IBOutlet weak var distance: UITextView!
    @IBOutlet weak var bearing: UITextView!
    
    var place:[String:PlaceDescription] = [String:PlaceDescription]()
    var selectedPlace:String = "Select a Place"
    
    var placesNames:[String] = [String]()
    let zero = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = "\(place[selectedPlace]!.name)"
        desc.text = "\(place[selectedPlace]!.description)"
        category.text = "\(place[selectedPlace]!.category)"
        addressTitle.text = "\(place[selectedPlace]!.address_title)"
        addressStreet.text = "\(place[selectedPlace]!.address_street)"
        elevation.text = "\(place[selectedPlace]!.elevation)"
        latitude.text = "\(place[selectedPlace]!.latitude)"
        longitude.text = "\(place[selectedPlace]!.longitude)"
        distance.text = "\(place[selectedPlace]!.distance)"
        bearing.text = "\(place[selectedPlace]!.bearing)"
        
        
        self.title = place[selectedPlace]?.name
        placePicker.delegate = self
        placePicker.dataSource = self
        placePicker.removeFromSuperview()
        selectplacelabel.inputView = placePicker
        selectedPlace =  (placesNames.count > 0) ? placesNames[0] : "unknown unknown"
        let place:[String] = selectedPlace.components(separatedBy: " ")
        selectplacelabel.text = place[0]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.selectplacelabel.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.selectplacelabel.resignFirstResponder()
        return true
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let thisPlace = placesNames[row]
        let tokens:[String] = thisPlace.components(separatedBy: " ")
        self.selectplacelabel.text = tokens[0]
        print(place[thisPlace]!.longitude)
        print(place[thisPlace]!.latitude)

        let setDistance = getDistance(latitude: Double(place[thisPlace]!.latitude), longitude: Double(place[thisPlace]!.longitude))

        let setBearing =  getBearing(latitude: Double(place[thisPlace]!.latitude), longitude: Double(place[thisPlace]!.longitude))

        distance.text = String(setDistance)+" KM"

        bearing.text = String(setBearing)+" Degree"

        self.selectplacelabel.resignFirstResponder()
    }

    func pickerView (_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let p:String = placesNames[row]
        let tokens:[String] = p.components(separatedBy: " ")
        return tokens[0]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return placesNames.count
    }

    func getDistance(latitude:Double, longitude :Double) -> Double {
        
        var lat1 = 0.0
        var lat2 = 0.0
        var lon1 = 0.0
        var lon2 = 0.0
        
        lat1 = Double(place[selectedPlace]!.latitude)
        lon1 = Double(place[selectedPlace]!.longitude)
        
        lat2 = latitude
        lon2 = longitude
        
        if ((lat1 == lat2) && (lon1 == lon2)) {
            return zero
        } else {
            let theta = lon1 - lon2
            var dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2))
                + cos(deg2rad(lat1)) * cos(deg2rad(lat2))
                * cos(deg2rad(theta))
            dist = acos(dist)
            dist = radiansToDegrees(radians: dist)
            dist = dist * 60 * 1.1515 * 1.609344
            return (dist)
        }
    }
    
    func getBearing(latitude:Double, longitude :Double) -> Double {
        
        var lat1 = 0.0
        var lat2 = 0.0
        var lon1 = 0.0
        var lon2 = 0.0
        
        lat1 = Double(place[selectedPlace]!.latitude)
        lat1 = deg2rad(lat1)
        
        lon1 = Double(place[selectedPlace]!.longitude)
        
        lat2 = latitude
        lat2 = deg2rad(lat2)
        
        lon2 = longitude
        
        let longDiff = deg2rad(lon2 - lon1)
        let y = sin(longDiff) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(longDiff)
        
        return (radiansToDegrees(radians: atan2(y, x)) + 360).truncatingRemainder(dividingBy:360)
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    func radiansToDegrees (radians: Double)->Double {
        return radians * 180 / .pi
    }
    
}


