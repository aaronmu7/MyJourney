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
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
