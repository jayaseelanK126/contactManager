//
//  ContactManagerViewModel.swift
//  Contact Manager
//
//  Created by Pyramid on 18/11/21.
//

import Foundation
import RealmSwift

struct ContactManagerViewModel
{
    func getContactList(_ offsetVal:String, contactList: @escaping ([ContactManagerModel]) -> Void)
    {
        NetworkManager.GETMethodRequest(offset: offsetVal) { result in
            
            if let safeResult = result
            {
                let conatctListResponse = Parser.parseConatctList(apiResponse: safeResult)
               
                let operation = OperationQueue()
                
                operation.maxConcurrentOperationCount = 2
                
                let operation1 = BlockOperation {
                    contactList(conatctListResponse)
                }
                
                let operation2 = BlockOperation {
                    insertContact(offsetVal, constactList:conatctListResponse) {
                        fetchContactList { contactListResults in
                            
                            contactList(contactListResults)
                        }
                    }
                }
                operation.addOperation(operation1)
                operation.addOperation(operation2)

                
            }
            
        } Failure: { error in
            
        }
        
    }
    
    func insertContact(_ offset:String, constactList:[ContactManagerModel], sucess: @escaping()->Void)
    {
        let realm = try! Realm()
        
        try! realm.write {
            realm.cancelWrite()
        }
        
        print("Inserting.....")
        if !constactList.isEmpty
        {
            _ = constactList.map({ value in
                
                
                let conatctObj = Contact_Tbl()
                
                //id is not unique so i comment this code it insert based id not exist
                
                //let conatctResult = realm.objects(Contact_Tbl.self).filter("id = %d", value.id)
                
                try! realm.write
                {
//                    if conatctResult.isEmpty
//                    {
                        conatctObj.MobilePrimaryId = conatctObj.incrementMobilePrimaryId()
//                    }
//                    else
//                    {
//                        conatctObj = conatctResult[0] as Contact_Tbl
//                    }
                    conatctObj.id = value.id
                    conatctObj.name = value.name
                    conatctObj.phone = value.phone
                    conatctObj.country = value.country
                    conatctObj.company = value.company
                    conatctObj.photo = value.photo
                    conatctObj.zip = value.zip
                    conatctObj.age = value.age
                    conatctObj.address = value.address
                    conatctObj.email = value.email
                    conatctObj.photoImgData = GenericMethod.loadURLToData(urlStr: value.photo)
                    conatctObj.offset = Int(offset) ?? 0
                    realm.add(conatctObj)
                }
            })
            sucess()
        }
    }
    
    func getMaximumOffsetVal(_ offsetArr:[Int]) -> Int
    {
        
        return offsetArr.max() ?? 0 + 1
        
    }
    func fetchContactList(_ constactList: @escaping([ContactManagerModel]) -> Void)
    {
        let realm = try! Realm()
        
        let conatctResult = realm.objects(Contact_Tbl.self)
        
        if !conatctResult.isEmpty
        {
            var contactListArr:[ContactManagerModel] = []
            
            _ = Array(conatctResult).map({ value in
                
                let conatctListMangerModelObj = ContactManagerModel()
                
                conatctListMangerModelObj.name = value.name
                conatctListMangerModelObj.phone = value.phone
                conatctListMangerModelObj.country = value.country
                conatctListMangerModelObj.photo = value.photo
                conatctListMangerModelObj.photoImgData = value.photoImgData
                conatctListMangerModelObj.email = value.email
                conatctListMangerModelObj.address = value.address
                conatctListMangerModelObj.zip = value.zip
                conatctListMangerModelObj.offset = value.offset
                contactListArr.append(conatctListMangerModelObj)
            })
            
            constactList(contactListArr)
        }
        else
        {
            constactList([])
        }
        
    }
}

struct Section {
    let letter : String
    let names : [ContactManagerModel]
}
