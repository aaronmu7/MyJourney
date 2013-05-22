//
//  MainMapViewController.m
//  MyJourney
//
//  Created by Aaron on 13-5-13.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import "MainMapViewController.h"
#import "BrowseViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NoteView.h"

@interface MainMapViewController ()


@end

@implementation MainMapViewController
@synthesize currentLocation = _currentLocation;

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
    //地图

    mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    mapView.mapType = MKMapTypeSatellite;
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    [mapView release];
    
    if ([CLLocationManager locationServicesEnabled] == YES)
    {
        NSLog(@"定位服务正常");
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    }
    else
    {
        NSLog(@"定位服务异常");
    }

    
    //下方三浏览按钮
    pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureButton.tag = 0;
    pictureButton.frame = CGRectMake(20, self.view.frame.size.height - 30, 80, 30);
    pictureButton.backgroundColor = PICTURE_COLOR;
    [self.view addSubview:pictureButton];
    [pictureButton addTarget:self action:@selector(gotoBrowse:) forControlEvents:UIControlEventTouchUpInside];
    
    noteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noteButton.tag = 1;
    noteButton.frame = CGRectMake(120, self.view.frame.size.height - 30, 80, 30);
    noteButton.backgroundColor = NOTE_COLOR;
    [self.view addSubview:noteButton];
    [noteButton addTarget:self action:@selector(gotoBrowse:) forControlEvents:UIControlEventTouchUpInside];
    
    recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recordButton.tag = 2;
    recordButton.frame = CGRectMake(220, self.view.frame.size.height - 30, 80, 30);
    recordButton.backgroundColor = RECORD_COLOR;
    [self.view addSubview:recordButton];
    [recordButton addTarget:self action:@selector(gotoBrowse:) forControlEvents:UIControlEventTouchUpInside];
    
    //左按钮群
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:addButton];
    addButton.backgroundColor = [UIColor blueColor];
    [addButton addTarget:self action:@selector(addAnnotation) forControlEvents:UIControlEventTouchUpInside];
    
    subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subtractButton.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:subtractButton];
    subtractButton.backgroundColor = [UIColor grayColor];
    
    pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseButton.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:pauseButton];
    pauseButton.backgroundColor = [UIColor blackColor];
    
    
    //上方实时功能按钮，左：节点的增删改查，右：插入照片等
    leftShow = NO;
    UIButton *leftFunction = [UIButton buttonWithType:UIButtonTypeCustom];
    leftFunction.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:leftFunction];
    leftFunction.backgroundColor = [UIColor orangeColor];
    [leftFunction addTarget:self action:@selector(leftUnfold) forControlEvents:UIControlEventTouchUpInside];
    
    //右按钮群
    picFuncButton = [UIButton buttonWithType:UIButtonTypeCustom];
    picFuncButton.frame = CGRectMake(270, 0, 50, 50);
    [self.view addSubview:picFuncButton];
    picFuncButton.backgroundColor = [UIColor blueColor];
    [picFuncButton addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    
    noteFuncButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noteFuncButton.frame = CGRectMake(270, 0, 50, 50);
    [self.view addSubview:noteFuncButton];
    noteFuncButton.backgroundColor = [UIColor yellowColor];
    [noteFuncButton addTarget:self action:@selector(takeNote:) forControlEvents:UIControlEventTouchUpInside];
    
    recordFuncButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recordFuncButton.frame = CGRectMake(270, 0, 50, 50);
    [self.view addSubview:recordFuncButton];
    recordFuncButton.backgroundColor = [UIColor lightGrayColor];
    
    rightShow = NO;
    UIButton *rightFunction = [UIButton buttonWithType:UIButtonTypeCustom];
    rightFunction.frame = CGRectMake(270, 0, 50, 50);
    [self.view addSubview:rightFunction];
    rightFunction.backgroundColor = [UIColor purpleColor];
    [rightFunction addTarget:self action:@selector(rightUnfold) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -上方两按钮动画-
-(void)leftUnfold
{
    if (leftShow == NO) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.4];
        addButton.frame = CGRectMake(60, 0, 50, 50);
        subtractButton.frame = CGRectMake(120, 0, 50, 50);
        pauseButton.frame = CGRectMake(180, 0, 50, 50);        
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5];
        addButton.frame = CGRectMake(0, 0, 50, 50);
        subtractButton.frame = CGRectMake(0, 0, 50, 50);
        pauseButton.frame = CGRectMake(0, 0, 50, 50);
        [UIView commitAnimations];
    }
    leftShow = !leftShow;
}

