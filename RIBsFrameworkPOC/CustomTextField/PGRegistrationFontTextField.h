//
//  PGRegistrationFontTextField.h
//  PampersRewards
//
//  Created by Vikas Chaudhary on 31/01/17.
//  Copyright © 2017 ProcterAndGamble. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGRegistrationFontTextField : UITextField

@property(nonatomic) UILabel *placeholderLabel;

-(void)showAnimation;
-(void)showNormalText;
@end
