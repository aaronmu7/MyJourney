//
//  FrontPageViewController.m
//  MyJourney
//
//  Created by Aaron on 13-5-13.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import "FrontPageViewController.h"
#import "MainMapViewController.h"

@interface FrontPageViewController ()

@end

@implementation FrontPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *beginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    beginButton.frame = CGRectMake(50, 100, 100, 30);
    beginButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:beginButton];
    [beginButton addTarget:self action:@selector(gotoMain) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)gotoMain
{
    MainMapViewController *main = [[MainMapViewController alloc]init];
    [self.navigationController pushViewController:main animated:YES];
    [main release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
