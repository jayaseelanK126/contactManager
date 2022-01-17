//
//  DetailsViewController.swift
//  Contact Manager
//
//  Created by Pyramid on 18/11/21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var countryLnl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var photiImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var conatctListManagerObj:ContactManagerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
    
func setUp()
    {
        addressLbl.text = conatctListManagerObj?.address
        emailLbl.text = conatctListManagerObj?.email
        nameLbl.text = conatctListManagerObj?.name
        countryLnl.text = conatctListManagerObj?.country
        companyLbl.text = conatctListManagerObj?.company
        phoneLbl.text =  conatctListManagerObj?.phone
        if let safeData = conatctListManagerObj?.photoImgData
        {
            photiImgView.image = UIImage(data: safeData)
            
        }
        else
        {
            photiImgView.image = UIImage(named: "person")
        }
    }
   
    @IBAction func backBtnAction(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)

    }
    
}
