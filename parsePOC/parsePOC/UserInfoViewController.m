//
//  UserInfoViewController.m
//  parsePOC
//
//  Created by Sandeep Kumar Gupta on 22/04/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//
#import <Parse/Parse.h>
#import "UserInfoViewController.h"
#import "ParseLoginViewController.h"
#import "ParseSignUpViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    
  
//    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    
//    NSArray *actionButtonItems = @[cameraItem];
//    self.navigationItem.rightBarButtonItems = actionButtonItems;
	
}

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonClicked:(id)sender {
    
    [PFUser logOut];

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)saveButtonClicked:(id)sender {
    
    PFObject *userInfo = [PFObject objectWithClassName:@"PushObject"];
    userInfo[@"company_name"] = self.companyNameText.text;
    userInfo[@"telephone_number"] = self.telephoneNumText.text;
    [userInfo saveEventually];
    self.companyNameText.text = @"";
    self.telephoneNumText.text = @"";
}

- (IBAction)updateButtonClicked:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"PushObject"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"4JxVueFfFq" block:^(PFObject *gameScore, NSError *error) {
        
        gameScore[@"telephone_number"] = self.updateTeleNumText.text;
       
        [gameScore saveInBackground];
        self.updateTeleNumText.text = @"";
        
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.updateTeleNumText)
        [textField resignFirstResponder];
    return YES;
    
}
@end
