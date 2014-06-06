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
#import "AppDelegate.h"
#import "BlogTableViewController.h"
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
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonClicked:)];
    self.navigationItem.rightBarButtonItem = logoutButton;
    
    UIBarButtonItem *blogButton = [[UIBarButtonItem alloc] initWithTitle:@"Blog" style:UIBarButtonItemStyleBordered target:self action:@selector(blogButtonClicked:)];
    self.navigationItem.leftBarButtonItem = blogButton;
    
    
//    NSNumber *number = @42;
//    NSString *str = @"sandeep";
//    NSSet *set = [NSSet setWithObjects:number,number,str, nil];
//    NSLog(@"setvalue = %d",set.count);
//    
//    NSArray *array = [NSArray arrayWithObjects:number,number,str, nil];
//    NSLog(@"arrayvalue = %d",array.count);
//
    // Create the post
    
//    NSArray *list = [NSArray alloc];
//    list = [NSArray arrayWithObjects:@"Aston Martin",
//            @"Lotus", @"Jaguar", @"Bentley", nil];
//    
//    NSArray *list1 = [NSArray alloc];
//    list1 = [NSArray arrayWithObjects:@"A",
//            @"L", @"J", @"B", nil];
//    
//    PFObject *myPost = [PFObject objectWithClassName:@"Post2"];
//    [myPost addObject:list forKey:@"name"];
//    
//    
//    myPost[@"myArray"] = list1;
//    [myPost saveInBackground];
    
//    PFQuery *query = [PFQuery queryWithClassName:@"Post2"];
//    [query whereKey:@"myArray" equalTo:@"A"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//             NSLog(@"myArray = %d",[objects count]);
//            for (PFObject *list in objects) {
//                NSLog(@"list %@", list);
//            }
//        }
//    }];
//    
    
//    myPost[@"title"] = @"holiday";
//    myPost[@"content"] = @"Where should we go for fun?";
//    
//    // Create the comment
//    PFObject *myComment = [PFObject objectWithClassName:@"Comment"];
//    myComment[@"content"] = @"Let's go goa.";
//    
//    // Add a relation between the Post and Comment
//    myComment[@"parent"] = myPost;
//    
//    // This will save both myPost and myComment
//    [myComment saveInBackground];
//    
//   
////    PFQuery *post = [PFQuery queryWithClassName:@"Comment"];
//    [myComment fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        NSLog(@"this is one to many : %@",object[@"parent"]);
//    }];
	
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
    if ([self.companyNameText.text isEqual: @"" ]|| [self.telephoneNumText.text isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Value can't be null " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        [userInfo saveEventually:^(BOOL succeeded, NSError *error) {
            if (!error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Successfully Saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                self.companyNameText.text = @"";
                self.telephoneNumText.text = @"";
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Not Saved" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
       
    }
    
   
}

- (IBAction)updateButtonClicked:(id)sender {
    
    if ([self.companyNameForUpdate.text isEqual:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Failed" message:@"Please enter your company name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        PFQuery *query = [PFQuery queryWithClassName:@"PushObject"];
        [query whereKey:@"company_name" equalTo:self.companyNameForUpdate.text];
        [query findObjectsInBackgroundWithTarget:self selector:@selector(callBack:error:)];
    }
    
}

-(void)callBack:(NSArray *)objects error:(NSError *)error{
    if (!error && [objects count]!= 0) {
        for (PFObject *object in objects) {
            NSLog(@"objectId = %@",object.objectId);
            [self getAllDetails:object.objectId];
        }
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Failed" message:@"Company name not found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        self.companyNameForUpdate.text = @"";
        self.updateTeleNumText.text = @"";
        
    }
}

-(void)getAllDetails:(NSString *)objectId{
    PFQuery *query = [PFQuery queryWithClassName:@"PushObject"];
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        
        NSLog(@"%@", object[@"telephone_number"]);
        object[@"telephone_number"] = self.updateTeleNumText.text;
        [object saveEventually:^(BOOL succeeded, NSError *error) {
            if (!error) {
                self.companyNameForUpdate.text = @"";
                self.updateTeleNumText.text = @"";
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Not Updated" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
        
//        NSDictionary *list = object[@"profile"];
//        NSString *value = [list objectForKey:@"birthday"];
//            NSLog(@"birthday = %@",value);
        
        
    }];
    
}

-(IBAction)blogButtonClicked:(id)sender{
   
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    BlogTableViewController *blogView = [storyboard instantiateViewControllerWithIdentifier:@"BlogTableViewController"];
//    [self.navigationController pushViewController:blogView animated:YES];
    
    [self.navigationController pushViewController:[[BlogTableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
  
    
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
