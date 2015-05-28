//
//  BF2DatabaseUtilities.h
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-26.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BF2DatabaseUtilities : NSObject

+ (void)fetchMenuIntoContext:(NSManagedObjectContext*)context;

@end
