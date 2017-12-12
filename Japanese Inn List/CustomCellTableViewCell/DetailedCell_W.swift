//
//  DetailedCell_W.swift
//  Japanese Inn List
//
//  Created by 小林由知 on 2017/12/02.
//  Copyright © 2017年 Yoshitomo Kobatashi. All rights reserved.
//

import UIKit
//import CoreGraphics

class DetailedCell_W: UITableViewCell {

    @IBOutlet weak var textLabeDetCell_W: UILabel!
    @IBOutlet weak var background: UIView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
        override func awakeFromNib() {
        super.awakeFromNib()
            
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
        background.layer.borderColor = (UIColor(
            red: 255/255.0
            , green: 255/255.0
            , blue: 255/255.0
            , alpha: 1.0
            ) as! CGColor)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

