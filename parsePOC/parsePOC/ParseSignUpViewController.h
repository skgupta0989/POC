//
//  ParseSignUpViewController.h
//  parsePOC
//
//  Created by Sandeep Kumar Gupta on 22/04/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//
#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ParseSignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameSignUpText;
@property (weak, nonatomic) IBOutlet UITextField *emailSignUpText;
@property (weak, nonatomic) IBOutlet UITextField *passWordSignUpText;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitButtonClicked:(id)sender;
@end
