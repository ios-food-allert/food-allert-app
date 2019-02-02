//
//  ProfileViewController.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 2/2/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var picker:UIImagePickerController? = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func showActionSheet(){
//        let alert = UIAlertController(title: "Selecciona la fuente", message: nil, preferredStyle: .actionSheet)
//        let makePictureAction = UIAlertAction(title: "Camara", style: .default) { (alert) in
//            self.openCamera()
//        }
//        let showPictureAction = UIAlertAction(title: "Galeria", style: .default) { (alert) in
//            self.openGallery()
//        }
//        let elimarFoto = UIAlertAction(title: "Eliminar Foto", style: .default) { (alert) in
//            self.eliminarFoto()
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
//
//        alert.addAction(makePictureAction)
//        alert.addAction(showPictureAction)
//        alert.addAction(elimarFoto)
//        alert.addAction(cancelAction)
//
//        self.present(alert, animated: true)
//    }
//
//    func eliminarFoto(){
//        UserDefault.setImageUser(image: UIImage(named:"img_avatar"))
//        imgPerfil.image = UserDefault.getImageUser()
//    }
//
//    func openCamera(){
//        AVCaptureDevice.requestAccess(for: .video) { success in
//            if success {
//                print("Entro aqui en el succes")
//                self.picker!.allowsEditing = false
//                self.picker!.sourceType = UIImagePickerControllerSourceType.camera
//                self.picker!.cameraCaptureMode = .photo
//                self.present(self.picker!, animated: true)
//            }else{
//                let alert = UIAlertController(title: TextConstant.MENSAJE_AVISO, message: TextConstant.CAMARA_DESACTIVADA, preferredStyle: .alert)
//                let ok = UIAlertAction(title: TextConstant.MENSAJE_CANCELAR, style:.default, handler: nil)
//                alert.addAction(ok)
//                self.present(alert, animated: true)
//            }
//        }
//    }
//
//    func openGallery(){
//        picker!.allowsEditing = false
//        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        present(picker!, animated: true)
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