-(void)rightUnfold
{
    if (rightShow == NO) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5];
        picFuncButton.frame = CGRectMake(270, 50, 50, 50);
        noteFuncButton.frame = CGRectMake(270, 100, 50, 50);
        recordFuncButton.frame = CGRectMake(270, 150, 50, 50);
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5];
        picFuncButton.frame = CGRectMake(270, 0, 50, 50);
        noteFuncButton.frame = CGRectMake(270, 0, 50, 50);
        recordFuncButton.frame = CGRectMake(270, 0, 50, 50);
        [UIView commitAnimations];
    }
    rightShow = !rightShow;
}




#pragma mark -下方三媒体功能键-
-(void)gotoBrowse:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    sender.frame = CGRectMake(sender.frame.origin.x, -30, sender.frame.size.width, sender.frame.size.height);
    [UIView commitAnimations];
    
    
    BrowseViewController *browse = [[BrowseViewController alloc]init];
    browse.delegate = self;
    browse.type = sender.tag;
    [self presentViewController:browse animated:YES completion:nil];
}
#pragma mark -ButtonDownDelegate-
-(void)dismissBrowseViewController:(BrowseViewController *)browse
{
    UIButton *theButton;
    if (browse.type == 0) {
        theButton = pictureButton;
    }
    else if (browse.type == 1)
    {
        theButton = noteButton;
    }
    else{
        theButton = recordButton;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    theButton.frame = CGRectMake(theButton.frame.origin.x, self.view.frame.size.height - 30, theButton.frame.size.width, theButton.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark -CLLocationManagerDelegate-
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"AAA");
    MKCoordinateRegion region;
    self.currentLocation = newLocation;
    region.center = newLocation.coordinate;
    region.span.latitudeDelta = .01;
    region.span.longitudeDelta = .01;
    [mapView setRegion:region animated:YES];
}

#pragma mark -添加大头针-
-(void)addAnnotation
{
    if ([self.currentLocation distanceFromLocation:self.lastPinLocation] >= 10.0 || !self.lastPinLocation) {
        Annotation *annotation = [[Annotation alloc]init];
        
        [annotation setCoordinate:self.currentLocation.coordinate];
        self.lastPinLocation = self.currentLocation;
        //annotation.coordinate = self.currentLocation.coordinate;
        [mapView addAnnotation:annotation];
        [mapView selectAnnotation:annotation animated:YES];
    }
    
}


#pragma mark -MapViewDelegate-
- (MKPinAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation.title isEqualToString:@"Current Location"] == YES) {
        return nil;
    }
    
    MKPinAnnotationView *annotationView =(MKPinAnnotationView *) [aMapView dequeueReusableAnnotationViewWithIdentifier:@"map"];
    if (annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"map"];
    }
    
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    annotationView.pinColor = MKPinAnnotationColorGreen;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    btn.frame = CGRectMake(0, 0, 30, 30);
    annotationView.rightCalloutAccessoryView = btn;
    [btn addTarget:self action:@selector(rightTip:) forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = btn;

    //Image
    UIImage *flagImage = [UIImage imageNamed:@"flag.png"];
    
    CGRect resizeRect;
    
    resizeRect.size = flagImage.size;
    CGSize maxSize = CGRectInset(self.view.bounds, 10.0, 10.0).size;
    maxSize.height -= self.navigationController.navigationBar.frame.size.height + 40.0;
    if (resizeRect.size.width > maxSize.width)
        resizeRect.size = CGSizeMake(maxSize.width, resizeRect.size.height / resizeRect.size.width * maxSize.width);
    if (resizeRect.size.height > maxSize.height)
        resizeRect.size = CGSizeMake(resizeRect.size.width / resizeRect.size.height * maxSize.height, maxSize.height);
    
    resizeRect.origin = (CGPoint){0.0f, 0.0f};
    UIGraphicsBeginImageContext(resizeRect.size);
    [flagImage drawInRect:resizeRect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    annotationView.image = resizedImage;
    annotationView.opaque = NO;
    //annotationView.backgroundColor = [UIColor redColor];
    
    //annotationView.image = [UIImage imageNamed:@"flag.png"];
    return annotationView;
}

#pragma mark -照相-
-(void)takePicture:(UIButton *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
        //imagePC.modalTransitionStyle = 3;
        [self presentViewController:imagePicker animated:YES completion:nil];
        [imagePicker release];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -记笔记-
-(void)takeNote:(UIButton *)sender
{
    NoteView *noteView = [[NoteView alloc]init];
    [self.view addSubview:noteView];
    [noteView release];
}


@end
