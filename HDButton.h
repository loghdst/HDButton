//
//  HDButton.h
//  HDButton
//
//  Created by haidong on 2017/4/27.
//  Copyright © 2017年 loghdst. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonTitleWithImageAlignment) {
    UIButtonTitleWithImageAlignmentTop = 0,
    UIButtonTitleWithImageAlignmentLeft,
    UIButtonTitleWithImageAlignmentBottom,
    UIButtonTitleWithImageAlignmentRight
};

@interface HDButton : UIButton

/*
 * 位置调整
 */
@property (nonatomic) IBInspectable CGFloat imageTextDistance;

@property (nonatomic, assign) UIButtonTitleWithImageAlignment buttonTitleWithImageAlignment;

- (void)setButtonTitleWithImageAlignment:(UIButtonTitleWithImageAlignment)buttonTitleWithImageAlignment;

/*
 * 设置状态背景色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (UIColor *)backgroundColorForState:(UIControlState)state;

@end
