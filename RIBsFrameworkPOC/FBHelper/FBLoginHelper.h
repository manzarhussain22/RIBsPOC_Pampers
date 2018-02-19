//
//  FBLoginHelper.h
//  PampersRewards
//
//  Created by InfosysDev on 07/12/17.
//  Copyright © 2017 ProcterAndGamble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

typedef void(^isFBDataExtracted)(BOOL);

@interface FBLoginHelper : NSObject
+ sharedInstance;

@property NSString *emailId;
@property NSString *socialId;
@property NSString *firstName;
@property FBSDKLoginManager *loginManager;

-(void)initiateFBLoginFromView:(UIViewController *)viewController withCompletionBlock:(isFBDataExtracted)extracted;
-(void)initiateLogout;
@end
