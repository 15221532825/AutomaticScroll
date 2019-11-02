//
//  AutoScrollView.swift
//  无限循环自动轮播
//
//  Created by 飞翔 on 2019/11/2.
//  Copyright © 2019 飞翔. All rights reserved.
//

import UIKit

class AutoScrollView: UIView,UIScrollViewDelegate{
    
    let imagesAry:[String]?
    
    var VIEW_WIDTH:CGFloat = 0
    var VIEW_HEIGHT:CGFloat = 0
    
    var  currentIndex = 0
    var  count = 0
    
    var timer:Timer?
    
    //MARK:-lazy
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView.init(frame: self.bounds)
        scrollView.delegate = self
        
        return scrollView;
    }();
    
    lazy var leftImageView:UIImageView = {
        
        let leftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.VIEW_WIDTH, height: self.VIEW_HEIGHT))
        leftImageView.image = UIImage.init(named:self.imagesAry![self.count-1])
        return leftImageView
    }()
    
    lazy var middleImageView:UIImageView = {
        let middleImageView = UIImageView.init(frame: CGRect.init(x:self.VIEW_WIDTH, y:0 , width:self.VIEW_WIDTH , height: self.VIEW_HEIGHT))
        middleImageView.image = UIImage.init(named: self.imagesAry![0])
        
        return middleImageView
    }()
    
    lazy var rightImageView:UIImageView = {
        
        let rightImageView  = UIImageView.init(frame: CGRect.init(x: self.VIEW_WIDTH * 2, y: 0, width: self.VIEW_WIDTH, height: self.VIEW_HEIGHT))
        rightImageView.image = UIImage.init(named: self.imagesAry![1])
        return rightImageView
        
    }()
    
    
    override init(frame: CGRect) {
        self.imagesAry = ["1","2","3","4","5"]
        super.init(frame: frame)
        self.VIEW_WIDTH = self.frame.size.width
        self.VIEW_HEIGHT = self.frame.size.height
        self.count = self.imagesAry!.count
        self.prepare()
        self.createTimer()
    }
    
    func prepare() {
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentSize = CGSize.init(width: 3*self.VIEW_WIDTH, height: 0)
        self.addSubview(self.scrollView)
        self.scrollView.setContentOffset(CGPoint.init(x: self.VIEW_WIDTH, y: 0), animated: true);
        
        self.scrollView.addSubview(self.leftImageView)
        self.scrollView.addSubview(self.middleImageView)
        self.scrollView.addSubview(self.rightImageView)
        
    }
    
    func createTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        
    }
    
    @objc  func timerAction() {
        
        scrollView.setContentOffset(.init(x: 2*VIEW_WIDTH, y: 0), animated: true)
    }
    
    //MARK:--private
    
    func restIamge() {
        
        if currentIndex==0 {
            self.leftImageView.image = UIImage.init(named:self.imagesAry![(count-1)%self.count])
        }else{
            self.leftImageView.image = UIImage.init(named:self.imagesAry![(currentIndex-1)%self.count])
        }
        
        self.middleImageView.image = UIImage.init(named: self.imagesAry![(currentIndex)%self.count])
        self.rightImageView.image = UIImage.init(named: self.imagesAry![(currentIndex+1)%self.count])
        self.scrollView.contentOffset = CGPoint.init(x: self.VIEW_WIDTH, y: 0)
    }
    
    func cancelTimer()  {
        
        timer!.invalidate()
        timer=nil
    }
    
    //MARK:--UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        ///计时器失效
        self.cancelTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        ///计时器生效
        self.createTimer()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset.x
        if (contentOffset==2*self.VIEW_WIDTH) {
            
            currentIndex+=1;
            self.restIamge()
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset.x
        
        if (contentOffset==2*self.VIEW_WIDTH) {
            
            currentIndex+=1;
            self.restIamge()
            
        }else if(contentOffset==0){
            ///向左边移动的时候
            if currentIndex==0 {
                currentIndex=count-1
                
            }else{
                currentIndex-=1;
            }
            self.restIamge()
        }
    }
    
    //MARK:--Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
