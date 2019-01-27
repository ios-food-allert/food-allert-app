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
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "scan_segue"{
            let VC = segue.destination as! ScannerViewController
            VC.delegate = self
        }
    }


}

extension HomeViewController:ScannerViewControllerDelegate{
    func captureCode(code: String) {
        FoodService.sharedInstance.search(code: code) { (result) in
            if let result = result.resultObject{
                debugPrint(result)
            }
        }
    }
}
