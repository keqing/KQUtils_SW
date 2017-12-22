//
//  String+Extension.swift
//  KQUtils_SW
//
//  Created by 柯青 on 2017/12/21.
//  Copyright © 2017年 KQ. All rights reserved.
//

import UIKit


extension String {
    /// md5
   public var kq_md5:String {
        guard let str = self.cString(using: String.Encoding.utf8) else {
            return self
        }
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
    
    /// 网络字符串格式化
    public var kq_encodingUrlQuery:String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? self
    }
    
    /// 将内容替换到自定文件里面
    ///
    /// - Parameters:
    ///   - content: 替换的内容
    ///   - fileName: 指定的文件
    ///   - ext: 文件扩展名
    /// - Returns: 替换好的文件内容
    private static func kq_replace(with content:String,fileName:String,ext:String = "txt") -> String {
        let bundle = Bundle(path: Bundle.kq_current().kq_path(forResource: "Resource", ext: "bundle")) ?? Bundle.kq_current()
        
        let pathUrl = bundle.kq_url(forResource: fileName, ext: ext)
        
        guard let data = try? Data.init(contentsOf: pathUrl) else {
            return ""
        }
        var formatStr = String(data: data, encoding: String.Encoding.utf8) ?? ""
        formatStr = formatStr.replacingOccurrences(of: "xxxxxxxxxxxxxxxxxx", with: content)
        return formatStr
    }
    
    
    /// 格式化html文本内容
    ///
    /// - Parameter content: html的内容
    /// - Returns: 格式化之后的内容（包裹一层格式）
    public static func kq_formatHtml(with content:String) ->String {
        return String.kq_replace(with: content, fileName: "htmlFormatter")
    }
    
    /// 格式化Image图片内容
    ///
    /// - Parameter content: 图片URL
    /// - Returns: 格式化之后的内容（包裹一层格式）
    public static func kq_formatImage(with content:String) -> String {
        return String.kq_replace(with: content, fileName: "ImageFormatter")
    }
}


// MARK: - 字符串的验证
extension String {
    /// 手机号码的验证
    var kq_checkPhone:Bool {
        if self.count != 11 {
            return false
        }
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$"
        let regextes:NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", mobile)
        
        return regextes.evaluate(with:self)
    }
    
    /// 验证身份证
    var kq_checkCardID:Bool{
        if self.count != 18 {
            return false
        }
        let codeArray = ["7","9","10","5","8","4","2","1","6","3","7","9","10","5","8","4","2"]
        let checkCodeDic = ["0":"1","1":"0","2":"X","3":"9","4":"8","5":"7","6":"6","7":"5","8":"4","9":"3","10":"2"]
        let scan = Scanner(string:String(self[..<self.index(self.endIndex, offsetBy:-2)]))
        
        var val:Int32 = 0
        let isNum = scan.scanInt32(&val) && scan.isAtEnd
        if !isNum {
            return false
        }
        var sumValue:Int = 0
        for i in 0..<17 {
            let sIndex = self.index(startIndex, offsetBy: i)
            let eIndex = self.index(startIndex, offsetBy: i+1)

            let num = String(self[sIndex..<eIndex])
            
            sumValue += (Int(String(num)) ?? 0) * (Int(codeArray[i]) ?? 0)
        }
        
        let obj = checkCodeDic["\(sumValue%11)"]
        if obj == nil {
            return false
        }else {
            if obj == String(self[self.index(startIndex, offsetBy: 17)...]).uppercased() {
                return true
            }
        }
        return false
    }

    

}
