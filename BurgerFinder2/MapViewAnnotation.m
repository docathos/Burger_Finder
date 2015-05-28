//
//  MapViewAnnotation.m
//  BurgerFinder
//
//  Created by Stephen Astels on 12-09-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

- (NSString*) title
{
    return self.annotationTitle;
}

-(NSString*) subtitle
{
    return self.annotationSubtitle;
}

-(CLLocationCoordinate2D) coordinate
{
    return self.annotationCoordinate;
}


@end
