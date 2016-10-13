//
//  Menu.h
//  PremiumService
//
//  Created by ZKR on 16/9/5.
//  Copyright © 2016年 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^contactBlock)(BOOL);
@interface Menu : NSObject
-(void)menubtnClick:(UIViewController*)controller frame:( CGRect)frame;
@property(nonatomic,copy)contactBlock cblock;
@end
