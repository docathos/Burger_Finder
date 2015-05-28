//
//  Topping+Create.m
//  BurgerFinder
//
//  Created by Stephen Astels on 12-08-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Topping+Create.h"

@implementation Topping (Create)

+ (Topping *)toppingWithName:(NSString *)name
      inManagedObjectContext:(NSManagedObjectContext *)context {
    Topping *topping = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Topping"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *toppings = [context executeFetchRequest:request error:&error];
    
    if (!toppings || ([toppings count] > 1)) {
        // handle error
    } else if (![toppings count]) {
        topping = [NSEntityDescription insertNewObjectForEntityForName:@"Topping"
                                                     inManagedObjectContext:context];
        topping.name = name;
    } else {
        topping = [toppings lastObject];
    }
    return topping; 
}

@end
