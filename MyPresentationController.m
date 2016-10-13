//
//  MyPresentationController.m
//  PremiumService
//
//  Created by ZKR on 16/9/5.
//  Copyright © 2016年 ZKR. All rights reserved.
//

#import "MyPresentationController.h"
@interface MyPresentationController()

@property(nonatomic,assign)CGRect presentedViewRect;
@property(nonatomic,strong)UIView*markView;
@end
@implementation MyPresentationController
-(UIView *)markView{
    
    if (_markView == nil) {
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 200)];
        _markView.backgroundColor = [UIColor clearColor];
        _markView.userInteractionEnabled = true;
    
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        
        [_markView addGestureRecognizer:tapgesture];
    }
    
    return _markView;
    
}

-(void)presentedViewFrame:(CGRect)frame{

    _presentedViewRect = frame;
    _hasSet = YES;
}

-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    
    
    return [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
}


-(void)containerViewWillLayoutSubviews{
    
   
    if (!_hasSet){
        self.presentedView.frame = CGRectMake(0,100, SCREEN_W, 300);

        _hasSet = YES;
    }else{
        self.presentedView.frame = _presentedViewRect;
        //CGRectMake(0,100, SCREEN_W, 200);
      
        
    }

    //插入蒙版
    [self.containerView insertSubview:self.markView belowSubview:self.presentedView];
    

}
-(void)tapAction:(UITapGestureRecognizer*)gesture{
    
    [self.presentedViewController dismissViewControllerAnimated:true completion:nil];

    
        }
@end
