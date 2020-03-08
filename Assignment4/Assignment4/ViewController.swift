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
        setUpUi()
        self.title = place[selectedPlace]?.name
        setUpPicker()
    }
    
    func setUpUi(){
        name.text = place[selectedPlace]!.name
        desc.text = place[selectedPlace]!.description
        category.text = place[selectedPlace]!.category
        addressTitle.text = place[selectedPlace]!.address_title
        addressStreet.text = place[selectedPlace]!.address_street
        elevation.text = place[selectedPlace]!.elevation.description
        latitude.text = place[selectedPlace]!.latitude.description
        longitude.text = place[selectedPlace]!.longitude.description
        distance.text = place[selectedPlace]!.distance.description
        bearing.text = place[selectedPlace]!.bearing.description
    }
    
    func setUpPicker(){
        placePicker.delegate = self
        placePicker.dataSource = self
        placePicker.removeFromSuperview()
        selectplacelabel.inputView = placePicker
        selectedPlace =  (placesNames.count > 0) ? placesNames[0] : "Unknown Place"
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
        
        let setDistance = AppUtility.getDistance(currentPlace: place[selectedPlace]! , selectedPlace: place[thisPlace]!)
        let setBearing =  AppUtility.getBearing(currentPlace: place[selectedPlace]! , selectedPlace: place[thisPlace]!)
        
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

}
