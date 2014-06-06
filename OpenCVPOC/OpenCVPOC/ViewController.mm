//
//  ViewController.m
//  OpenCVPOC
//
//  Created by Sandeep Kumar Gupta on 28/05/14.
//  Copyright (c) 2014 Sandeep Kumar Gupta. All rights reserved.
//

#import "ViewController.h"
NSString* const CascadeNoseFileName = @"haarcascade_mcs_nose";
const int HaarOptions = CV_HAAR_FIND_BIGGEST_OBJECT | CV_HAAR_DO_ROUGH_SEARCH;

@interface ViewController ()

@end

@implementation ViewController

@synthesize videoCamera;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    self.videoCamera.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
//    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20,20,300,50)];
//    name.text = @"Sandeep";
//    name.backgroundColor = [UIColor greenColor];
//    name.textColor = [UIColor blackColor];
//    [name setFont:[UIFont fontWithName:@"Ariel" size:36]];
//    [self.view addSubview:name];
    
    NSString *noseCascadePath = [[NSBundle mainBundle] pathForResource:CascadeNoseFileName ofType:@"xml"];
    NSLog(@"path =%@",noseCascadePath);
    noseCascade.load([noseCascadePath UTF8String]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark CvVideoDelegate

-(void)processImage:(cv::Mat &)image{
    

    
    Mat grayscaleFrame;
    if (image.channels() == 3) {
        cvtColor(image, grayscaleFrame, CV_BGR2GRAY);
    }
    else if (image.channels() == 4) {
        cvtColor(image, grayscaleFrame, CV_BGRA2GRAY);
    }
    else {
        // Access the grayscale input image directly.
        grayscaleFrame = image;
    }
    
    cvtColor(image,grayscaleFrame, CV_BGR2GRAY);
    equalizeHist(grayscaleFrame,grayscaleFrame);
    
    std::vector<cv::Rect> nose;
    noseCascade.detectMultiScale(grayscaleFrame,nose,1.1,2,HaarOptions,cv::Size(20,20));
    for(int i=0;i<nose.size();i++)
    {
        cv::Point pt1(nose[i].x + nose[i].width,nose[i].y + nose[i].height);
        cv::Point pt2(nose[i].x,nose[i].y);
        
        cv::rectangle(image,pt1,pt2,cvScalar(0,200,0,0),1,8,0);
        
        
//        CGRect rect;
//        CGFloat x=1;
//        CGFloat y=1;
//        rect.origin.x = x;
//        rect.origin.y = y;
      
        
        UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(nose[i].x,nose[i].y,30,30)];
        dot.image=[UIImage imageNamed:@"draw.jpg"];
        [self.view addSubview:dot];
    }
    
}

-(IBAction)start:(id)sender{
    [self.videoCamera start];
}

-(IBAction)stop:(id)sender{
    [self.videoCamera stop];
}
@end
