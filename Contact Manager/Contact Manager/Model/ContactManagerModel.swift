//
//  ContactManagerModel.swift
//  Contact Manager
//
//  Created by Pyramid on 18/11/21.
//

import Foundation
import ObjectMapper

class ContactManagerModel:Mappable
{
    var name:String = ""
    var phone:String = ""
    var email:String = ""
    var address:String = ""
    var zip:String = ""
    var country:String = ""
    var id:Int = 0
    var company:String = ""
    var photo:String = ""
    var age:Int = 0
    var photoImgData:Data?
    var offset:Int = 0
    
    required init?(map: Map)
    {
        
    }
    
    init()
    {
        
    }
    
    func mapping(map: Map)
    {
        id         <- map["id"]
        photo         <- map["photo"]
        phone         <- map["phone"]
        name         <- map["name"]
        email         <- map["email"]
        country         <- map["country"]
        address         <- map["address"]
        company         <- map["company"]
        zip         <- map["zip"]
        age         <- map["age"]
    }
}

