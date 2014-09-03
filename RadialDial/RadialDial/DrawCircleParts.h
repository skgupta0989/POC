//
//  DrawCircle.h
//  RadialDial
//
//  Created by Sandeep on 25/08/14.
//  Copyright (c) 2014 neevtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleViewController.h"
#import "SelectedDay.h"
@interface DrawCircleParts : UIView
{
    CGFloat numberOfSegments;
    CGFloat bigArcHeight;
    CGFloat smallArcWidth;
}
@property (assign, readonly) CGFloat sRadius;
@property (assign, readonly) CGFloat lRadius;
@property (assign, readonly) CGFloat yydifference;
@property (nonatomic, strong) UIBezierPath *arc;
@property (nonatomic, strong) UIBezierPath *arc1;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CDCircleThumbsSeparator separatorStyle;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, strong) NSMutableArray * colorsLocations;
@property (nonatomic, strong) SelectedDay *selectedDay;
@property (assign) BOOL gradientFill;
@property (nonatomic, strong) NSArray *gradientColors;
@property (nonatomic, strong) UIColor *arcColor;
@property (nonatomic, strong) UILabel *textView;



-(id)initWithShortCircleRadius :(CGFloat)shortRadius longRadius:(CGFloat)longRadius
               numberOfSegments:(CGFloat)sNumber;
@end
