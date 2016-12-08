//
//  LActivityIndicatorView.h
//  LProgressHUD
//
//  Created by Lester on 16/8/12.
//  Copyright © 2016年 Lester. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 圆环线的宽度*/
#define RING_LINE_WIDTH 1
/** 转动速度*/
#define SPEED 5
/** 缩小多少间隔*/
#define LACTIVITY_ZOOM 10

typedef NS_ENUM(NSInteger, LActivityIndicatorViewStyle) {
    LActivityIndicatorViewStyleNone,
    LActivityIndicatorViewStyleIcon
};

@interface LActivityIndicatorView : UIView
/** 初始化加载指示器 */
-(instancetype)initWithFrame:(CGRect)frame IndicatorViewStyle:(LActivityIndicatorViewStyle)style;

/** 设置图标 在LActivityIndicatorViewStyleIcon下回起作用*/
@property (strong, nonatomic) UIImage *image;
/** 设置线条颜色*/
@property (strong, nonatomic) UIColor *color;

/** 启动动画*/
- (void)startAnimation;
/** 关闭动画*/
- (void)stopAnimation;


/** 重新回到前台*/
+ (void)applicationWillEnterForeground;

@end
