//
//  Topping+Create.h
//  BurgerFinder
//
//  Created by Stephen Astels on 12-08-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Topping.h"

#define TOPPING_WANTED     2
#define TOPPING_NOT_WANTED 1
#define TOPPING_DONT_CARE  0

@interface Topping (Create)

+ (Topping *)toppingWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context;

@end
