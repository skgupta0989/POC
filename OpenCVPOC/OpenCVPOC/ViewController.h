//
//  ViewController.h
//  OpenCVPOC
//
//  Created by Sandeep Kumar Gupta on 28/05/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>
#import <opencv2/objdetect/objdetect.hpp>
#import <opencv2/imgproc/imgproc_c.h>

using namespace cv;

@interface ViewController : UIViewController<CvVideoCameraDelegate>{
    
    IBOutlet UIImageView *imageView;
    CvVideoCamera *videoCamera;
    CascadeClassifier noseCascade;
}

@property(nonatomic,retain) CvVideoCamera *videoCamera;

-(IBAction)start:(id)sender;
-(IBAction)stop:(id)sender;

@end
