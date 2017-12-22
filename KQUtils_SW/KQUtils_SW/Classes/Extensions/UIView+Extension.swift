//
//  UIView+Extension.swift
//  KQUtils_SW
//
//  Created by 柯青 on 2017/12/20.
//  Copyright © 2017年 KQ. All rights reserved.
//

import UIKit

// MARK: - Frame
extension UIView {

    /// view的x坐标
    public var kq_x:CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            self.frame.origin.x = newValue
        }
    }
    
    /// view的y坐标
    public var kq_y:CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    
    /// view的width
    public var kq_width:CGFloat {
        get{
            return self.frame.size.width
        }
        set{
            self.frame.size.width = newValue
        }
    }
    
    /// view的height
    public var kq_height:CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            self.frame.size.height = newValue
        }
    }

    /// view的size
    public var kq_size:CGSize{
        get{
            return self.frame.size
        }
        set{
            self.frame.size = newValue
        }
    }
    
    /// view的origin
    public var kq_origin:CGPoint {
        get{
            return self.frame.origin
        }
        set{
            self.frame.origin = newValue
        }
    }
    
    /// view的maxX
    public var kq_maxX:CGFloat {
        get{
            return self.frame.maxX
        }
    }
    
    /// view的maxY
    public var kq_maxY:CGFloat {
        get{
            return self.frame.maxY
        }
    }
}


// MARK: - 边框、圆角
extension UIView {
    /// view的圆角
    public var kq_cornerRadius:CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    /// view的边框
    public var kq_borderWidth:CGFloat {
        get{
            return self.layer.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
        }
    }
    
    /// view的边框颜色
    public var kq_borderColor:UIColor {
        get{
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.black.cgColor)
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
}
