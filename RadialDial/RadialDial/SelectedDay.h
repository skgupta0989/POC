//
//  SelectedDay.h
//  RadialDial
//
//  Created by Sandeep on 28/08/14.
//  Copyright (c) 2014 neevtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedDay : UIView{
    NSString *day;
    NSString *date;
}


@property (nonatomic, strong) UILabel *textView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *date;
//@property (nonatomic, strong) UIText   *image1;
@property (nonatomic, assign, setter = setIsSelected:) BOOL selected;
@property (nonatomic, strong) UIColor *highlitedTextColor;
-(void) setIsSelected:(BOOL)isSelected;

@end
