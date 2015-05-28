//
//  MapViewController.h
//  TopPics
//
//  Created by Stephen Astels on 12-08-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@class MapViewController;

@protocol MapViewControllerDelegate <NSObject>

-(UIImage*)mapViewController:(MapViewController*)sender imageForAnnotation:(id <MKAnnotation>)annotation;

@end
@interface MapViewController : UIViewController

@property (nonatomic, strong) NSArray *annotations; // of id <MKAnnotations>
@property (nonatomic, weak) id <MapViewControllerDelegate> delegate;

@end
