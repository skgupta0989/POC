//
//  DayPicker.h
//  RadialDayPicker
//
//  Created by Sandeep on 29/07/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DayPickerProtocol <NSObject>

- (void) wheelDidChangeValue:(NSString *)newValue;

@end
