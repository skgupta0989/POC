//
//  MainViewController.m
//  RadialDayPicker
//
//  Created by Sandeep on 29/07/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//

#import "MainViewController.h"
#import "DayPickerController.h"
@interface MainViewController ()

@end

@implementation MainViewController

@synthesize valueLabel;

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
    valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 120, 30)];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:valueLabel];
	
    DayPickerController *wheel = [[DayPickerController alloc] initWithFrame:CGRectMake(0, 0, 200, 200) andDelegate:self
                                                   withSections:7];
    
    wheel.center = CGPointMake(160, 240);
    [self.view addSubview:wheel];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) wheelDidChangeValue:(NSString *)newValue{
    
}
@end
