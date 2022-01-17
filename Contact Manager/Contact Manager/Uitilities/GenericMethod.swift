//
//  GenericMethod.swift
//  Contact Manager
//
//  Created by Pyramid on 18/11/21.
//

import Foundation
import UIKit


class GenericMethod:NSObject
{
    class func loadURLToData(urlStr: String) -> Data
    {
        if let url = URL(string: urlStr)
        {
            do
            {
                return try Data(contentsOf: url)
                
            }
            catch
            {
                print("\(error)")
            }
        }
        return Data()
    }
    
    class func openDeviceSettings()
    {
        if let url = URL(string: UIApplication.openSettingsURLString)
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
