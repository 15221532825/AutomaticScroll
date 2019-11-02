//
//  ViewController.swift
//  无限循环自动轮播
//
//  Created by 飞翔 on 2019/11/2.
//  Copyright © 2019 飞翔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    lazy var autoScrollView : AutoScrollView = {
        
        let scrollView = AutoScrollView.init(frame: CGRect.init(x: 0, y:200, width: self.view.frame.size.width, height:300))
        return scrollView
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.autoScrollView);
    }
}


