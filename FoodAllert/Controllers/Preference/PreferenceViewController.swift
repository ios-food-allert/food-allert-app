//
//  PreferenceViewController.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 1/30/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit
import Magnetic
import SpriteKit

class PreferenceViewController: UIViewController {

    @IBOutlet weak var magneticView:MagneticView! {
        didSet{
            magnetic.magneticDelegate = self
        }
    }
    @IBOutlet weak var btnReset:UIButton!
    @IBOutlet weak var btnSave:UIButton!
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    let allergens = ["eggs","fish","milk","nut","nutshell","peach","peanuts","shrimp-and-lobster","soy","strawberry","wheat"]
    var allergensSelected = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        magnetic.backgroundColor = SKColor.greenLight
        addAllergen(isLoad: Preferences.sharedInstance.existPreferences())

        // Do any additional setup after loading the view.
    }
    
    func addAllergen(isLoad:Bool){
        
            for name in allergens{
                autoreleasepool{
                    let image = UIImage(named: name)
                    let color = UIColor.colorsStrongs.randomItem()
                    let node = Node(text: name, image: image, color: color, radius: 50)
                    if isLoad{
                        let selected = Preferences.sharedInstance.existConcidence(allergens: [name])
                        if selected{
                            allergensSelected.append(name)
                        }
                        node.isSelected = selected
                    }
                    magnetic.addChild(node)
                }
            }
        btnSave.isEnabled = true
        btnReset.isEnabled = true
        
        
    }
    
    
    @IBAction func savePreference(){
        
        Preferences.sharedInstance.savePreference(allergens: allergensSelected)
        self.dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func reset(_ sender: UIControl?) {
        btnSave.isEnabled = false
        btnReset.isEnabled = false
        let speed = magnetic.physicsWorld.speed
        magnetic.physicsWorld.speed = 0
        let sortedNodes = magnetic.children.compactMap { $0 as? Node }.sorted { node, nextNode in
            let distance = node.position.distance(from: magnetic.magneticField.position)
            let nextDistance = nextNode.position.distance(from: magnetic.magneticField.position)
            return distance < nextDistance && node.isSelected
        }
        var actions = [SKAction]()
        for (index, node) in sortedNodes.enumerated() {
            node.physicsBody = nil
            let action = SKAction.run { [unowned magnetic, unowned node] in
                if node.isSelected {
                    let point = CGPoint(x: magnetic.size.width / 2, y: magnetic.size.height + 40)
                    let movingXAction = SKAction.moveTo(x: point.x, duration: 0.2)
                    let movingYAction = SKAction.moveTo(y: point.y, duration: 0.4)
                    let resize = SKAction.scale(to: 0.3, duration: 0.4)
                    let throwAction = SKAction.group([movingXAction, movingYAction, resize])
                    node.run(throwAction) { [unowned node] in
                        node.removeFromParent()
                    }
                } else {
                    node.removeFromParent()
                }
            }
            actions.append(action)
            let delay = SKAction.wait(forDuration: TimeInterval(index) * 0.002)
            actions.append(delay)
        }
        magnetic.run(.sequence(actions)) { [unowned magnetic] in
            magnetic.physicsWorld.speed = speed
        }
        
        addAllergen(isLoad: Preferences.sharedInstance.existPreferences())
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
extension PreferenceViewController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        print("didSelect -> \(node)")
        allergensSelected.append(node.text!)
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
        let index = allergensSelected.firstIndex(of: node.text!)
        allergensSelected.remove(at: index!)
        
    }
    
}
