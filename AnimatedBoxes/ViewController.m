//
//  ViewController.m
//  AnimatedBoxes
//
//  Created by Thomas LEVY on 28/01/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import "ViewController.h"

static NSUInteger const kNumberOfBoxes = 10;
static CGFloat const kBoxSide = 100;
static CGFloat const kBoxMargin = 10;
static NSTimeInterval const kAnimationDuration = 1;

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *boxesArray;
@property (nonatomic, strong) NSArray *colorArray;

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    [self internalInit];
    for (int i = 0; i < kNumberOfBoxes; ++i)
    {
        UIView *box = [[UIView alloc] initWithFrame: CGRectZero];
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didTapView:)];
        gestureRecognizer.cancelsTouchesInView = NO;
        [box addGestureRecognizer: gestureRecognizer];
        int randomColor = arc4random() % [self.colorArray count];
        box.backgroundColor = self.colorArray[randomColor];
        [self.boxesArray addObject: box];
        [self.view addSubview: box];
    }
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
                                              animations:^{
                                                  box.alpha = 1;
                                              }];
                         }
                     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)internalInit
{
    self.boxesArray = [[NSMutableArray alloc] initWithCapacity: kNumberOfBoxes];
    self.colorArray = @[[UIColor redColor],
                        [UIColor blackColor],
                        [UIColor redColor],
                        [UIColor greenColor],
                        [UIColor yellowColor],
                        [UIColor purpleColor],
                        [UIColor blueColor]];
}

- (void)didTapView:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"View %@", recognizer.view);
    [self.boxesArray removeObject: recognizer.view];
    [UIView animateWithDuration: kAnimationDuration
                     animations: ^{
                         recognizer.view.alpha = 0;
                     }
                     completion: ^(BOOL finished) {
                         [self.boxesArray addObject: recognizer.view];
                         [self.view setNeedsLayout];
                     }];
}

@end
