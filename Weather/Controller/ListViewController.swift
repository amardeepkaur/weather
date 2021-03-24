//
//  ListViewController.swift
//  Weather
//
//  Created by Amardeep Kaur on 02/11/20.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let cityName = "New york"
        
        if let cityList = readJsonFromFile() {
//            let jsonContent
            print(cityList)
        }
    
        
    }

    func readJsonFromFile()  -> City?  {
        var cityList: City?
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json"){
            do {
                let fileUrl = URL(fileURLWithPath: path)
                //Getting data from the json file using the fileURL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                cityList = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? City
            } catch {
                print("Error getting data from the json URL \(error)")
            }
        }
        return cityList
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
