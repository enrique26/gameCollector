//
//  GameViewController.swift
//  GameCollector
//
//  Created by Enrique Gachuz on 09/01/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet var gameImageView: UIImageView!
    
    @IBOutlet var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    //esconder teclado al tocar la pantalla
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //esconder teclado al dar click en el boton return del teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleTextField.delegate = self
        imagePicker.delegate=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraTap(_ sender: Any) {
    }
    //get image from picker controller select event
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //replace image on image view
        gameImageView.image=image
        //dismiis picker controller
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photosTap(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: false, completion: nil)
    }
    
    @IBAction func addTap(_ sender: Any) {
        let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let game=Game(context: context)
        game.title=titleTextField.text
        game.image=UIImagePNGRepresentation(gameImageView.image!)
        
        //guardar en la db
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    

}
