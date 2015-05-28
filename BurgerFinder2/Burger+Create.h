//
//  Burger+Create.h
//  BurgerFinder
//
//  Created by Stephen Astels on 12-08-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Burger.h"

@interface Burger (Create)

+ (Burger *)burgerWithName:(NSString *)name
      inManagedObjectContext:(NSManagedObjectContext *)context;

-(void)addTopping:(Topping*)topping;

@end
