//
//  ViewController.m
//  RadialDial
//
//  Created by Sandeep on 25/08/14.
//  Copyright (c) 2014 neevtech. All rights reserved.
//

#import "MainViewController.h"
#import "CircleOverlayView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    CircleViewController *circleView = [[CircleViewController alloc] initWithFrame:CGRectMake(-115, 300, 550, 550) numberOfSegments:21 ringWidth:65.f];
    
    circleView.dataSource = self;
    circleView.delegate = self;
   
    CircleOverlayView *overlay = [[CircleOverlayView alloc] initWithCircle:circleView];
   
    [self.view addSubview:circleView];
    [self.view addSubview:overlay];

        self.view.backgroundColor = [UIColor greenColor];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) circle: (CircleViewController *) circle didMoveToSegment:(NSInteger) segment thumb: (DrawCircleParts *) thumb{
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User did select item" message:[NSString stringWithFormat:@"Segment's tag: %li", (long)segment] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert show];
}

-(NSString * ) circle: (CircleViewController *) circle textAtRow:(NSInteger) row{
    
    if (row%7 == 0) {
        return @"S";
    }
    else if (row%7 == 1){
        return @"M";
    }
    else if (row%7 == 2){
        return @"T";
    }
    else if (row%7 == 3){
        return @"W";
    }
    else if (row%7 == 4){
        return @"T";
    }
    else if (row%7 == 5){
        return @"F";
    }
    else if (row%7 == 6){
        return @"S";
    }
    
    return nil;
}


@end
