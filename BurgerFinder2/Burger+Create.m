//
//  Burger+Create.m
//  BurgerFinder
//
//  Created by Stephen Astels on 12-08-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Burger+Create.h"

@implementation Burger (Create)

+ (Burger *)burgerWithName:(NSString *)name
      inManagedObjectContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Burger"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSError *error = nil;
    NSArray *burgers = [context executeFetchRequest:request error:&error];
    
    Burger *burger = nil;
    if (!burgers || ([burgers count] > 1)) {
        // handle error
    } else if (![burgers count]) {
        burger = [NSEntityDescription insertNewObjectForEntityForName:@"Burger"
                                                     inManagedObjectContext:context];
        burger.name = name;
    } else {
        burger = [burgers lastObject];
    }    
    return burger;
}

// --------------------------------------------------------------------------------------

-(void)addTopping:(Topping*)topping {
    self.toppingList = [self.toppingList setByAddingObject:topping];
}

// --------------------------------------------------------------------------------------

@end
