//
//  CircleViewController.h
//  RadialDial
//
//  Created by Sandeep on 25/08/14.
//  Copyright (c) 2014 neevtech. All rights reserved.
//

typedef enum {
    CDCircleThumbsSeparatorNone,
    CDCircleThumbsSeparatorBasic
}CDCircleThumbsSeparator;

@class CircleViewController, DrawCircle,CircleGestureRecognizer,DrawCircleParts,CircleOverlayView;



@protocol CircleViewControllerDelegate <NSObject>
@required

-(void) circle: (CircleViewController *) circle didMoveToSegment:(NSInteger) segment thumb: (DrawCircleParts *) thumb;

@end
@protocol CircleViewControllerDataSource <NSObject>
-(NSString * ) circle: (CircleViewController *) circle textAtRow: (NSInteger) row;

@end

#import <UIKit/UIKit.h>
//#import "CircleOverlayView.h"

@interface CircleViewController : UIView

@property (nonatomic, strong) NSMutableArray *circleValues;
@property (nonatomic, strong) UIBezierPath *circle;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, assign) BOOL inertiaEffect;
@property (nonatomic, strong) CircleGestureRecognizer *recognizer;
@property (assign) int numberOfSegments;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CDCircleThumbsSeparator separatorStyle;
@property (nonatomic, strong) CircleOverlayView *overlayView;
@property (nonatomic, assign) CGFloat ringWidth;
@property (nonatomic, assign) BOOL overlay;

@property (nonatomic, strong) id <CircleViewControllerDelegate> delegate;
@property (nonatomic, strong) id <CircleViewControllerDataSource> dataSource;

@property (nonatomic, strong) UIColor *circleColor;

-(id) initWithFrame:(CGRect)frame numberOfSegments: (NSInteger) nSegments ringWidth: (CGFloat) width;
@end