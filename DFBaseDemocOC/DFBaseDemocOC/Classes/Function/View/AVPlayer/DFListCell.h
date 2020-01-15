//
//  DFListCell.h
//  DFPlayViewDemo
//
//  Created by dff on 2019/12/23.
//  Copyright © 2019 dff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) DFVideoModel *model;

@end

NS_ASSUME_NONNULL_END
