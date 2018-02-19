//
//  ViewController.h
//  CMS
//
//  Created by G S DHILLON on 14/02/18.
//  Copyright © 2018 MyOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController < NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate,  NSURLSessionDelegate, iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *logoView;
@property (strong, nonatomic) IBOutlet iCarousel *iCarouselView1;
@property (strong, nonatomic) IBOutlet UIImageView *topImageView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomImageView;
@property(nonatomic) BOOL t;
@end

