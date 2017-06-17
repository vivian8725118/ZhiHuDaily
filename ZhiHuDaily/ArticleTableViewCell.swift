//
//  ArticleTableViewCell.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/10.
//  Copyright © 2017年 vivian. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var myTextLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.myImageView?.frame = CGRect(x: 10,y: 0,width: 120,height: 100)
        self.myImageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.myImageView?.clipsToBounds = true
//
//        self.myTextLabel?.frame = CGRect(x: 140,y: 0,width: self.frame.width-150,height: 100)
        self.myTextLabel.numberOfLines = 2
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    //监测方向变化
    func didChangeOrientation() {
//        if (UIDevice.current.orientation == .portrait) {
//            UIView.animate(withDuration: 0, animations: {
//                self.contentView.transform = .identity
//                self.contentView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//            })
//        } else {
//            UIView.animate(withDuration: 0, animations: {
//                //                self.view.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2));
//                self.contentView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
//            })
//        }
//        layoutSubviews()
    }
    
}
