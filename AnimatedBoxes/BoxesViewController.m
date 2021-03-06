//
//  ViewController.m
//  AnimatedBoxes
//
//  Created by Thomas LEVY on 28/01/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import "BoxesViewController.h"
#import "Box.h"

// Change number of boxes here
static CGFloat const kBoxSide = 100;
static CGFloat const kBoxMargin = 10;
static NSTimeInterval const kAnimationDuration = 1;

@interface BoxesViewController () <BoxDelegate>

@property (nonatomic, strong) NSMutableArray *boxesArray;

@end

@implementation BoxesViewController

- (void)loadView
{
    [super loadView];
    for (int i = 0; i < self.numberOfBoxes; ++i)
    {
        Box *box = [[Box alloc] init];
        box.delegate = self;
        [self.boxesArray addObject: box];
        [self.view addSubview: box];
    }
    [self.navigationController setNavigationBarHidden: NO];
    self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat: @"%lu boxes", self.numberOfBoxes];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [UIView animateWithDuration: kAnimationDuration
                     animations:
     ^{
         int xBox = 0;
         int yBox = 0;
         for (UIView *box in self.boxesArray)
         {
             box.frame = CGRectMake(xBox + kBoxMargin, yBox + kBoxMargin, kBoxSide, kBoxSide);
             CGFloat leftOfBox = box.frame.origin.x + box.frame.size.width;
             if (self.view.frame.size.width - leftOfBox > kBoxSide + (kBoxMargin * 2))
             {
                 xBox += kBoxSide + kBoxMargin;
             }
             else
             {
                 xBox = 0;
                 yBox += kBoxSide + kBoxMargin;
             }
         }
     }
                     completion: ^(BOOL finished) {
                         for (UIView *box in self.boxesArray)
                         {
                             [UIView animateWithDuration: kAnimationDuration
                                              animations: ^{
                                                  box.alpha = 1;
                                              }];
                         }
                     }];
}

#pragma mark - Accessors

- (NSMutableArray *)boxesArray
{
    if (_boxesArray == nil)
    {
        _boxesArray = [[NSMutableArray alloc] initWithCapacity: self.numberOfBoxes];
    }
    return _boxesArray;
}

#pragma mark - BoxDelegate

- (void)didTapBox:(Box *)box
{
    [self.boxesArray removeObject: box];
    [UIView animateWithDuration: kAnimationDuration
                     animations: ^{
                         box.alpha = 0;
                     }
                     completion: ^(BOOL finished) {
                         [self.boxesArray addObject: box];
                         [self.view setNeedsLayout];
                     }];
    
}

@end
