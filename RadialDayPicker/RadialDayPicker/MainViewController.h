//
//  MainViewController.h
//  RadialDayPicker
//
//  Created by Sandeep on 29/07/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayPickerProtocol.h"
@interface MainViewController : UIViewController<DayPickerProtocol>

@property (nonatomic, strong) UILabel *valueLabel;

@end
