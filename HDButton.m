//
//  HDButton.m
//  HDButton
//
//  Created by haidong on 2017/4/27.
//  Copyright © 2017年 loghdst. All rights reserved.
//

#import "HDButton.h"

@interface HDButton ()
{
    NSMutableDictionary *backgroundStates;
}

@end

@implementation HDButton

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.adjustsImageWhenHighlighted = NO;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.imageTextDistance = 5.f;
    self.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentRight;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    if (backgroundStates == nil) {
        backgroundStates = [NSMutableDictionary dictionary];
    }
    [backgroundStates setObject:backgroundColor forKey:[NSNumber numberWithInt:state]];
    
    if (state == UIControlStateNormal)
    {
        [self setBackgroundColor:backgroundColor];
    }
}

- (UIColor *)backgroundColorForState:(UIControlState)state
{
    return [backgroundStates objectForKey:[NSNumber numberWithInt:state]];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    UIColor *color = [backgroundStates objectForKey:[NSNumber numberWithInt:selected ? UIControlStateSelected : UIControlStateNormal]];
    if (color) {
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.layer addAnimation:animation forKey:@"EaseOut"];
        self.backgroundColor = color;
    }
}

- (void)setImageTextDistance:(CGFloat)imageTextDistance {
    _imageTextDistance = imageTextDistance;
    [self alignmentValueChanged];
}

- (void)setButtonTitleWithImageAlignment:(UIButtonTitleWithImageAlignment)buttonTitleWithImageAlignment {
    _buttonTitleWithImageAlignment = buttonTitleWithImageAlignment;
    [self alignmentValueChanged];
}

- (void)alignmentValueChanged {
    if (self.imageView.image != nil && self.titleLabel.text != nil) {
        CGFloat imgWidth = self.imageView.image.size.width;
        CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        CGFloat textWidth = textSize.width;
        
        if (_buttonTitleWithImageAlignment == UIButtonTitleWithImageAlignmentTop) {
            CGSize imageSize = self.imageView.frame.size;
            CGSize titleSize = self.titleLabel.frame.size;
            CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
            CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
            if (titleSize.width + 0.5 < frameSize.width) {
                titleSize.width = frameSize.width;
            }
            CGFloat totalHeight = (imageSize.height + titleSize.height + _imageTextDistance);
            self.imageEdgeInsets = UIEdgeInsetsMake(totalHeight - imageSize.height, 0, 0, -titleSize.width);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, totalHeight - titleSize.height, 0);
            
        } else if (_buttonTitleWithImageAlignment == UIButtonTitleWithImageAlignmentLeft) {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imgWidth + _imageTextDistance), 0, _imageTextDistance)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, textWidth, 0, -(textWidth + _imageTextDistance))];
            
        } else if (_buttonTitleWithImageAlignment == UIButtonTitleWithImageAlignmentBottom) {
            CGSize imageSize = self.imageView.frame.size;
            CGSize titleSize = self.titleLabel.frame.size;
            CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
            CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
            if (titleSize.width + 0.5 < frameSize.width) {
                titleSize.width = frameSize.width;
            }
            CGFloat totalHeight = (imageSize.height + titleSize.height + _imageTextDistance);
            self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0, 0, -titleSize.width);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight - titleSize.height), 0);
            
        } else if (_buttonTitleWithImageAlignment == UIButtonTitleWithImageAlignmentRight) {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -_imageTextDistance)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -_imageTextDistance, 0, 0)];
        }
    }
}

@end
