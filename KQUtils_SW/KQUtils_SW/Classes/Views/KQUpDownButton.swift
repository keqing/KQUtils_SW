//
//  KQUpDownButton.swift
//  KQUtils_SW
//
//  Created by 柯青 on 2017/12/22.
//  Copyright © 2017年 KQ. All rights reserved.
//

import UIKit


private var space:CGFloat = 5
private var radioDefault:CGFloat = 4/6

class KQUpDownButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: - 重写方法
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: space, width: contentRect.width, height: contentRect.height * radioDefault)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: contentRect.height * radioDefault + space*2, width: contentRect.width, height: contentRect.height * (1 - radioDefault) - space*2)
    }
    
    
    //MARK: - 私有方法
    private func setupViews(){
        self.titleLabel?.textAlignment = NSTextAlignment.center
        
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }

    
}
