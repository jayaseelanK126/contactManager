//
//  Parser.swift
//  Contact Manager
//
//  Created by Pyramid on 18/11/21.
//

import Foundation
import ObjectMapper

class Parser: NSObject
{
    class func parseConatctList(apiResponse:AnyObject) -> [ContactManagerModel]
    {
        let responseObj = Mapper<ContactManagerModel>().mapArray(JSONArray: apiResponse as! [[String : Any]])
        
        return responseObj
    }
}
