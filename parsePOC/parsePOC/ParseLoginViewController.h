//
//  ViewController.h
//  parsePOC
//
//  Created by Sandeep Kumar Gupta on 22/04/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface ParseLoginViewController : UIViewController{
   BOOL value;
    UIColor *barTintColor;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;
@property (nonatomic, assign) BOOL value;
@property(nonatomic, retain) UIColor *barTintColor;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)SignInButtonClicked:(id)sender;
- (IBAction)fbLoginButtonClicked:(id)sender;

@end
