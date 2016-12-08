//
//  LTransitionView.m
//  LProgressHUD
//
//  Created by Lester on 16/8/13.
//  Copyright © 2016年 Lester. All rights reserved.
//

#import "LTransitionView.h"
#import "LActivityIndicatorView.h"
@interface LTransitionView(){
    /** 指示器的Frame*/
    CGRect iFrame;
}
@property (strong, nonatomic) LActivityIndicatorView *indicatorView;
@end

@implementation LTransitionView

- (instancetype)initWithIndicatorFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        iFrame = frame;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)showInView:(UIView *)view{
    [self setNeedsDisplay];
    self.frame = view.bounds;
    [view addSubview:self];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self addSubview:self.indicatorView];
}
- (void)dismissAnimation:(BOOL)animation{
    if(animation){
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else{
        [self removeFromSuperview];
    }
}

#pragma mark - 懒加载
- (LActivityIndicatorView *)indicatorView{
    if(!_indicatorView){
        _indicatorView = [[LActivityIndicatorView alloc]initWithFrame:iFrame IndicatorViewStyle:LActivityIndicatorViewStyleIcon];
        _indicatorView.image = [UIImage imageNamed:@"Applogo_opacity20_light.png"];
        [_indicatorView startAnimation];
    }
    return _indicatorView;
}
@end
