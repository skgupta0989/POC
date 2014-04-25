//
//  FbUserViewController.h
//  parsePOC
//
//  Created by Sandeep Kumar Gupta on 25/04/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FbUserViewController : UITableViewController<NSURLConnectionDataDelegate>



// UITableView header view properties
@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet UILabel *headerNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *headerImageView;

// UITableView row data properties
@property (nonatomic, strong) NSArray *rowTitleArray;
@property (nonatomic, strong) NSMutableArray *rowDataArray;
@property (nonatomic, strong) NSMutableData *imageData;

// UINavigationBar button touch handler
- (void)logoutButtonTouchHandler:(id)sender;
@end
