//
//  LActivityTool.h
//  LProgressHUD
//
//  Created by Lester on 16/8/15.
//  Copyright © 2016年 Lester. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"
#import "LTransitionView.h"

typedef void (^MBProgressHUDManagerCompletionBlock)();

@interface LActivityTool : NSObject <MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *HUD;
@property (strong, nonatomic) LTransitionView *transitionView;
@property (nonatomic, weak) UIView *baseView;
@property (copy) MBProgressHUDCompletionBlock completionBlock;

- (id)initWithView:(UIView *)view;

- (void)showMessage:(NSString *)message;
- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion;

- (void)showIndeterminateWithMessage:(NSString *)message;
- (void)showIndeterminateWithMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showIndeterminateWithMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion;

- (void)showSuccessWithMessage:(NSString *)message;
- (void)showSuccessWithMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showSuccessWithMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion;

- (void)showErrorWithMessage:(NSString *)message;
- (void)showErrorWithMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showErrorWithMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion;

- (void)showMessage:(NSString *)message customView:(UIView *)customView;
- (void)showMessage:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration;
- (void)showMessage:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion;

- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode;
- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration;
- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion;

- (void)showPullIndicatorView;
- (void)showPullIndicatorViewDuration:(NSTimeInterval)duration;
- (void)showPullIndicatorViewDuration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion;

- (void)showProgress:(float)progress;

- (void)hidePullIndictorView;

- (void)hide;
- (void)hideWithAfterDuration:(NSTimeInterval)duration completion:(MBProgressHUDCompletionBlock)completion;

@end
