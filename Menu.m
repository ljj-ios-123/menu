//
//  Menu.m
//  PremiumService
//
//  Created by ZKR on 16/9/5.
//  Copyright © 2016年 ZKR. All rights reserved.
//

#import "Menu.h"
#import "MenuController.h"
#import "MyPresentationController.h"

@interface Menu()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
{
    BOOL contract;
    CGRect presentedViewRect;
    double animationInterval;
    UIViewController *Flagcontroller;
    UIButton *bgbtn;
}
@end
@implementation Menu
//MARK:--弹出菜单
-(void)menubtnClick:(UIViewController*)controller frame:( CGRect)frame{
    Flagcontroller = controller;
    presentedViewRect = frame;
    if (bgbtn == nil) {
        bgbtn = [[UIButton alloc]initWithFrame:controller.view.bounds];
        bgbtn.backgroundColor = [UIColor blackColor];
        bgbtn.alpha = 0.5;
     //   [bgbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [controller.view addSubview:bgbtn];
    }else{
    
        bgbtn.hidden = NO;
    
    }
   
    //弹出菜
    UIStoryboard *storayBoardMenu = [UIStoryboard storyboardWithName:@"MenuStoryboard" bundle:nil];
    
    MenuController*men = [storayBoardMenu instantiateInitialViewController];
    
    men.view.backgroundColor = [UIColor clearColor];
    //设置专场动画的代理
    men.transitioningDelegate = self;
    //设置专场的样式
    men.modalPresentationStyle = UIModalPresentationCustom;
    
    [controller presentViewController:men animated:YES completion:nil];
    
}
//MARK:--设置presentedViewRect
-(void)presentedViewFrame:(CGRect)frame {
    presentedViewRect = frame;
    
}
//MARK:--设置animationInterval
-(void)animationInterval:(double)interval{
    animationInterval = interval;
}

//代理
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    MyPresentationController *presentationC = [[MyPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    
   
    if (!presentationC.hasSet) {
       
        [presentationC presentedViewFrame:presentedViewRect];
    }
    
    return presentationC;

}
/*
 *自定义转场动画的自定义收缩效果就需要实现下面的两个方法
 *实现了下面两个函数之后，系统默认的收缩效果就会消失,所有的都需要程序员自己实现
 *实现下面的两个方法需要遵守协议
 
 */
//设置负责转场动画展开的对象
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

    
    //发送展开menu的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"homeNVTitleBtnClick" object:nil];
   
    
    return self;
}

 //设置负责转场动画收缩的对象
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //homeNVTitleBtnClickDismiss
[[NSNotificationCenter defaultCenter] postNotificationName:@"homeNVTitleBtnClickDismiss" object:nil];
     return self;
}

/*=======
 MARK:--UIViewControllerAnimatedTransitioning
 
 *设置具体的收缩效果
 ========
 */
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (animationInterval == 0.0){
        
        return 0.5;
        
    }else{
        
        return animationInterval;
        
    }


}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    if (!contract ){
        contract = true;
        
        //动画所需要的所有东西都要在transitionContext中
        //获取到要展现的视图
        UIView *toView;
       
     
            
            toView = [transitionContext viewForKey:UITransitionContextToViewKey];
            
          
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0);
            
            //设置toView的锚点（展开的开始坐标）,锚点默认（0.5，0.5）
            toView.layer.anchorPoint = CGPointMake(0.5, 0);
            //添加视图
            [[transitionContext containerView]addSubview:toView];
        
        
            //执行动画
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                toView.transform = CGAffineTransformIdentity;
            }completion:^(BOOL finished){
                //告诉系统动画执行完毕，否则运行时会出现未知错误
                [transitionContext completeTransition:YES];
            }];
            
        
            
    }else{//收缩
        
        contract = false;
        bgbtn.hidden = YES;
        UIView*fromView;
       //UITransitionContextFromViewKey
            fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            //执行动画
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                //执行动画
                fromView.transform = CGAffineTransformMakeScale(1.0, 0.000001);
                
            }completion:^(BOOL finished){
                
                //告诉系统动画执行完毕，否则运行时会出现未知错误
                [transitionContext completeTransition:YES];
            }];
        _cblock(YES);
             }
        
        
   
}

@end
