//
//  KQTextView.swift
//  KQUtils_SW
//
//  Created by 柯青 on 2017/12/21.
//  Copyright © 2017年 KQ. All rights reserved.
//

import UIKit

class KQTextView : UITextView {


    //MARK: - 属性
    fileprivate lazy var placeholderLabel:UILabel = {
        let label:UILabel = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.lightGray
        label.font = self.font
        return label
    }()
    
    /// 占位提示字符串
    var placeholder:String? {
        didSet{
            self.placeholderLabel.text = placeholder
            //重新计算控件的frame
            self.setNeedsLayout()
        }
    }
    /// 占位提示字符串的颜色
    var placeholderColor:UIColor?{
        didSet{
            self.placeholderLabel.textColor = placeholderColor
        }
    }
    
    override var text: String!{
        get{
            return super.text
        }
        set{
            super.text = newValue
            
            self.textViewChange()
        }
    }
    
    override var font: UIFont?{
        get{
            return super.font
        }
        set{
            super.font = newValue
            
            self.placeholderLabel.font = newValue
            //重新计算控件的frame
            self.setNeedsLayout()
        }
    }
    
    
    
    
    //MAKR: - 重写方法
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = self.placeholderLabel.sizeThatFits(CGSize(width: self.kq_width - 2*5, height: CGFloat.greatestFiniteMagnitude))
        self.placeholderLabel.frame = CGRect(x: 5, y: 8, width: size.width, height: size.height)
    }
   

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension KQTextView {
    
    fileprivate func setupViews(){
        //1.添加label到self上
        self.addSubview(self.placeholderLabel)
        
        //2.添加内容输入的监听
        NotificationCenter.default.addObserver(self, selector: #selector(textViewChange), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    @objc fileprivate func textViewChange(){
        self.placeholderLabel.isHidden = self.text.count > 0 ? true : false
    }
}
