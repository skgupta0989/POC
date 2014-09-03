//
//  SelectedDay.m
//  RadialDial
//
//  Created by Sandeep on 28/08/14.
//  Copyright (c) 2014 neevtech. All rights reserved.
//

#import "SelectedDay.h"

@implementation SelectedDay

@synthesize textView, selected, highlitedTextColor,image,day,date;

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        selected = NO;
        self.opaque =NO;
        self.backgroundColor = [UIColor clearColor];
//        textView = [[UILabel alloc] initWithFrame:frame];
//        textView.textColor = [UIColor lightGrayColor];
//        self.highlitedTextColor = [UIColor colorWithRed:0.75 green:0.00f blue:0.00f alpha:1.00f];
        self.highlitedTextColor = [UIColor whiteColor];
        date = @"sandy";
    }
    return self;
}

-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (day != nil) {
        if (selected == YES) {

            CGContextRef context = UIGraphicsGetCurrentContext();
            
            // Draw a dark gray background
//            [[UIColor clearColor] setFill];
//            CGContextFillRect(context, rect);
            
            // Draw the text upside-down
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 0, rect.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextSetBlendMode(context, kCGBlendModeColor);
            
           
            
            [day
             drawInRect:rect
             withAttributes:
             [NSDictionary dictionaryWithObjectsAndKeys:
              [UIFont fontWithName:@"HelveticaNeue" size:30], NSFontAttributeName,
              [UIColor greenColor], NSForegroundColorAttributeName,
              nil]];
            
//            [date
//             drawInRect:rect
//             withAttributes:
//             [NSDictionary dictionaryWithObjectsAndKeys:
//              [UIFont fontWithName:@"HelveticaNeue" size:15], NSFontAttributeName,
//              [UIColor greenColor], NSForegroundColorAttributeName,
//              nil]];
            
            CGContextRestoreGState(context);
            
            // Create an image mask from what we've drawn so far
            CGImageRef alphaMask = CGBitmapContextCreateImage(context);
//            [[UIColor whiteColor] setFill];
            
//            CGContextSaveGState(context);
            CGContextClipToMask(context, rect, alphaMask);
//            CGContextRestoreGState(context);
            
            CGContextSetFillColorWithColor(context, self.highlitedTextColor.CGColor);
            CGContextFillRect(context, rect);

            
            CGImageRelease(alphaMask);
            //////////////////////////////////////////////////////////////
            
            
            

        }
        else {
            
            [day
             drawInRect:rect
             withAttributes:
             [NSDictionary dictionaryWithObjectsAndKeys:
              [UIFont fontWithName:@"HelveticaNeue" size:20], NSFontAttributeName,
              [UIColor lightGrayColor], NSForegroundColorAttributeName,
              nil]];
//            day.textColor = [UIColor lightGrayColor];
//            [day drawInRect:rect];

            }
        }

}

-(void) setIsSelected:(BOOL)isSelected {
    if (selected != isSelected) {
        selected = isSelected;
        [self setNeedsDisplay];
    }
    else return;
}
@end
