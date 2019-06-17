//
//  DetailViewController.swift
//  Sketchpad
//
//  Created by Phizer Cost on 6/17/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var picture: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = picture?.name
        if let imageData = picture?.image {
            imageView.image = UIImage(data: imageData)
        }
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let picToDelete = picture {
                context.delete(picToDelete)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        if let image = imageView.image {
            let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(shareVC, animated: true, completion: nil)
        }
        
    }
    
}
