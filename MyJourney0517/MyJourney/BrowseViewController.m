//
//  BrowseViewController.m
//  MyJourney
//
//  Created by Aaron on 13-5-13.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import "BrowseViewController.h"
#import "Annotation.h"

@interface BrowseViewController ()

@end


@implementation BrowseViewController
@synthesize type = _type;
@synthesize delegate = _delegate;
@synthesize path = _path;
@synthesize annotation = _annotation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -UITableViewDelegate-

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.type == 0) {
        self.view.backgroundColor = PICTURE_COLOR;
    }
    else if (self.type == 1)
    {
        self.view.backgroundColor = NOTE_COLOR;
    }
    else
    {
        self.view.backgroundColor = RECORD_COLOR;
    }
    
    //退回手势，向下
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(gotoBack)];
    gesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:gesture];
    
    //加载图片
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    scrollView.contentSize = CGSizeMake(320 * self.annotation.pictureArray.count, 320);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:scrollView];
    [scrollView release];
    scrollView.delegate = self;
    
    //功能键
    UIButton *functionButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    functionButton.frame = CGRectMake(260, self.view.frame.size.height - 60, 40, 40);
    [self.view addSubview:functionButton];
    [functionButton addTarget:self action:@selector(function:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)gotoBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate dismissBrowseViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark -UIScrollViewDelegate-
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //currentPage = scrollView.contentOffset.x / 320;
    currentPage = targetContentOffset->x / 320;
    
    [self loadImageAtPage:currentPage];
    if (currentPage + 1 <= self.annotation.pictureArray.count) {
        [self loadImageAtPage:currentPage + 1];
    }
    if (currentPage - 1 >= 0) {
        [self loadImageAtPage:currentPage - 1];
    }
    for (UIImageView *imageView in scrollView.subviews) {
        if (imageView.tag > currentPage + 1 || imageView.tag < currentPage - 1) {
            [imageView removeFromSuperview];
        }
    }
    
    
}

-(void)loadImageAtPage:(int) page
{
    NSData *imageData = [[NSData alloc]initWithContentsOfFile:[[self.annotation.pictureArray objectAtIndex:page] valueForKey:@"path"]];
    UIImage *image = [[UIImage alloc]initWithData:imageData];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(page * 320 + 10, 10, 300, 300)];
    imageView.tag = page;
    [imageView setImage:image];
    [image release];

}

#pragma mark -右下功能按钮-
-(void)function:(UIButton *)sender
{
    
}


@end
