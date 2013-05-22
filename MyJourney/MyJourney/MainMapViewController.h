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



@interface MainMapViewController : UIViewController<ButtonDownDelegate, CLLocationManagerDelegate, MKMapViewDelegate>
{
    MKMapView *mapView;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;//当前位置
    
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
    UIButton *recordFuncButton;
    
    //左右按钮列是否已经展开
    BOOL leftShow;
    BOOL rightShow;
}
@end
