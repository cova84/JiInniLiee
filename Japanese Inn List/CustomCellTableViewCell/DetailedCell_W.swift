//
//  DetailedCell_W.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/12/02.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.
//

import UIKit
//import CoreGraphics

class ViewController: UIViewController {
    

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var background: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        func instantiateFromNib() -> DetailedCell_W {
            let nib = UINib(nibName: String(describing: self), bundle: nil)
            guard let cell = nib.instantiate(withOwner: nil, options: nil).first as? DetailedCell_W else {
                fatalError()
            }
            
            return cell
        }
        
        //textLabelデザイン-----------------------------------------
        textLabel?.font = UIFont(name: "Futura", size: 12)
        textLabel?.textColor = UIColor.black
        
        //Viewの背景、囲い線-----------------------------------------
        background.backgroundColor = UIColor(
              red: 46/255.0
            , green: 49/255.0
            , blue: 1/255.0
            , alpha: 1.0
            )
        background.layer.borderWidth = 2.0
        background.layer.borderColor = UIColor(
              red: 255/255.0
            , green: 255/255.0
            , blue: 255/255.0
            , alpha: 1.0
            ) as! CGColor
    }

}

