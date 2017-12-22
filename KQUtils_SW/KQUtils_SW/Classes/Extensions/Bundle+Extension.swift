//
//  Bundle+Extension.swift
//  KQUtils_SW
//
//  Created by 柯青 on 2017/12/21.
//  Copyright © 2017年 KQ. All rights reserved.
//

import UIKit



extension Bundle {
    
    //加入 framework 特性所带来的变化。一个显著区别就是当你的 pod 库以 framework 形式被使用时，你的资源不是被拷贝到 mainBundle 下，而是被放到 pod 的最终产物—— framework 里。此时，你必须保证自己在访问这个 framework 的 bundle，而不是 client target 的。
    
    /// 当前Bundle
    internal class func kq_current() -> Bundle {
        return Bundle.init(for: KQTextView.self)
    }
    
    /// 获取资源的URL
    ///
    /// - Parameters:
    ///   - name: 资源名称
    ///   - ext: 扩展名
    /// - Returns: URL
    public func kq_url(forResource name:String,ext:String) -> URL {
        return self.url(forResource: name, withExtension: ext) ?? URL(fileURLWithPath: name)
    }
    /// 获取资源的Path
    ///
    /// - Parameters:
    ///   - name: 资源名称
    ///   - ext: 扩展名
    /// - Returns: URL
     public func kq_path(forResource name:String,ext:String) -> String {
        return self.path(forResource: name, ofType: ext) ?? ""
    }
}
