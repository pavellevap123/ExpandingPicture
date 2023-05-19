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
    var blurViewHeightAnchor: NSLayoutConstraint!
    
    let blurEffectView = BlurEffectView()
    
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
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 1.7)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupView(){
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2)
        
        scrollView.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: scrollView.contentSize.width).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height).isActive = true

        contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor)
        contentViewTopAnchor.isActive = true
        
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        headerViewHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: 270)
        headerViewHeightAnchor.isActive = true
        
        imageView.addSubview(blurEffectView)
        blurEffectView.contentView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        blurEffectView.contentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        blurEffectView.contentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        blurViewHeightAnchor = blurEffectView.contentView.heightAnchor.constraint(equalToConstant: 270)
        blurViewHeightAnchor.isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetheight = scrollView.contentOffset.y
        
        if contentOffsetheight < 0 {
            contentViewTopAnchor.constant = contentOffsetheight
            headerViewHeightAnchor.constant = (270 - view.safeAreaInsets.top) + (-contentOffsetheight)
            blurViewHeightAnchor.constant = (270 - view.safeAreaInsets.top) + (-contentOffsetheight)
            calculateBlurIntensity(contentOffsetheight)
        }
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: headerViewHeightAnchor.constant, left: 0, bottom: 0, right: 0)
    }
    
    private func calculateBlurIntensity(_ offset: CGFloat) {
        switch abs(Int32(offset)) {
        case  0 ... 75:
            blurEffectView.animator.fractionComplete = 0
        case 75 ... 90:
            blurEffectView.animator.fractionComplete = 0.03
        case 90 ... 105:
            blurEffectView.animator.fractionComplete = 0.06
        case 105 ... 120:
            blurEffectView.animator.fractionComplete = 0.09
        case 120 ... 135:
            blurEffectView.animator.fractionComplete = 0.12
        case 135 ... 150:
            blurEffectView.animator.fractionComplete = 0.15
        case 150 ... 165:
            blurEffectView.animator.fractionComplete = 0.18
        case 165 ... 180:
            blurEffectView.animator.fractionComplete = 0.21
        case 180 ... 195:
            blurEffectView.animator.fractionComplete = 0.24
        case 195 ... 210:
            blurEffectView.animator.fractionComplete = 0.27
        case 210 ... 225:
            blurEffectView.animator.fractionComplete = 0.3
        case 225 ... 240:
            blurEffectView.animator.fractionComplete = 0.33
        case 240 ... 265:
            blurEffectView.animator.fractionComplete = 0.36
        case 265 ... 280:
            blurEffectView.animator.fractionComplete = 0.39
        case 280 ... 295:
            blurEffectView.animator.fractionComplete = 0.42
        case 295 ... 310:
            blurEffectView.animator.fractionComplete = 0.45
        case 310 ... 325:
            blurEffectView.animator.fractionComplete = 0.48
        case 325 ... 500:
            blurEffectView.animator.fractionComplete = 0.51
        default:
            blurEffectView.animator.fractionComplete = 0
        }
    }
}

class BlurEffectView: UIVisualEffectView {
    
    var animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        backgroundColor = .clear
        frame = superview.bounds //Or setup constraints instead
        setupBlur()
    }
    
    private func setupBlur() {
        animator.stopAnimation(true)
        effect = nil

        animator.addAnimations { [weak self] in
            self?.effect = UIBlurEffect(style: .light)
        }
        animator.fractionComplete = 0
    }
    
    deinit {
        animator.stopAnimation(true)
    }
}
