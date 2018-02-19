//
//  ViewController.m
//  CMS
//
//  Created by G S DHILLON on 14/02/18.
//  Copyright © 2018 MyOrg. All rights reserved.
//

#import "ViewController.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"
#import "MBProgressHUD.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray * places;
@property (strong, nonatomic) NSMutableArray * array;
@property (strong, nonatomic) NSDictionary * homeDictionary;
@property (strong, nonatomic) NSDictionary * logoDictionary;
@property (strong, nonatomic) NSArray *assetArray;
@property (nonatomic, strong) NSMutableArray *iCarouselItems;
@property (strong, nonatomic) MBProgressHUD * hud;
@property (strong, nonatomic) NSString *locale;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * language = [[NSLocale preferredLanguages] firstObject];
    NSArray *arr = [NSLocale preferredLanguages];
    NSString* lan = [arr objectAtIndex:0];
    
    lan = [lan substringToIndex:2];
    
    NSLog(@"%@", lan);
    self.locale = lan;
    if([self.locale isEqualToString:@"fr"]){
        self.pointsLabel.text = @"Mes Points";
        self.bottomImageView.image = [UIImage imageNamed:@"FRBP.png"];
    }else{
        self.pointsLabel.text = @"My Balance";
    }
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"Downloading Data";
    self.hud.dimBackground = YES;
    [self hideUI:YES];
    self.imageView.hidden= YES;
    [self.hud show:YES];
    _iCarouselItems = [[NSMutableArray alloc]init];
    [self loadController];
    self.iCarouselView1.dataSource = self;
    self.iCarouselView1.delegate = self;
    _iCarouselView1.type = iCarouselTypeLinear;
    
}
-(void)loadController{
    [self downloadLogo];
    [self  downloadEntities];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadController];
}

-(void)setT:(BOOL)t{
    [self loadController];
}
-(void)hideUI : (BOOL)display{
    self.titleLabel.hidden = display;
    self.iCarouselView1.hidden= display;
    self.topImageView.hidden = display;
    self.bottomImageView.hidden = display;
    self.logoView.hidden = display;
    self.pointsLabel.hidden = display;

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [_iCarouselItems count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
//    if (view == nil)
//    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
    
    
    
    
        ((UIImageView *)view).image = [self.iCarouselItems objectAtIndex:index];
        [((UIImageView *)view) systemLayoutSizeFittingSize:CGSizeMake(300, 300)];
//        view.contentMode = UIViewContentModeCenter;
        view.contentMode = UIViewContentModeScaleAspectFit;

 
        
//    }
//    else
//    {
//        //get a reference to the label in the recycled view
//    }
    
    
    
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"Selected carousel index is %ld",(long)index);
//    self.selectedCarouselLabel.text = [NSString stringWithFormat:@"Selected Index is %ld",(long)index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Private


- (void)handleError:(NSError *)error {
    NSLog(@"Uh oh, something went wrong. You can do what you want with this %@", error);
}

#pragma mark AFNetworking

-(void)downloadEntities{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    if([self.locale isEqualToString:@"fr"]){
        [request setURL:[NSURL URLWithString:@"https://fxsj3j0ykf.execute-api.us-east-1.amazonaws.com/Test/cms/page?fields.pageId=root-home&locale=fr&include=3"]];

    }else{
        [request setURL:[NSURL URLWithString:@"https://fxsj3j0ykf.execute-api.us-east-1.amazonaws.com/Test/cms/page?fields.pageId=root-home&locale=en-US&include=3"]];

    }
    [request setHTTPMethod:@"GET"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,
                                                                                          NSURLResponse * _Nullable response,
                                                                                          NSError * _Nullable error) {
        
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        NSLog(@"%@", json);
        self.homeDictionary = json;
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           
                           [self prepareData];});
    }];
    
    [task resume];
    
  
    
    
}
-(void) downloadLogo{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *imgURl = @"https://fxsj3j0ykf.execute-api.us-east-1.amazonaws.com/Test/cms/image?fields.title=Navigation>Logo&locale=en-US&include=3";
    [request setURL:[NSURL URLWithString:[imgURl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request setHTTPMethod:@"GET"];
    
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,
                                                                                          NSURLResponse * _Nullable response,
                                                                                          NSError * _Nullable error) {
        //
        
        
        
        
        
        //
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        NSLog(@"%@", json);
        self.logoDictionary = json;
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           
                           [self addLogo];
                           [self hideUI:NO];
                           [self.hud hide:YES];
                       });
    }];
    
    [task resume];
    
  
}
-(void)addLogo{
    NSString *imageID = [[[[[[self.logoDictionary valueForKey:@"items"] valueForKey:@"fields"] valueForKey:@"image"] valueForKey:@"sys"] valueForKey:@"id"] firstObject];
    
    NSString *imageURL = [[[[[[[[self.logoDictionary valueForKey:@"includes"] valueForKey:@"Asset"] allObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"sys.id = %@",imageID]] valueForKey:@"fields"] valueForKey:@"file"] valueForKey:@"url"] firstObject];
    NSString *u = [NSString stringWithFormat:@"https:%@",imageURL ];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: u]];
    
    [self.logoView setImage:[UIImage imageWithData: imageData]];
}
-(void)prepareData{
    
    self.assetArray = [[[self.homeDictionary valueForKey:@"includes"] valueForKey:@"Asset"] allObjects];
    //    NSArray *entryArray = [[[self.homeDictionary valueForKey:@"includes"] valueForKey:@"Entry"] allObjects];
    //    NSArray *itemsArray = [[self.homeDictionary valueForKey:@"items"]  allObjects];
    NSString *titleLabel = [[[[self.homeDictionary valueForKey:@"items"] valueForKey:@"fields"] valueForKey:@"subTitle"] firstObject];
//    NSString *imageID = [[[[[[self.homeDictionary valueForKey:@"items"] valueForKey:@"fields"] valueForKey:@"image"] valueForKey:@"sys"] valueForKey:@"id"] firstObject];
    
   // NSString *imageURL = [[[[[[[[self.homeDictionary valueForKey:@"includes"] valueForKey:@"Asset"] allObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"sys.id = %@",imageID]] valueForKey:@"fields"] valueForKey:@"file"] valueForKey:@"url"] firstObject];
    self.titleLabel.text = titleLabel;
   // NSString *u = [NSString stringWithFormat:@"https:%@",imageURL ];
   // NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: u]];
    
   // [self.imageView setImage:[UIImage imageWithData: imageData]];
    
NSArray *imageURLArray =[[[[[[self.homeDictionary valueForKey:@"includes"] valueForKey:@"Asset"] valueForKey:@"fields"] valueForKey:@"file"] valueForKey:@"url"] allObjects];
    
    for(NSString *obj in imageURLArray){
        NSString *u = [NSString stringWithFormat:@"https:%@",obj ];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: u]];
        UIImage *image = [UIImage imageWithData: imageData];
        [self.iCarouselItems addObject:image];
    }
    [self.iCarouselView1 reloadData];
}








@end

