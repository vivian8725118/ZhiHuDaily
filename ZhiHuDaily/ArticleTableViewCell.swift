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
        
//        self.myTextLabel?.frame = CGRect(x: 140,y: 0,width: self.frame.width-150,height: 100)
        self.myTextLabel.numberOfLines = 2
    }
}
