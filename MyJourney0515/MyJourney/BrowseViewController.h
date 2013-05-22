//
//  BrowseViewController.h
//  MyJourney
//
//  Created by Aaron on 13-5-13.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonDownDelegate.h"


@interface BrowseViewController : UIViewController
@property (nonatomic, assign) int type;
@property (nonatomic, assign) id<ButtonDownDelegate> delegate;
@end
