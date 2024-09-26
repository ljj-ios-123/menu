//
//  MyPresentationController.h
//  PremiumService
//
//  Created by ZKR on 16/9/5.
//  Copyright © 2016年 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPresentationController : UIPresentationController
@property(nonatomic,assign)BOOL hasSet;
-(void)presentedViewFrame:(CGRect)frame;
@end
