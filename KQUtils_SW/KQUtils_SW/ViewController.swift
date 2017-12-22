//
//  ViewController.swift
//  KQUtils_SW
//
//  Created by 柯青 on 2017/12/20.
//  Copyright © 2017年 CS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let img = UIImage.kq_image(with: "张三", textColor: UIColor.kq_hexRGB("0x67ffdc"), textFont: UIFont.boldSystemFont(ofSize:  20), bgColor: UIColor.red, and: self.imgView.frame.size)
        self.imgView.image = img
        
        self.imgView.kq_cornerRadius = self.imgView.kq_height/2
        

 
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

