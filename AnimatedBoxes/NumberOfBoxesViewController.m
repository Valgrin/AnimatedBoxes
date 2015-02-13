//
//  NumberOfBoxesViewController.m
//  AnimatedBoxes
//
//  Created by Guest User on 13/02/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import "NumberOfBoxesViewController.h"
#import "BoxesViewController.h"

@interface NumberOfBoxesViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, strong) UITextField *numberOfBoxesTextField;

@end

@implementation NumberOfBoxesViewController

- (void)loadView
{
    [super loadView];
    [self.view addSubview: self.numberOfBoxesTextField];
    [self.view addSubview: self.validateButton];
    [self.navigationController setNavigationBarHidden: YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: YES animated: YES];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.numberOfBoxesTextField.center = CGPointMake(self.view.center.x, self.view.center.y - self.numberOfBoxesTextField.frame.size.height);
    self.validateButton.center = CGPointMake(self.view.center.x, self.view.center.y + self.validateButton.frame.size.height);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"boxesSegue"])
    {
        ((BoxesViewController *)segue.destinationViewController).numberOfBoxes = [self.numberOfBoxesTextField.text integerValue];
    }
}

#pragma mark - Accessors

- (UIButton *)validateButton
{
    if (_validateButton == nil)
    {
        _validateButton = [UIButton buttonWithType: UIButtonTypeSystem];
        [_validateButton setTitle: @"Validate" forState: UIControlStateNormal];
        [[_validateButton layer] setBorderWidth: 1];
        [[_validateButton layer] setBorderColor: _validateButton.titleLabel.textColor.CGColor];
        [[_validateButton layer] setCornerRadius: 5];
        [_validateButton addTarget: self action: @selector(didTapButton:) forControlEvents: UIControlEventTouchUpInside];
        [_validateButton sizeToFit];
        CGRect buttonFrame = _validateButton.frame;
        buttonFrame.size.width += 20;
        _validateButton.frame = buttonFrame;
    }
    return _validateButton;
}

- (UITextField *)numberOfBoxesTextField
{
    if (_numberOfBoxesTextField == nil)
    {
        _numberOfBoxesTextField = [[UITextField alloc] init];
        [_numberOfBoxesTextField setPlaceholder: @"Number of boxes"];
        [_numberOfBoxesTextField setTextAlignment: NSTextAlignmentCenter];
        [_numberOfBoxesTextField setTextColor: [UIColor blackColor]];
        [_numberOfBoxesTextField setBorderStyle: UITextBorderStyleRoundedRect];
        [_numberOfBoxesTextField setDelegate: self];
        [_numberOfBoxesTextField sizeToFit];
    }
    return _numberOfBoxesTextField;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performSelector: @selector(didTapButton:) withObject: self.validateButton];
    return YES;
}

#pragma mark - Actions

- (void)didTapButton:(id)sender
{
    if (sender == self.validateButton)
    {
        if ([self.numberOfBoxesTextField.text integerValue] >= 0)
        {
            [self performSegueWithIdentifier: @"boxesSegue" sender: self];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Error" message: @"The number of boxes must be positive" delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil];
            [alertView show];
        }
    }
}

@end
