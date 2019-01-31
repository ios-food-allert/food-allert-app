//
//  HomeViewController.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 18/01/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        performSegue(withIdentifier: "preference_segue", sender: nil)
        
    }
    

    @IBAction func searchProduct(_ sender: UIButton) {
        var typeView:Bool = false
        if sender.tag == 1{
            typeView = true
        }
        performSegue(withIdentifier: "search_segue", sender: typeView)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "search_segue"{
            let VC = segue.destination as! DetailProductViewController
            VC.isBarcodeScan = sender as? Bool
        }
    }


}
