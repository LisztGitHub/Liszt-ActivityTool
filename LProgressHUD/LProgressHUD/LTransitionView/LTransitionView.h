//
//  LTransitionView.h
//  LProgressHUD
//
//  Created by Lester on 16/8/13.
//  Copyright © 2016年 Lester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTransitionView : UIView
/** 初始化 注意:frame只是活动指示器的Frame*/
- (instancetype)initWithIndicatorFrame:(CGRect)frame;
/** 添加在哪一个View*/
- (void)showInView:(UIView *)view;

/** 退出*/
- (void)dismissAnimation:(BOOL)animation;
@end
