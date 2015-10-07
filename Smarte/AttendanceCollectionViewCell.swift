//
//  AttendanceCollectionViewCell.swift
//  Smarte
//
//  Created by Rakesh on 07/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import UIKit

class AttendanceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var attendlbl: UILabel!
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
