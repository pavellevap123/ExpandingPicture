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
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
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
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetheight = scrollView.contentOffset.y
        
        if contentOffsetheight < 0 {
            contentViewTopAnchor.constant = contentOffsetheight
            headerViewHeightAnchor.constant = (270 - view.safeAreaInsets.top) + (-contentOffsetheight)
        }
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: headerViewHeightAnchor.constant, left: 0, bottom: 0, right: 0)
    }
}
