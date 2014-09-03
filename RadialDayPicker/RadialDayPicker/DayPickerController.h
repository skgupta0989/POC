//
//  DayPickerController.h
//  RadialDayPicker
//
//  Created by Sandeep on 29/07/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayPickerProtocol.h"
@interface DayPickerController : UIControl

@property (weak) id <DayPickerProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfSections;
@property CGAffineTransform startTransform;
@property (nonatomic, strong) NSMutableArray *cloves;
@property int currentValue;


- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber;

@end
