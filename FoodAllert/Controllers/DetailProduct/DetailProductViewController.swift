//
//  DetailProductViewController.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 1/27/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class DetailProductViewController: UIViewController {
    @IBOutlet weak var productName:UILabel!
    @IBOutlet weak var productCode:UILabel!
    @IBOutlet weak var productIngredientes:UITextView!
    @IBOutlet weak var productAllergens:UICollectionView!
    var isBarcodeScan:Bool?
    var arrayAllergen:[Entity] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if isBarcodeScan!{
            performSegue(withIdentifier: "scan_segue", sender: nil)
        }else{
            performSegue(withIdentifier: "speech_segue", sender: nil)
        }
        
        self.productName.text = ""
        self.productCode.text = ""
        self.title = "Food Allert"
        self.productIngredientes.text = ""
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "scan_segue"{
            let VC = segue.destination as! ScannerViewController
            VC.delegate = self
        }else if segue.identifier == "speech_segue"{
            let VC = segue.destination as! SpeechViewController
            VC.delegate = self
        }
     }
    
    // MARK: - WS Requests
    
    func searchProduct(code:String){
        FoodService.sharedInstance.search(code: code) {[unowned self] (results) in
            if results.statusCode == .success{
                if let product = results.resultObject?.product{
                    self.updateUI(product: product)
                    
                    self.searchAllergens(ingredients: product.ingredientsTextEs)
                }else{
                    let alert = UIAlertController(title: "Alerta", message: "No se encontro el producto.\n ¿Quieres dictarme los ingredientes?", preferredStyle: .alert)
                    let speech = UIAlertAction(title: "Si, Dictar", style: .default, handler: { (action) in
                        
                        self.performSegue(withIdentifier: "speech_segue", sender: nil)
                    })
                    
                    let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                    alert.addAction(speech)
                    alert.addAction(cancel)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func searchAllergens(ingredients:String){
        FoodPrediccionService.sharedInstance.search(ingredient: ingredients) {[unowned self] (results) in
            if results.statusCode == .success{
                guard let prediccion = results.resultObject else {return}
                if prediccion.entities.count > 0{
                    self.arrayAllergen = prediccion.entities.removeDuplicates()
                    let font = UIFont.systemFont(ofSize: 14)
                    let boldFont = UIFont.boldSystemFont(ofSize: 16)
                    var arrayString = [String]()
                    self.arrayAllergen.forEach({ (entity) in
                        arrayString.append(entity.entityEs.lowercased())
                        arrayString.append(entity.entityEs.uppercased())
                        arrayString.append(entity.entity.lowercased())
                    })
                    let atributeString = ingredients.withBoldText(boldPartsOfString: arrayString, font: font, boldFont: boldFont)
                    DispatchQueue.main.async {
                        let banner:NotificationBanner
                        if Preferences.sharedInstance.existConcidence(allergens: arrayString){
                            banner = NotificationBanner(title: "Peligro", subtitle: "Este producto tiene allergenos que pueden causarte daño", style: .danger)
                            
                        }else{
                            banner = NotificationBanner(title: "Confiable", subtitle: "Este producto no tiene alergenos", style: .success)
                        }
                        banner.show()
                        self.productAllergens.reloadData()
                        self.productIngredientes.attributedText = atributeString
                    }
                }else{
                    let banner = NotificationBanner(title: "Confiable", subtitle: "Este producto no tiene alergenos", style: .success)
                    banner.show()
                    self.productIngredientes.text = ingredients
                }
            }
        }
    }
    
    func updateUI(product:Product){
        let ingredients = product.ingredientsTextEs
        let nameProduct = product.productNameEs//product.genericNameEs
        let brand = product.brands
        let code  = product.code
        
        self.productName.text = nameProduct
        self.productCode.text = "Barcode: \(code)"
        self.title = brand
        self.productIngredientes.text = ingredients
        
    }


}

extension DetailProductViewController:ScannerViewControllerDelegate{
    
    func captureCode(code: String) {
        searchProduct(code: code)
    }
}

extension DetailProductViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayAllergen.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AllergenCollectionViewCell
        let entity = arrayAllergen[indexPath.row]
        cell.setup(entity: entity)
        
        return cell
    }

}

extension DetailProductViewController: SpeechViewControllerDelegate{
    func textDetected(string: String) {
        self.title = "Food Allert"
        self.productName.text = "Sin información"
        self.productCode.text = "Barcode: Sin información"
        self.searchAllergens(ingredients: string)
    }
}
