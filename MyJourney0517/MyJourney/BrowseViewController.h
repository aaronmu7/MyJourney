//
//  BrowseViewController.h
//  MyJourney
//
//  Created by Aaron on 13-5-13.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonDownDelegate.h"
#import "Annotation.h"

@interface BrowseViewController : UIViewController<UIScrollViewDelegate>
{
    int currentPage;
}
@property (nonatomic, assign) int type;
@property (nonatomic, assign) id<ButtonDownDelegate> delegate;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) Annotation *annotation;

@end
