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

public class PlaceLibrary{
    
    var placesList:[String:PlaceDescription] = [String:PlaceDescription]()
    var names:[String] = [String]()
    
    func getAllPlaces() -> [String:PlaceDescription]{
        
        if let path = Bundle.main.path(forResource: "places", ofType: "json"){
            do {
                let jsonStr:String = try String(contentsOfFile:path)
                let data:Data = jsonStr.data(using: String.Encoding.utf8)!
                let dict:[String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
                for places:String in dict.keys {
                    let place:PlaceDescription = PlaceDescription(dict: dict[places] as! [String:Any])
                    self.placesList[places] = place
                }
            } catch {
                
            }
        }
        
        return placesList
    }
    
}
