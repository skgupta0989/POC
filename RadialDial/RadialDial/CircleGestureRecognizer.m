//
//  CircleGestureRecognizer.m
//  RadialDial
//
//  Created by Sandeep on 27/08/14.
//  Copyright (c) 2014 neevtech. All rights reserved.
//

#import "CircleGestureRecognizer.h"
#define deceleration_multiplier 30.0f

#import <QuartzCore/QuartzCore.h>
#import "CircleGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "CircleViewController.h"
#import "DrawCircleParts.h"
#import "Common.h"
#import "CircleOverlayView.h"
@class CircleViewController;
@implementation CircleGestureRecognizer

@synthesize rotation = rotation_, controlPoint;
@synthesize ended;
@synthesize currentThumb;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CircleViewController *view = (CircleViewController *) [self view];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:view];
    
    // Fail when more than 1 finger detected.
    if ([[event touchesForGestureRecognizer:self] count] > 1 || ([view.path containsPoint:point] == YES )) {
        [self setState:UIGestureRecognizerStateFailed];
    }
    self.ended = NO;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self state] == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateBegan];
    } else {
        [self setState:UIGestureRecognizerStateChanged];
    }
    
    // We can look at any touch object since we know we
    // have only 1. If there were more than 1 then
    // touchesBegan:withEvent: would have failed the recognizer.
    UITouch *touch = [touches anyObject];
    
    // To rotate with one finger, we simulate a second finger.
    // The second figure is on the opposite side of the virtual
    // circle that represents the rotation gesture.
    
    CircleViewController *view = (CircleViewController *) [self view];
    CGPoint center = CGPointMake(CGRectGetMidX([view bounds]), CGRectGetMidY([view bounds]));
    CGPoint currentTouchPoint = [touch locationInView:view];
    CGPoint previousTouchPoint = [touch previousLocationInView:view];
    previousTouchDate = [NSDate date];
    CGFloat angleInRadians = atan2f(currentTouchPoint.y - center.y, currentTouchPoint.x - center.x) - atan2f(previousTouchPoint.y - center.y, previousTouchPoint.x - center.x);
    [self setRotation:angleInRadians];
    currentTransformAngle = atan2f(view.transform.b, view.transform.a);
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Perform final check to make sure a tap was not misinterpreted.
    if ([self state] == UIGestureRecognizerStateChanged) {
        
        
        CircleViewController *view = (CircleViewController *) [self view];
        CGFloat flipintime = 0;
        CGFloat angle = 0;
        if (view.inertiaEffect == YES) {
            CGFloat angleInRadians = atan2f(view.transform.b, view.transform.a) - currentTransformAngle;
            double time = [[NSDate date] timeIntervalSinceDate:previousTouchDate];
            double velocity = angleInRadians/time;
            CGFloat a = deceleration_multiplier;
            
            flipintime = fabs(velocity)/a;
            
            
            
            angle = (velocity*flipintime)-(a*flipintime*flipintime/2);
            
            if (angle>M_PI/2 || (angle<0 && angle<-1*M_PI/2)) {
                if (angle<0) {
                    angle =-1 * M_PI/2.1f;
                }
                else { angle = M_PI/2.1f; }
                
                flipintime = 1/(-1*(a/2*velocity/angle));
            }
            
        }
        
        
        
        [UIView animateWithDuration:flipintime delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [view setTransform:CGAffineTransformRotate(view.transform,angle)];
            
        } completion:^(BOOL finished) {
            for (DrawCircleParts *thumb in view.circleValues) {
                
                
                CGPoint point = [thumb convertPoint:thumb.centerPoint toView:nil];
                DrawCircleParts *shadow = view.overlayView.overlayThumb;
                
                CGRect shadowRect = [shadow.superview convertRect:shadow.frame toView:nil];
                
                if (CGRectContainsPoint(shadowRect, point) == YES) {
                    CGPoint pointInShadowRect = [thumb convertPoint:thumb.centerPoint toView:shadow];
                    if (CGPathContainsPoint(shadow.arc.CGPath, NULL, pointInShadowRect, NULL)) {
                        CGAffineTransform current = view.transform;
//
                        
                        CGFloat deltaAngle= - degreesToRadians(180) + atan2(view.transform.a, view.transform.b) + atan2(thumb.transform.a, thumb.transform.b);
////
////                        
                        [UIView animateWithDuration:0.2f animations:^{
                            [view setTransform:CGAffineTransformRotate(current, deltaAngle)];
                        }];

                
                        [currentThumb.selectedDay setIsSelected:NO];
                        [thumb.selectedDay setIsSelected:YES];
                        self.currentThumb = thumb;
                        //Delegate method
                        [view.delegate circle:view didMoveToSegment:thumb.tag thumb:thumb];
                        self.ended = YES;
                        break;
                    }
                
                }
            }
            ;
        }];
        
        
        currentTransformAngle = 0;
        
        
        
        [self setState:UIGestureRecognizerStateEnded];
        
    } else {
        
        CircleViewController *view = (CircleViewController *)[self view];
        UITouch *touch = [touches anyObject];
        
        for (DrawCircleParts *thumb in view.circleValues) {
            
            CGPoint touchPoint = [touch locationInView:thumb];
            if (CGPathContainsPoint(thumb.arc.CGPath, NULL, touchPoint, NULL)) {
                
                CGFloat deltaAngle= - degreesToRadians(180) + atan2(view.transform.a, view.transform.b) + atan2(thumb.transform.a, thumb.transform.b);
                CGAffineTransform current = view.transform;
                [UIView animateWithDuration:0.3f animations:^{
                    [view setTransform:CGAffineTransformRotate(current, deltaAngle)];
                } completion:^(BOOL finished) {
                                     
                    [currentThumb.selectedDay setIsSelected:NO];
                    [thumb.selectedDay setIsSelected:YES];
                    self.currentThumb = thumb;
                    //Delegate method
                    [view.delegate circle:view didMoveToSegment:thumb.tag thumb:thumb];
                    self.ended = YES;
                    
                }];
                
                break;
            }
            
        }
        
        [self setState:UIGestureRecognizerStateFailed];
    }
}



- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setState:UIGestureRecognizerStateFailed];
}
@end
