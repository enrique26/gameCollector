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
    
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var addupdate: UIButton!
    @IBOutlet var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var game :Game? = nil
    
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
        
        if game != nil {
            print("have a game")
            gameImageView.image=UIImage(data:game?.image as Data!)
            titleTextField.text=game!.title
            addupdate.setTitle("Add", for: .normal)
        }else{
            print("not a game")
            deleteButton.isHidden=true
            addupdate.setTitle("Update", for: .normal)
        }
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
        
        if game != nil {
            //en esta caso game existe en el contexto global ya que se espera recibir desde la vista previa asi que game se le añade la ! para que sepa que el valor no sera opcional 
            game!.title=titleTextField.text
            game!.image=UIImagePNGRepresentation(gameImageView.image!)
        }else {
            let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let game=Game(context: context)
            game.title=titleTextField.text
            game.image=UIImagePNGRepresentation(gameImageView.image!)
        }
        
        
        
        //guardar en la db
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    

}
