//
//  BrowseViewController.m
//  MyJourney
//
//  Created by Aaron on 13-5-13.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import "BrowseViewController.h"

@interface BrowseViewController ()

@end


@implementation BrowseViewController
@synthesize type = _type;
@synthesize delegate = _delegate;

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

@end
