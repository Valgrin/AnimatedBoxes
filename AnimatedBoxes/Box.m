//
//  Box.m
//  AnimatedBoxes
//
//  Created by Thomas LEVY on 28/01/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import "Box.h"

@implementation Box

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [self randomColor];
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                                            action: @selector(recognizerDidTap:)];
        gestureRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer: gestureRecognizer];
    }
    return self;
}

#pragma mark - Private

- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue: hue saturation: saturation brightness: brightness alpha: 1];
}

#pragma mark - Actions

- (void)recognizerDidTap:(UITapGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector: @selector(didTapBox:)])
    {
        [self.delegate didTapBox: (Box *)recognizer.view];
    }
}

@end
