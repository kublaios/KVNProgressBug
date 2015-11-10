//
//  ViewController.swift
//  KVNProgressBug
//
//  Created by Kubilay Erdogan on 10/11/15.
//
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let titles = ["Working...","Still working...","Almost there..."]
        let kvnConf = self.getDefaultKVNConf()
        KVNProgress.setConfiguration(kvnConf)
        KVNProgress.showWithStatus("Loading...")
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
                KVNProgress.showSuccessWithStatus("Completed!")
            })
        })
    }

    func getDefaultKVNConf() -> KVNProgressConfiguration {
        let kvnConf = KVNProgressConfiguration()
        kvnConf.fullScreen = true
        kvnConf.backgroundTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.45)
        kvnConf.circleStrokeForegroundColor = UIColor.whiteColor()
        kvnConf.backgroundFillColor = UIColor.whiteColor()
        kvnConf.circleStrokeBackgroundColor = UIColor.whiteColor()
        kvnConf.statusColor = UIColor.whiteColor()
        return kvnConf
    }

}

