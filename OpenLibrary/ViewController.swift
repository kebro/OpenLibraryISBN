//
//  ViewController.swift
//  OpenLibrary
//
//  Created by Daniel García Morales on 31/7/16.
//  Copyright © 2016 Daniel García Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var outISBN: UITextView!
    
    @IBAction func limpiarTxt(sender: AnyObject) {
        txtISBN.text = ""
    }
    
    @IBAction func buscarISBN(sender: AnyObject) {
        outISBN.text = ""
        var urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let isbn = txtISBN.text!
        urls = "\(urls)\(isbn)"
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOfURL: url!)
        if datos == nil {
            let alertController = UIAlertController(title: "Error", message:"Se ha producido un error de comunicación.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)!
            
            if String(texto) == "{}" {
                let alertController = UIAlertController(title: "Aviso", message:"No se ha encontrado el libro indicado.", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                outISBN.text = String("")
                
            }else{
                outISBN.text = String(texto)
            }
        }
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}

