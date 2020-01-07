//
//  DFAlertTool.m
//  DFBaseDemocOC
//
//  Created by user on 16/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFAlertTool.h"
#import "DFActionSheetVC.h"

@implementation DFAlertTool

+ (void)alertTitle:(nullable NSString *)title
           message:(nullable NSString *)message
       cancelTitle:(nullable NSString *)cancelTitle
      confirmTitle:(nullable NSString *)confirmTitle
    viewController:(UIViewController *)vc
     cancelHandler:(nullable void(^)(UIAlertAction *cancelAction))cancelActionHandler
    confirmHandler:(nullable void(^)(UIAlertAction *confirmAction))confirmActionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:cancelActionHandler];
        [alertController addAction:cancelAction];
    }
    if (confirmTitle) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmActionHandler];
        [alertController addAction:confirmAction];
    }
    [vc presentViewController:alertController animated:YES completion:nil];
    
}


+ (void)actionSheetWithArray:(nullable NSArray<NSString *> *)dataArray
              viewController:(UIViewController *)vc
             selectedHandler:(void(^)(NSUInteger index))selectedHandler {
    
    DFActionSheetVC *actionSheetVC = [[DFActionSheetVC alloc] initWithArray:dataArray];
    actionSheetVC.modalPresentationStyle = UIModalPresentationCustom;
    [vc presentViewController:actionSheetVC animated:NO completion:nil];
    
    actionSheetVC.selectedBlock = ^(NSUInteger index) {
        selectedHandler(index);
    };
    
}


@end
