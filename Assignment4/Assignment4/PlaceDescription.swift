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

import Foundation

class PlaceDescription{
    
    public var name: String = ""
    public var description: String = ""
    public var category: String = ""
    public var address_title: String = ""
    public var address_street: String = ""
    public var elevation: Float = 0.0
    public var latitude: Float = 0.0
    public var longitude: Float = 0.0
    public var distance:Double = 0.0
    public var bearing:Double = 0.0
    
    public init(name: String,description: String ,category: String,address_title: String,
                address_street: String,elevation :Float,latitude : Float, longitude: Float){
        self.name = name
        self.description = description
        self.category = category
        self.address_title = address_title
        self.address_street = address_street
        self.elevation = elevation
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public init (jsonStr: String){
        self.name = ""
        self.description = ""
        self.category = ""
        self.address_title = ""
        self.address_street = ""
        self.elevation = 0.0
        self.latitude = 0.0
        self.longitude = 0.0
        
        if let data: NSData = jsonStr.data(using: String.Encoding.utf8) as NSData?{
            do{
                let dict = try JSONSerialization.jsonObject(with: data as Data,options:.mutableContainers) as?[String:AnyObject]
                self.name = (dict!["name"] as? String)!
                self.description = (dict!["description"] as? String)!
                self.category = (dict!["category"] as? String)!
                self.address_title = (dict!["address_title"] as? String)!
                self.address_street = (dict!["address_street"] as? String)!
                self.elevation = (dict!["elevation"] as? Float)!
                self.latitude = (dict!["latitude"] as? Float)!
                self.longitude = (dict!["longitude"] as? Float)!
            } catch {
                print("unable to convert Json to a dictionary")
                
            }
        }
    }
    
    public init(dict:[String:Any]){
        self.name = dict["name"] == nil ? "unknown" : dict["name"] as! String
        self.description = dict["description"] == nil ? "unknown" : dict["description"] as! String
        self.category = dict["category"] == nil ? "unknown" : dict["category"] as! String
        self.address_title = dict["address_title"] == nil ? "unknown" : dict["address_title"] as! String
        self.address_street = dict["address_street"] == nil ? "unknown" : dict["address_street"] as! String
        self.elevation  = (dict["elevation"] as? NSNumber)?.floatValue ?? 0
        self.latitude =  (dict["latitude"] as? NSNumber)?.floatValue ?? 0
        self.longitude = (dict["longitude"] as? NSNumber)?.floatValue ?? 0
    }
    
    public func toJsonString() -> String {
        var jsonStr = "";
        let dict:[String : Any] = ["name": name,"description" :description ,"category": category,
                                   "address_title" : address_title, "address_street" :address_street,
                                   "elevation" : elevation, "latitude" : latitude, "longitude" : longitude] as [String : Any]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        } catch let error as NSError {
            print("unable to convert dictionary to a Json Object with error: \(error)")
        }
        return jsonStr
    }
    
}
