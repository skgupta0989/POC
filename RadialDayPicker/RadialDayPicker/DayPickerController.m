//
//  DayPickerController.m
//  RadialDayPicker
//
//  Created by Sandeep on 29/07/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//

#import "DayPickerController.h"
#import <QuartzCore/QuartzCore.h>

@interface DayPickerController()
- (void)drawWheel;
- (float) calculateDistanceFromCenter:(CGPoint)point;
- (void) buildClovesEven;
- (void) buildClovesOdd;
- (UIImageView *) getCloveByValue:(int)value;
- (NSString *) getCloveName:(int)position;
@end


static float deltaAngle;
static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;


@implementation DayPickerController

@synthesize delegate, container, numberOfSections, startTransform, cloves, currentValue;


- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    
    if ((self = [super initWithFrame:frame])) {
		
        self.currentValue = 0;
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
		[self drawWheel];
        
	}
    return self;
}

- (void)drawWheel{
    
    container = [[UIView alloc] initWithFrame:self.frame];
    // 2
    CGFloat angleSize = 2*M_PI/numberOfSections;
    // 3
    for (int i = 0; i < numberOfSections; i++) {
        // 4
        UILabel *im = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        im.backgroundColor = [UIColor redColor];
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        im.layer.position = CGPointMake(container.bounds.size.width/2.0-container.frame.origin.x,
                                        container.bounds.size.height/2.0-container.frame.origin.y);
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
        im.alpha = minAlphavalue;
        im.tag = i;
        
        if (i == 0) {
            im.alpha = maxAlphavalue;
        }        // 6
        [container addSubview:im];
    }
    // 7
    container.userInteractionEnabled = NO;
    [self addSubview:container];

    
}
- (float) calculateDistanceFromCenter:(CGPoint)point{
    return 0;
}
- (void) buildClovesEven{
    
}
- (void) buildClovesOdd{
    
}
- (UIImageView *) getCloveByValue:(int)value{
    return 0;
    
}
- (NSString *) getCloveName:(int)position{
    return 0;
}


@end
