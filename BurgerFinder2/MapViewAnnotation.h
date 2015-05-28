//
//  BFMapViewAnnotation.h
//  BurgerFinder
//
//  Created by Stephen Astels on 12-09-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface MapViewAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *annotationTitle;
@property (strong, nonatomic) NSString *annotationSubtitle;
@property (nonatomic) CLLocationCoordinate2D annotationCoordinate;

@end
