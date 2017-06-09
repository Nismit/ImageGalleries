//
//  ViewController.swift
//  ImageGalleries
//
//  Created by Michinobu Nishimoto on 2017-06-08.
//  Copyright © 2017 Michinobu Nishimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.delegate = self
        self.title = "Image Gallaries"
        
        
        let image1 = setImage(name: "image1", tag: 1, nextTo: nil)
        let image2 = setImage(name: "image2", tag: 2, nextTo: image1)
        let image3 = setImage(name: "image3", tag: 3, nextTo: image2)
        let image4 = setImage(name: "image4", tag: 4, nextTo: image3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImage(name:String, tag: Int, nextTo: UIImageView?) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: name))
        imageView.tag = tag
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)
        
        if let nextImageView = nextTo {
            imageView.leadingAnchor.constraint(equalTo: nextImageView.trailingAnchor, constant: 0).isActive = true
        } else {
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        }
        
        imageView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:)))
        tap.delegate = self
        
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }
    
    func tap(_ sender: UITapGestureRecognizer) {
        print("tap")
        //print("\(sender.view?.tag)")
        performSegue(withIdentifier: "ImageDetailViewController", sender: sender.view?.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ImageDetailViewController
        
        if let imageName = sender as? Int {
            vc.name = imageName
        }
    }
    


}

