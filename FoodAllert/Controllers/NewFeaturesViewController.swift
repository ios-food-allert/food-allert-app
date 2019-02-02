//
//  NewFeaturesViewController.swift
//  FoodAllert
//
//  Created by José Gil Ramírez S on 2/2/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit
import WhatsNewKit

class NewFeaturesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadNewFeatures()
    }
    
    func loadNewFeatures() {
        var configuration = WhatsNewViewController.Configuration()
        
        let AvenirNextfontTitle = UIFont(name: "AvenirNext-Bold", size: 30)!
        let AvenirNextfontItemsTitle = UIFont(name: "AvenirNext-Regular", size: 17)!
        let AvenirNextfontItems = UIFont(name: "AvenirNext-Regular", size: UIFont.systemFontSize)!
        let AvenirNextfontButton = UIFont(name: "AvenirNext-Bold", size: 20)!
        
        configuration.backgroundColor = .white
        
        configuration.titleView.titleColor = UIColor(hexString: "#144d53")
        configuration.titleView.animation = .slideUp
        configuration.titleView.titleFont = AvenirNextfontTitle
        
        configuration.itemsView.titleFont = AvenirNextfontItemsTitle
        configuration.itemsView.titleColor = UIColor(hexString: "#144d53")
        configuration.itemsView.animation = .slideRight
        configuration.itemsView.subtitleFont = AvenirNextfontItems
        
        configuration.completionButton.backgroundColor = UIColor(hexString: "#144d53")
        configuration.completionButton.titleFont = AvenirNextfontButton
        configuration.completionButton.title = "Continuar"
        configuration.completionButton.animation = .slideDown
        
        
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


