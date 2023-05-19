//
//  ViewController.swift
//  ExpandingPicture
//
//  Created by Pavel Paddubotski on 19.05.23.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var contentViewTopAnchor: NSLayoutConstraint!
    var headerViewHeightAnchor: NSLayoutConstraint!
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "picture")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 1.7)
    }
    
    func setupView(){
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.contentSize = CGSize(width: DeviceSize.width,
                                              height: DeviceSize.height*2)
        
        //setup the content view
        scrollView.addSubview(contentView)
        contentView.anchorView(left: scrollView.leftAnchor,
                               width: scrollView.contentSize.width,
                               height: scrollView.contentSize.height)
        //setup content view top anchor
        contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0)
        //activate it
        contentViewTopAnchor.isActive = true
        
        //setup the header view
        contentView.addSubview(imageView)
        imageView.anchorView(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              right: contentView.rightAnchor)
        //setup header view height anchor
        headerViewHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: 270)
        //activate it
        headerViewHeightAnchor.isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // get the content offset for y-axis
        let contentOffsetheight = scrollView.contentOffset.y
        
        //if the value is negative
        if contentOffsetheight < 0 {
            //change the anchors
            contentViewTopAnchor.constant   = contentOffsetheight
            headerViewHeightAnchor.constant = 270 + (-contentOffsetheight)
        }
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: headerViewHeightAnchor.constant - 60, left: 0, bottom: 0, right: 0)
    }
}

// Reference Video: https://youtu.be/iqpAP7s3b-8
struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}


let DeviceSize = UIScreen.main.bounds.size
extension UIView{
    
    func anchor (top : NSLayoutYAxisAnchor? , left: NSLayoutXAxisAnchor? , bottom : NSLayoutYAxisAnchor? , right : NSLayoutXAxisAnchor? , paddingTop : CGFloat , paddingLeft : CGFloat , paddingBottom : CGFloat , paddingRight : CGFloat , width : CGFloat , height : CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top , constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left , constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom , constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right , constant: -paddingRight).isActive = true
        }
        if  width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchorView(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let lefts = leftAnchor {
            anchorView(left: lefts, paddingLeft: paddingLeft)
        }
    }
    
    public var width: CGFloat{
        return frame.size.width
    }
    public var height: CGFloat{
           return frame.size.height
       }
    public var top: CGFloat{
        return frame.origin.y
       }
    public var bottom: CGFloat{
        return frame.origin.y + frame.size.height
       }
    public var left: CGFloat{
        return frame.origin.x
       }
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}

