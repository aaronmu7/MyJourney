//
//  Annotation.h
//  MyJourney
//
//  Created by Aaron on 13-5-14.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<MapKit/MapKit.h>


@interface Annotation : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;


@end
