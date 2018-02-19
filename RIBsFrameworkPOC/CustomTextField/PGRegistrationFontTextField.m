//
//  PGRegistrationFontTextField.m
//  PampersRewards
//
//  Created by Vikas Chaudhary on 31/01/17.
//  Copyright © 2017 ProcterAndGamble. All rights reserved.
//

#import "PGRegistrationFontTextField.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation PGRegistrationFontTextField

@synthesize placeholderLabel;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(self.tag==300)
    {
        self.placeholderLabel=[[UILabel alloc]initWithFrame:CGRectMake((20/320.)*kScreenWidth, (5/568.)*kScreenHeight, (254/320.)*kScreenWidth, (35/568.)*kScreenHeight)];
        self.placeholderLabel.numberOfLines=2;
        [placeholderLabel setFont:[UIFont fontWithName:@"GothamRounded-Medium" size:(13/568.)*kScreenHeight]];
    }
    
    else
    {
         self.placeholderLabel=[[UILabel alloc]initWithFrame:CGRectMake((20/320.)*kScreenWidth, (14.5/568.)*kScreenHeight, (254/320.)*kScreenWidth, (15/568.)*kScreenHeight)];
    }
   
    self.placeholderLabel.textColor = [UIColor colorWithRed:182/255. green:182/255. blue:182/255. alpha:1];
   [placeholderLabel setFont:[UIFont fontWithName:@"GothamRounded-Medium" size:(15/568.)*kScreenHeight]];
   
   
    [self addSubview:self.placeholderLabel];
    return self;
    
}
-(void)showAnimation {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^(void){
        placeholderLabel.textColor = [UIColor colorWithRed:107/255. green:107/255. blue:107/255. alpha:1];
        placeholderLabel.frame = CGRectMake(self.bounds.origin.x + ((20/320.)*kScreenWidth), self.bounds.origin.y + ((5/568.)*kScreenHeight), (254/320.)*kScreenWidth, ((20/568.)*kScreenHeight));
        [placeholderLabel setFont:[UIFont fontWithName:@"GothamRounded-Medium" size:(10/568.)*kScreenHeight]];
        
    }completion:^(BOOL completed){}];

    
}
-(void)showNormalText {
    self.placeholderLabel.frame=CGRectMake((20/320.)*kScreenWidth, (14.5/568.)*kScreenHeight, (254/320.)*kScreenWidth, (15/568.)*kScreenHeight);
    self.placeholderLabel.textColor = [UIColor colorWithRed:182/255. green:182/255. blue:182/255. alpha:1];
    [placeholderLabel setFont:[UIFont fontWithName:@"GothamRounded-Medium" size:(15/568.)*kScreenHeight]];
}


- (CGRect)textRectForBounds:(CGRect)bounds {
    
    CGFloat rightInset = 105.;
    
    if ([[UIScreen mainScreen]bounds].size.width == 320)
    {
        rightInset = 90.;
    }
    
    if (self.tag!=100) {
        rightInset = rightInset - 50;
    }
    
    if (self.tag==200) {
        rightInset = 20.;
    }
    
//    CGRect rect = [super textRectForBounds:bounds];
    CGRect rect = CGRectMake(bounds.origin.x, bounds.origin.y+((7.5/568.)*kScreenHeight), bounds.size.width, bounds.size.height);
    UIEdgeInsets insets = UIEdgeInsetsMake(0, ((20/320.)*kScreenWidth), 0, rightInset);
    return UIEdgeInsetsInsetRect(rect, insets);
    
}

// Text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    CGFloat rightInset = 105.;
    
    if ([[UIScreen mainScreen]bounds].size.width == 320)
    {
        rightInset = 90.;
    }
    
    if (self.tag!=100) {
        rightInset = rightInset - 50;
    }
    
    if (self.tag==200) {
        rightInset = 20.;
    }
    
//    CGRect rect = [super textRectForBounds:bounds];
    CGRect rect = CGRectMake(bounds.origin.x, bounds.origin.y+((7.5/568.)*kScreenHeight), bounds.size.width, bounds.size.height);
    UIEdgeInsets insets = UIEdgeInsetsMake(0, ((20/320.)*kScreenWidth), 0, rightInset);
    
    return UIEdgeInsetsInsetRect(rect, insets);
    
}

- (BOOL) canPerformAction:(SEL)action withSender:(id)sender{
    
    if(self.tag == 2 || self.tag == 3)
    {
        if (action == @selector(copy:))
        {
            return YES;
        }
        if (action == @selector(selectAll:))
        {
            return YES;
        }
        if (action == @selector(select:))
        {
            return YES;
        }
        
        return NO;
    }
    else
    {
        if (action == @selector(cut:))
        {
            return YES;
        }
        if (action == @selector(copy:))
        {
            return YES;
        }
        if (action == @selector(selectAll:))
        {
            return YES;
        }
        if (action == @selector(select:))
        {
            return YES;
        }
        if (action == @selector(paste:))
        {
            return YES;
        }
        return NO;
    }
}

- (void)delete:(nullable id)sender
{
    [self replaceRange:self.selectedTextRange withText:@""];
}



@end
