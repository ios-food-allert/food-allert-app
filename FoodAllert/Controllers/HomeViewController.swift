//
//  HomeViewController.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 18/01/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit
import WhatsNewKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //if !Preferences.sharedInstance.existPreferences(){
            loadNewFeatures()
        //}
        
        
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
    
    
    func loadNewFeatures() {
        
       
        
        var configuration = WhatsNewViewController.Configuration()
        
        let AvenirNextfontTitle = UIFont(name: "AvenirNext-Bold", size: 30)!
        let AvenirNextfontItemsTitle = UIFont(name: "AvenirNext-Regular", size: 17)!
        let AvenirNextfontItems = UIFont(name: "AvenirNext-Regular", size: UIFont.systemFontSize)!
        let AvenirNextfontButton = UIFont(name: "AvenirNext-Bold", size: 20)!
        
        configuration.backgroundColor = .greenLight
        
        configuration.titleView.titleColor = .greenMedium
        configuration.titleView.animation = .slideUp
        configuration.titleView.titleFont = AvenirNextfontTitle
        
        configuration.itemsView.titleFont = AvenirNextfontItemsTitle
        configuration.itemsView.titleColor = .greenMedium
        configuration.itemsView.animation = .slideRight
        configuration.itemsView.subtitleFont = AvenirNextfontItems
        
        configuration.completionButton.backgroundColor = .greenMedium
        configuration.completionButton.titleFont = AvenirNextfontButton
        configuration.completionButton.title = "Continuar"
        configuration.completionButton.titleColor = .greenLight
        configuration.completionButton.animation = .slideDown
        configuration.completionButton.action = .custom(action: { [weak self] whatsNewViewController in
            self?.dismiss(animated: true, completion: nil)
             self?.performSegue(withIdentifier: "preference_segue", sender: nil)
        })
    
        
        
        
        
        let whatsNew = WhatsNew(
            title: "Food Allert",
            items: [
                WhatsNew.Item(
                    title: "Perfil de Alergias",
                    subtitle: "Indícale a Food Allert si tienes alguna alergia alimentaria para priorizar su detección.",
                    image: UIImage(named: "144d53-features-profile-filled")
                ),
                WhatsNew.Item(
                    title: "Lectura de Código de Barras",
                    subtitle: "Usa la cámara para escanear el código de barras del producto y consultar sus ingredientes.",
                    image: UIImage(named: "144d53-features-bar-code-filled")
                ),
                WhatsNew.Item(
                    title: "Ingreso de Datos por Voz",
                    subtitle: "Utiliza el micrófono para dictarle a Food Allert los ingredientes y contenidos.",
                    image: UIImage(named: "144d53-features-microphone-filled")
                ),
                WhatsNew.Item(
                    title: "Artículos y Tips",
                    subtitle: "Información relacionada y de interés respecto a las alergias alimentarias.",
                    image: UIImage(named: "144d53-features-articles-filled")
                )
            ]
        )
        
        let whatsNewViewController = WhatsNewViewController(
            whatsNew: whatsNew,
            configuration: configuration
        )
        
        
        self.present(whatsNewViewController, animated: true)
    }


}
