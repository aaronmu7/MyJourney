//
//  MainMapViewController.h
//  MyJourney
//
//  Created by Aaron on 13-5-13.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonDownDelegate.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"



@interface MainMapViewController : UIViewController<ButtonDownDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    MKMapView *mapView;
    CLLocationManager *locationManager;
    
    UIButton *pictureButton;
    UIButton *noteButton;
    UIButton *recordButton;
    
    //左按键列表 增删改查
    UIButton *addButton;
    UIButton *subtractButton;
    UIButton *pauseButton;
    
    //右 拍照笔记录音
    UIButton *picFuncButton;
    UIButton *noteFuncButton;
    UIButton *audioFuncButton;
    UIButton *videoFuncButton;
    
    //左右按钮列是否已经展开
    BOOL leftShow;
    BOOL rightShow;
    
    NSUserDefaults *userDefaults;
}

@property (nonatomic, retain) CLLocation *currentLocation;//当前位置
@property (nonatomic, retain) CLLocation *lastPinLocation;//最后一棵大头针的坐标
@property (nonatomic, assign) BOOL isContinue;
@property (nonatomic, retain) NSMutableDictionary *infoDic;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) Annotation *currentAnnotation;


-(id)initWithIsContinue:(BOOL)isContinue;
@end
