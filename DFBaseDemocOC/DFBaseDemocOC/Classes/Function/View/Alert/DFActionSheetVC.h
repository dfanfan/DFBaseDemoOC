//
//  DFActionSheetVC.h
//  DFBaseDemocOC
//
//  Created by user on 16/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFActionSheetVC : UIViewController

/**功能：初始化对话框
 * @param dataArray 初始化标题数组
 * return DFActionSheetVC
 */
- (instancetype)initWithArray:(nullable NSArray<NSString *> *)dataArray;

@property (nonatomic, copy) void(^selectedBlock)(NSUInteger index);

@end

NS_ASSUME_NONNULL_END
