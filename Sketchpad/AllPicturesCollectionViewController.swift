//
//  AllPicturesCollectionViewController.swift
//  Sketchpad
//
//  Created by Phizer Cost on 6/17/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import UIKit

class AllPicturesCollectionViewController: UICollectionViewController {
    
    var pictures : [Picture] = []

    
    
    override func viewWillAppear(_ animated: Bool) {
        getPictures()
    }
    
    func getPictures() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let pictures =  try? context.fetch(Picture.fetchRequest()) as? [Picture] {
                self.pictures = pictures
                collectionView?.reloadData()
                
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCell {
            let picture = pictures[indexPath.row]
            cell.nameLabel.text = picture.name
            if let imageData = picture.image {
                cell.imageView.image = UIImage(data: imageData)
            }  
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let picture = pictures[indexPath.row]
        performSegue(withIdentifier: "viewDetail", sender: picture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            if let picture = sender as? Picture {
                 detailVC.picture = picture
            }
           
        }
    }


}


class PictureCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
 
    @IBOutlet weak var nameLabel: UILabel!
    
}
