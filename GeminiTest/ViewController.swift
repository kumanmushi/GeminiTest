//
//  ViewController.swift
//  GeminiTest
//
//  Created by 村田真矢 on 2018/12/03.
//  Copyright © 2018 村田真矢. All rights reserved.
//

import UIKit
import Gemini
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: GeminiCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.collectionView.register(UINib(nibName: "Gemini1CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Gemini1CollectionViewCell")
        self.collectionView.register(UINib(nibName: "Gemini2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Gemini2CollectionViewCell")
        
        self.collectionView.gemini.cubeAnimation().cubeDegree(90)

    }


}
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = URL(string: "https://bike-lineage.org/suzuki/gsx-s750/img/gr7na.jpg")
        if indexPath.row < 9 {
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "Gemini1CollectionViewCell", for: indexPath) as! Gemini1CollectionViewCell
            cell.imageView.sd_setImage(with: url, completed: nil)
            self.collectionView.animateCell(cell)
            
            return cell
        }
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "Gemini2CollectionViewCell", for: indexPath) as! Gemini2CollectionViewCell
        cell.imageView.sd_setImage(with: url, completed: nil)
        self.collectionView.animateCell(cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! GeminiCell
        self.collectionView.animateCell(cell)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.animateVisibleCells()
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension UIImageView {
    
    func setImage(url: String) {
        guard let url = URL(string: url) else { return }
        let dataFromURL = try? Data(contentsOf: url)
        guard let data = dataFromURL else { return }
        DispatchQueue.main.async {
            self.image = UIImage(data: data)
        }
    }
}
