//
//  BF2DatabaseUtilities.m
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-26.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import "BF2DatabaseUtilities.h"
#import "Burger.h"
#import "Burger+Create.h"
#import "Topping.h"
#import "Topping+Create.h"


@implementation BF2DatabaseUtilities

// -------------------------------------------------------------------------------------------------------

+ (void)fetchMenuIntoContext:(NSManagedObjectContext *)context
{
    NSLog(@"fetching menu into database..");
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"menu_modified" ofType:@"txt"];
    assert(filePath);
    NSString *wholeFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    for (NSString *line in [wholeFile componentsSeparatedByString:@"\n"]) {
        
 //       NSLog(@"line=<%@>", line);
        NSMutableArray *lineArray = [[line componentsSeparatedByString:@" / "] mutableCopy];
        NSString *burgerName = [lineArray objectAtIndex:0];
        NSString *burgerPrice = [lineArray lastObject];
        if ([burgerName length] > 0) {
            [lineArray removeObjectAtIndex:0];
            [lineArray removeLastObject];
            NSString *toppingString = [[lineArray lastObject] mutableCopy];
            NSArray *toppingList = [toppingString componentsSeparatedByString:@", "];
            
            Burger *burger = [Burger burgerWithName:burgerName inManagedObjectContext:context];
            for (NSString *toppingName in toppingList) {
                NSRange rangeOfCheese = [toppingName rangeOfString:@"cheese"];
                if (rangeOfCheese.location != NSNotFound) { // add "cheese" as a topping
                    Topping *topping = [Topping toppingWithName:@"cheese" inManagedObjectContext:context];
                    [burger addTopping:topping];
                }
                Topping *topping = [Topping toppingWithName:toppingName inManagedObjectContext:context];
                [burger addTopping:topping];
            }
            burger.price = [NSNumber numberWithFloat:[burgerPrice floatValue]];
        }
    }
    [Topping toppingWithName:@"cheese" inManagedObjectContext:context];
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Handle the error.
    }
}


@end
