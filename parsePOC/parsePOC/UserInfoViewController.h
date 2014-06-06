//
//  UserInfoViewController.h
//  parsePOC
//
//  Created by Sandeep Kumar Gupta on 22/04/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *companyNameText;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *updateTeleNumText;
@property (weak, nonatomic) IBOutlet UITextField *companyNameForUpdate;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
- (IBAction)logoutButtonClicked:(id)sender;
- (IBAction)saveButtonClicked:(id)sender;
- (IBAction)updateButtonClicked:(id)sender;
- (IBAction)blogButtonClicked:(id)sender;

@end
