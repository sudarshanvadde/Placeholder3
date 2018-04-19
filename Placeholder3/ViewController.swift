//
//  ViewController.swift
//  Placeholder3
//
//  Created by Sundir Talari on 03/04/18.
//  Copyright © 2018 Sundir Talari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!
    
    var json = [MyModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        table.delegate = self
        table.dataSource = self
        
        let url = URL(string: "https://trell.co.in/expresso/interestCategories.php")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data = data else {return}
            
            do {
    let Gettingjson = try JSONSerialization.jsonObject(with: data, options: []) as![String: Any]
                print(Gettingjson)
                
                //self.json = ((Gettingjson)["categoriesArray"] as! [Any] as! [MyModel])
                let someArr = ((Gettingjson)["categoriesArray"] as! [Any])
                
                
                for element in someArr {
                
                    
        let categoryIdFromServer = ((element as![String: Any])["categoryId"] as! String)
        let categoryNameFromServer = ((element as![String: Any])["categoryName"] as! String)
    let categoryImageFromServer = ((element as![String: Any])["categoryImage"] as! String)
                    
                    let myModelObj = MyModel()
                    myModelObj.categoryId = categoryIdFromServer
                    myModelObj.categoryName = categoryNameFromServer
                    myModelObj.categoryImage = categoryImageFromServer
                    
                    self.json.append(myModelObj)
                    
                }
                
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                
                
            }catch {
                print("json error: \(error.localizedDescription)")
            }
            
        }.resume()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell")
        let myModelObj = json[indexPath.row]
        cell?.textLabel?.text = "categoryName:\(myModelObj.categoryName), categoryId: \(myModelObj.categoryId)"
        return cell!
    }

}

