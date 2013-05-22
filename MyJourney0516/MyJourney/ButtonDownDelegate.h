//
//  ButtonDownDelegate.h
//  MyJourney
//
//  Created by Aaron on 13-5-13.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>


@class BrowseViewController;


@protocol ButtonDownDelegate <NSObject>

-(void)dismissBrowseViewController:(BrowseViewController *)browse;

@end
