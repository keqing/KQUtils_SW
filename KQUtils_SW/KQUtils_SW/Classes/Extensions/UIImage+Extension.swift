//
//  UIImage+Extension.swift
//  KQUtils_SW
//
//  Created by 柯青 on 2017/12/21.
//  Copyright © 2017年 KQ. All rights reserved.
//

import UIKit

// MARK: - UIImage的扩展
extension UIImage {
    /// 通过颜色值来绘制UIimage
    ///
    /// - Parameter color: 颜色
    /// - Returns: UIImage
    public class func kq_image(with color:UIColor) -> UIImage{
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    
    /// 通过文本来绘制图片
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - textFont: 文本字体
    ///   - bgColor: 背景颜色
    ///   - size: size
    /// - Returns: 图片
    public class func kq_image(with text:String,textColor:UIColor = UIColor.white,textFont:UIFont = UIFont.systemFont(ofSize: 30),bgColor:UIColor = UIColor.clear,and size:CGSize) -> UIImage {
        //因为清晰度问题,要绘制原来4倍大小的面积
        let frame = CGRect(x: 0, y: 0, width: size.width * 2, height: size.height * 2)
        UIGraphicsBeginImageContext(frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        
       
        
        context!.setFillColor(bgColor.cgColor)
        context!.fill(frame)
        
        
        /// 因为清晰度问题，重新设置font
        let font:UIFont = UIFont(name: textFont.fontName, size: textFont.pointSize*2) ?? UIFont.systemFont(ofSize: textFont.pointSize*2)
        
        
        let dict = [NSAttributedStringKey.font:font,NSAttributedStringKey.foregroundColor:textColor]
        //计算文本内容的宽度
        let textSize:CGSize = (text as NSString).boundingRect(with: CGSize(width:frame.size.width - 16,height:CGFloat.greatestFiniteMagnitude) , options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dict, context: nil).size
        (text as NSString).draw(in: CGRect(x:floor(frame.size.width/2 - textSize.width/2),y:floor(frame.size.height/2 - textSize.height/2),width:floor(textSize.width*2) + 1,height:floor(textSize.height*2) + 1) , withAttributes: dict)
    
        let imgRef = context!.makeImage()
        let image = UIImage.init(cgImage: imgRef!, scale: 2.0, orientation: UIImageOrientation.up)
        UIGraphicsEndImageContext()
        return image
    }
}
