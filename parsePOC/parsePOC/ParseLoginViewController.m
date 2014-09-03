//
//  ViewController.m
//  parsePOC
//
//  Created by Sandeep Kumar Gupta on 22/04/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//
#import <Parse/Parse.h>
#import "ParseLoginViewController.h"
#import "UserInfoViewController.h"
#import "FbUserViewController.h"

@interface ParseLoginViewController ()

@end

@implementation ParseLoginViewController
@synthesize value;
@synthesize barTintColor;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self.navigationController pushViewController:[[FbUserViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:NO];
    }
    

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
////     value = '\0';
//    if ([identifier isEqualToString:@"UserInfoView" ]) {
//        
//       
//        return value;
//    }
//    else if ([identifier isEqualToString:@"SignUpView"]){
//        return YES;
//    }
//    
//        return NO;
//    
//}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.userNameText)
        [self.passWordText becomeFirstResponder];
    else if(textField == self.passWordText)
        [textField resignFirstResponder];
    return YES;
    
}

- (IBAction)SignInButtonClicked:(id)sender {
    NSLog(@"%@",self.userNameText.text);
//    [_activityIndicator startAnimating];
    [PFUser logInWithUsernameInBackground:self.userNameText.text password:self.passWordText.text block:^(PFUser *user, NSError *error) {
        
        if (user) {
            // Do stuff after successful login.
            NSLog(@"username - %@",user.username);
            self.userNameText.text = @"";
            self.passWordText.text = @"";
            [_activityIndicator stopAnimating];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UserInfoViewController *infoView = [storyboard instantiateViewControllerWithIdentifier:@"UserInfoViewController"];
        [self.navigationController pushViewController:infoView animated:YES];
            
        } else {
            // The login failed. Check error to see why.
//            [_activityIndicator stopAnimating];
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Error" message:@"Login Failed" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            [alert show];
            
            
        }
    }];

}

- (IBAction)fbLoginButtonClicked:(id)sender {
    
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator startAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self.navigationController pushViewController:[[FbUserViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        } else {
            NSLog(@"User with facebook logged in!");
            [self.navigationController pushViewController:[[FbUserViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        }
    }];
    
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}
@end
