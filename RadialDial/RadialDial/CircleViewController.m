//
//  CircleViewController.m
//  RadialDial
//
//  Created by Sandeep on 25/08/14.
//  Copyright (c) 2014 neevtech. All rights reserved.
//
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define kRotationDegrees 90
#import "CircleViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DrawCircleParts.h"
#import "MainViewController.h"
#import "CircleGestureRecognizer.h"
#import "CircleOverlayView.h"
@interface CircleViewController(){

}
@end

@implementation CircleViewController
@synthesize circle, path, numberOfSegments, separatorStyle,separatorColor, ringWidth, circleColor, circleValues, overlay,overlayView;
@synthesize delegate, dataSource;
@synthesize inertiaEffect;

- (id)initWithFrame:(CGRect)frame numberOfSegments:(NSInteger)nSegments ringWidth:(CGFloat)width
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.inertiaEffect = YES;
        self.recognizer = [[CircleGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:self.recognizer];
        self.opaque = NO;
        self.numberOfSegments = nSegments;
        self.separatorStyle = CDCircleThumbsSeparatorBasic;
        self.ringWidth = width;
        self.circleColor = [UIColor whiteColor];
        
        
        CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(frame) - (2*ringWidth), CGRectGetWidth(frame) - (2*ringWidth));
        self.circleValues = [NSMutableArray array];
        for (int i = 0; i < self.numberOfSegments; i++) {
            
            DrawCircleParts *drawcircle = [[DrawCircleParts alloc] initWithShortCircleRadius:(rect1.size.height/2) longRadius:(frame.size.height/2) numberOfSegments:self.numberOfSegments];
            [self.circleValues addObject:drawcircle];
        }
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState (ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    
//    [self.circleColor setFill];
    [self.circleColor setStroke];
    circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    [circle strokeWithBlendMode:kCGBlendModeNormal alpha:5.0];
    [circle closePath];
//    [circle fill];
    
    CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(rect) - (2*ringWidth), CGRectGetWidth(rect) - (2*ringWidth));
    rect1.origin.x = rect.size.width / 2  - rect1.size.width / 2;
    rect1.origin.y = rect.size.height / 2  - rect1.size.height / 2;
    
    
    path = [UIBezierPath bezierPathWithOvalInRect:rect1];
    [path strokeWithBlendMode:kCGBlendModeNormal alpha:5.0];
//    [self.circleColor setFill];
//    [path fill];
    CGContextRestoreGState(ctx);
    
    
    //Drawing Thumbs
    CGFloat fNumberOfSegments = self.numberOfSegments;
    CGFloat perSectionDegrees = 360.f / fNumberOfSegments;
    CGFloat totalRotation = 360.f / fNumberOfSegments;
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    
    
    
    
    CGFloat deltaAngle;
    
    for (int i = 0; i < self.numberOfSegments; i++) {
        
       
        DrawCircleParts *drawcircle = [self.circleValues objectAtIndex:i];
        drawcircle.tag = i;
//        circle.iconView.image = [self.dataSource circle:self iconForThumbAtRow:thumb.tag];
//        drawcircle.textView.text = [self.dataSource circle:self textAtRow:drawcircle.tag];
//        NSData *day = [[self.dataSource circle:self textAtRow:drawcircle.tag] dataUsingEncoding:NSUTF8StringEncoding];
//        drawcircle.selectedDay.image = [UIImage imageWithData:day];
        drawcircle.selectedDay.day =[self.dataSource circle:self textAtRow:drawcircle.tag];
//        drawcircle.textView.text = @"S";
//        drawcircle.selectedDay.textView.text = [self.dataSource circle:self textAtRow:drawcircle.tag];
        CGFloat radius = (rect1.size.height/2 + ((rect.size.height/2 - rect1.size.height/2)/2) - drawcircle.yydifference);
        CGFloat x = centerPoint.x + (radius * cos(degreesToRadians(perSectionDegrees)));
        CGFloat yi = centerPoint.y + (radius * sin(degreesToRadians(perSectionDegrees)));
        
        
        
        [drawcircle setTransform:CGAffineTransformMakeRotation(degreesToRadians((perSectionDegrees + kRotationDegrees)))];
        if (i==0) {
            deltaAngle= degreesToRadians(360 - kRotationDegrees) + atan2(drawcircle.transform.a, drawcircle.transform.b);
            [drawcircle.selectedDay setIsSelected:YES];
            self.recognizer.currentThumb = drawcircle;
        }
        
        
        //set position of the thumb
        drawcircle.layer.position = CGPointMake(x, yi);
        
        
        perSectionDegrees += totalRotation;
        
        [self addSubview:drawcircle];
    }
    
    [self setTransform:CGAffineTransformRotate(self.transform,deltaAngle)];
    
    
    


}

-(void) tapped: (CircleGestureRecognizer *) arecognizer{
    if (arecognizer.ended == NO) {
        CGPoint point = [arecognizer locationInView:self];
        if ([path containsPoint:point] == NO) {
            
            [self setTransform:CGAffineTransformRotate([self transform], [arecognizer rotation])];
        }
    }
}


@end
