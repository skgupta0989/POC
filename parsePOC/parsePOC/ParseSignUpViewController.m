//
//  ParseSignUpViewController.m
//  parsePOC
//
//  Created by Sandeep Kumar Gupta on 22/04/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//
#import <Parse/Parse.h>
#import "ParseSignUpViewController.h"

@implementation ParseSignUpViewController


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
- (IBAction)submitButtonClicked:(id)sender {
    
    PFUser *user = [PFUser user];
    user.username = self.userNameSignUpText.text;
    user.password = self.passWordSignUpText.text;
    user.email = self.emailSignUpText.text;
    
    // other fields can be set just like with PFObject
    //    user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            self.userNameSignUpText.text = @"";
            self.emailSignUpText.text = @"";
            self.passWordSignUpText.text = @"";
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"congratulation" message:@"Successfully registered" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            // Hooray! Let them use the app now.
        } else {
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Unable to register" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"something wrong %@",errorString);
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.userNameSignUpText)
        [self.emailSignUpText becomeFirstResponder];
    else if(textField == self.emailSignUpText)
        [self.passWordSignUpText becomeFirstResponder];
    else if(textField == self.passWordSignUpText)
        [textField resignFirstResponder];
    return YES;
    
}


@end
