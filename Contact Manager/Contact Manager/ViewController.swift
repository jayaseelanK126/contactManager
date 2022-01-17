//
//  ViewController.swift
//  Contact Manager
//
//  Created by Pyramid on 18/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var conatctListTblView: UITableView!
    
    
    lazy var contactListViewModelObj:ContactManagerViewModel =
    {
        return ContactManagerViewModel()
    }()
    
    var constactList:[ContactManagerModel] = []
    var sections = [Section]()

    private var selectedRow:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMethod()
        loadData("0")
        
        
    }

    func setUpMethod()
    {
        conatctListTblView.register(UINib(nibName: "ContactManagerTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactManagerCell")
    }

    func loadData(_ offsetVal:String)
    {
        contactListViewModelObj.getContactList(offsetVal) { [weak self]contactList in
            self?.constactList = contactList
            
            //A:[Apple, Air]
            let groupedDictionary = Dictionary(grouping: (self?.constactList)!, by: {String($0.name.prefix(1))})
            
            let keys = groupedDictionary.keys.sorted()
             
            self?.sections = keys.map {Section(letter: $0, names: groupedDictionary[$0]!)}
            
            print(self?.sections)
            
            DispatchQueue.main.async {
                self?.conatctListTblView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map({$0.letter})
    }
    
    func tableView(_ tableView:UITableView, titleForHeaderInSection  section: Int) -> String?
    {
        return sections[section].letter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sections[section].names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactManagerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactManagerCell", for: indexPath) as! ContactManagerTableViewCell
        
        let section = sections[indexPath.section]
        
        cell.contactnameLbl.text = section.names[indexPath.row].name
        cell.contactLocationLbl.text = section.names[indexPath.row].country
        if let safeData = section.names[indexPath.row].photoImgData
        {
            cell.contactImgView.image = UIImage(data: safeData)
        }
        else
        {
            cell.contactImgView.image = UIImage(named: "person")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            return UITableView.automaticDimension
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
       {
           selectedRow = indexPath.row
           performSegue(withIdentifier: "showDetail", sender: self)
           
       }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // need to pass your indexpath then it showing your indicator at bottom
    }
       
       //MARK: - Data passing between two views
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showDetail"
           {
               let secondViewController = segue.destination as! DetailsViewController
               secondViewController.conatctListManagerObj = constactList[selectedRow!]
           }
       }

}

