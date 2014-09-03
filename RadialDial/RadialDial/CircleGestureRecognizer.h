//
//  CircleGestureRecognizer.h
//  RadialDial
//
//  Created by Sandeep on 27/08/14.
//  Copyright (c) 2014 neevtech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrawCircleParts;

@interface CircleGestureRecognizer : UIGestureRecognizer{
    NSDate *previousTouchDate;
    double currentTransformAngle;
}


@property (nonatomic, assign) BOOL ended;
@property (nonatomic, assign) CGFloat rotation;
@property (nonatomic, assign) CGPoint controlPoint;
@property (nonatomic, strong) DrawCircleParts *currentThumb;
@end
