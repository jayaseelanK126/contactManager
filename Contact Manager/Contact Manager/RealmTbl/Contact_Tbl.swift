//
//  Contact_Tbl.swift
//  Contact Manager
//
//  Created by Pyramid on 18/11/21.
//

import Foundation
import RealmSwift

//MATK:- Realm table
class Contact_Tbl: Object
{
    @objc dynamic var MobilePrimaryId: Int = 1
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var zip: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var company: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var photoImgData: Data?
    @objc dynamic var age: Int = 0
    @objc dynamic var offset: Int = 0
    
    override class func primaryKey() -> String?
    {
        return "MobilePrimaryId"
    }
    
    func incrementMobilePrimaryId() -> Int
    {
        let realm = try! Realm()
        return (realm.objects(Contact_Tbl.self).max(ofProperty: "MobilePrimaryId") as Int? ?? 0) + 1
    }
}

