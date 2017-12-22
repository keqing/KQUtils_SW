//
//  UIColor+Extension.swift
//  KQUtils_SW
//
//  Created by 柯青 on 2017/12/20.
//  Copyright © 2017年 KQ. All rights reserved.
//

import UIKit

// MARK: - 颜色
extension UIColor {

    /// 颜色
    ///
    /// - Parameters:
    ///   - r: red Int类型 0-255
    ///   - g: green Int类型
    ///   - b: blue Int类型
    ///   - a: alpha CGFloat
    public convenience init(r:Int,g:Int,b:Int,a:CGFloat = 1.0) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
    }
    
    /// 颜色
    ///
    /// - Parameters:
    ///   - r: red Int类型 0-255
    ///   - g: green Int类型
    ///   - b: blue Int类型
    ///   - a: alpha CGFloat
    public class func kq_rgb(_ r:Int,_ g:Int,_ b:Int,a:CGFloat = 1.0) -> UIColor {
            return UIColor(r: r, g: g, b: b, a: a)
    }
    
    /// 颜色
    ///
    /// - Parameters:
    ///   - r: red CGFloat类型 0-255
    ///   - g: green CGFloat类型
    ///   - b: blue CGFloat类型
    ///   - a: alpha CGFloat
    public convenience init(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    /// 颜色
    ///
    /// - Parameters:
    ///   - r: red CGFloat类型 0-255
    ///   - g: green CGFloat类型
    ///   - b: blue CGFloat类型
    ///   - a: alpha CGFloat
    public class func kq_rgb(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,a:CGFloat = 1.0) -> UIColor {
        return UIColor(r: r, g: g, b: b, a: a)
    }
    
    /// 颜色
    ///
    /// - Parameters:
    ///   - r: red Float类型 0-255
    ///   - g: green Float类型
    ///   - b: blue Float类型
    ///   - a: alpha Float
    public convenience init(r:Float,g:Float,b:Float,a:Float = 1.0) {
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: CGFloat(a))
    }
    
    /// 颜色
    ///
    /// - Parameters:
    ///   - r: red Float类型 0-255
    ///   - g: green Float类型
    ///   - b: blue Float类型
    ///   - a: alpha Float
    public class func kq_rgb(_ r:Float,_ g:Float,_ b:Float,a:Float = 1.0) -> UIColor {
        return UIColor(r: r, g: g, b: b, a: a)
    }
    /// 颜色
    ///
    /// - Parameter rgbValue: 十六进制的值 （0x000000 - 0xffffff）
    public convenience init(hex rgbValue:Int,alpha:CGFloat = 1.0){
        let r = ((rgbValue & 0xff0000) >> 16)
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue * 0xff
        self.init(r: r, g: g, b: b,a:alpha)
    }
    
    /// 颜色
    ///
    /// - Parameter rgbValue: 十六进制的值 （0x000000 - 0xffffff）
    public class func kq_hexRGB(_ value:Int,alpha:CGFloat = 1.0) -> UIColor {
        return UIColor(hex: value, alpha: alpha)
    }
    
    
    
    /// 通过16进制的字符串得到颜色
    ///
    /// - Parameters:
    ///   - rgbValue: rgb字符串
    ///   - alpha: 透明度
    public convenience init(rgbValue:String,alpha:CGFloat = 1.0){
        var r:UInt32 = 0
        var g:UInt32 = 0
        var b:UInt32 = 0
        
        var cStr:String = rgbValue.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()

        //字符串长度必须是6到8位
        if (cStr.count >= 6) {
            //判断前缀
            if cStr.hasPrefix("0X") {
                //swift4.0新特性 语法糖
                let startIndex = cStr.index(cStr.startIndex, offsetBy: 2)
//                cStr = String(cStr[startIndex..<cStr.endIndex]) //swift 3.0
                cStr = String(cStr[startIndex...]) //swift 4.0
            }else if cStr.hasPrefix("#") {
                let startIndex = cStr.index(cStr.startIndex, offsetBy: 1)
                cStr = String(cStr[startIndex...])
            }
            //提取之后 长度必须为6
            if cStr.count == 6 {
                
                //从六位数值中找到RGB对应的位数并转换
                var startIndex = cStr.startIndex
                var endIndex = cStr.index(startIndex, offsetBy: 2)
                
                //红色
                let redStr = String(cStr[startIndex..<endIndex])
                
                startIndex = endIndex
                endIndex = cStr.index(startIndex, offsetBy: 2)
                //绿色
                let greenStr = String(cStr[startIndex..<endIndex])
                
                //蓝色
                let blueStr = String(cStr[endIndex...])
       
                //数值转换
                Scanner(string: redStr).scanHexInt32(&r)
                Scanner(string: greenStr).scanHexInt32(&g)
                Scanner(string: blueStr).scanHexInt32(&b)
            }
            
        }
        
        self.init(r: Int(r), g: Int(g), b: Int(b), a: alpha)
    }
    
    /// 通过16进制的字符串得到颜色
    ///
    /// - Parameters:
    ///   - rgbValue: rgb字符串
    ///   - alpha: 透明度
    public class func kq_hexRGB(_ valueStr:String,alpha:CGFloat = 1.0) -> UIColor {
        return UIColor(rgbValue: valueStr, alpha: alpha)
    }
}
