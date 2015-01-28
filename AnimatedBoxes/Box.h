//
//  Box.h
//  AnimatedBoxes
//
//  Created by Thomas LEVY on 28/01/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Box;

@protocol BoxDelegate <NSObject>

@optional
- (void)didTapBox:(Box *)box;

@end

@interface Box : UIView

@property (nonatomic, weak) id<BoxDelegate> delegate;

@end
