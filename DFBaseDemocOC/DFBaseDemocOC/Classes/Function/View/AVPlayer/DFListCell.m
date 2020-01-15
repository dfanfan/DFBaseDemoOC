//
//  DFListCell.m
//  DFPlayViewDemo
//
//  Created by dff on 2019/12/23.
//  Copyright © 2019 dff. All rights reserved.
//

#import "DFListCell.h"

@implementation DFListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(DFVideoModel *)model {
    _model = model;
    
    self.coverIV.image = [UIImage imageNamed:model.coverUrl];
    self.nameLabel.text = model.name;
}

@end
