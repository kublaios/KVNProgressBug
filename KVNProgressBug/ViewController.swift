//
//  ViewController.swift
//  KVNProgressBug
//
//  Created by Kubilay Erdogan on 10/11/15.
//
//

import UIKit

class ViewController: UIViewController {
    
    let containerView = UIView.newAutoLayoutView()
    let topHalfView = UIView.newAutoLayoutView()
    let progressView = UIView.newAutoLayoutView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(self.containerView)
        self.containerView.addSubview(self.topHalfView)
        self.containerView.addSubview(self.progressView)
        
        // main container
        self.containerView.autoPinEdgesToSuperviewEdges()
        self.containerView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.45)
        // //
        
        // top half for 50% height
        self.topHalfView.autoPinEdgeToSuperviewEdge(.Top)
        self.topHalfView.autoPinEdgeToSuperviewEdge(.Left)
        self.topHalfView.autoPinEdgeToSuperviewEdge(.Right)
        self.topHalfView.autoMatchDimension(.Height, toDimension: .Height, ofView: self.progressView)
        self.topHalfView.autoPinEdge(.Bottom, toEdge: .Top, ofView: self.progressView)
        // //
        
        // progress view
        self.progressView.autoPinEdgeToSuperviewEdge(.Bottom)
        self.progressView.autoPinEdgeToSuperviewEdge(.Left)
        self.progressView.autoPinEdgeToSuperviewEdge(.Right)
        // //
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let titles = ["Working...","Still working...","Almost there..."]
        let kvnConf = self.getDefaultKVNConf()
        KVNProgress.setConfiguration(kvnConf)
        KVNProgress.showWithStatus("Loading...", onView: self.progressView)
        dispatch_after(0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            // guncellenmis versiyonlari indir
            for i in 0..<titles.count {
                let title = titles[i]
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    KVNProgress.updateStatus(title)
                })
                sleep(1)
            }
            dispatch_after(0, dispatch_get_main_queue(), { () -> Void in
                kvnConf.circleFillBackgroundColor = UIColor.whiteColor()
                KVNProgress.showSuccessWithStatus("Completed!", completion: {
                    self.containerView.backgroundColor = UIColor.clearColor()
                })
            })
        })
    }
    
    func getDefaultKVNConf() -> KVNProgressConfiguration {
        let kvnConf = KVNProgressConfiguration()
        kvnConf.fullScreen = true
        kvnConf.backgroundTintColor = UIColor.clearColor()
        kvnConf.circleStrokeForegroundColor = UIColor.whiteColor()
        kvnConf.backgroundFillColor = UIColor.whiteColor()
        kvnConf.circleStrokeBackgroundColor = UIColor.whiteColor()
        kvnConf.statusColor = UIColor.whiteColor()
        return kvnConf
    }
    
}

