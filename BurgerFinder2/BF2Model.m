//
//  BF2Model.m
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-28.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import "BF2Model.h"
#import "Topping.h"
#import "Topping+Create.h"
#import "Burger.h"
#import "Burger+Create.h"

@interface BF2Model ()

@property (nonatomic, strong) NSManagedObjectContext *databaseContext;
@end

@implementation BF2Model

#pragma mark - Initialization

// -----------------------------------------------------------------

-(BF2Model*) init
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    self.databaseContext = [appDelegate managedObjectContext];
    
    // only if database is empty?
    [self fetchMenuIntoDatabase];
    return self;
}

#pragma mark - Get entries from database

// -----------------------------------------------------------------

-(NSMutableArray*)loadEntity:(NSString*)entityName
               onlyFavorites:(BOOL)onlyFavorites
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.databaseContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    if (onlyFavorites)
        request.predicate = [NSPredicate predicateWithFormat:@"isFavorite=1"];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.databaseContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
    }
    return mutableFetchResults;
}

// -----------------------------------------------------------------

-(NSMutableArray*)getBurgersForToppings:(NSArray*)toppings
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Burger"];
    if ([toppings count]) {
        NSString *predicateString = @"";
        for (Topping *topping in toppings) {
            if (![predicateString isEqualToString:@""])
                predicateString = [predicateString stringByAppendingFormat:@" AND "];
            predicateString = [predicateString stringByAppendingFormat:@"toppingList.name contains \"%@\"",topping.name];
        }
        request.predicate = [NSPredicate predicateWithFormat:predicateString];
    }    
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)]];    
    return [[self.databaseContext executeFetchRequest:request error:nil] mutableCopy];
}

// -----------------------------------------------------------------

#pragma mark - Change database entries

-(void) changeFavoritesFor:(NSArray *)changeArray makeFavorites:(BOOL)makeFavorites
{
    for (id object in changeArray) {
        if (makeFavorites)
            [object setIsFavorite:[NSNumber numberWithBool:YES]];
        else
            [object setIsFavorite:[NSNumber numberWithBool:NO]];
    }
    NSError *error = nil;
    if (![self.databaseContext save:&error]) {
        NSLog(@"Model database save error!");
    }

}

// -----------------------------------------------------------------



#pragma mark - Private Methods

-(void)fetchMenuIntoDatabase
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
            
            Burger *burger = [Burger burgerWithName:burgerName inManagedObjectContext:self.databaseContext];
            for (NSString *toppingName in toppingList) {
                NSRange rangeOfCheese = [toppingName rangeOfString:@"cheese"];
                if (rangeOfCheese.location != NSNotFound) { // add "cheese" as a topping
                    Topping *topping = [Topping toppingWithName:@"cheese" inManagedObjectContext:self.databaseContext];
                    [burger addTopping:topping];
                }
                Topping *topping = [Topping toppingWithName:toppingName inManagedObjectContext:self.databaseContext];
                [burger addTopping:topping];
            }
            burger.price = [NSNumber numberWithFloat:[burgerPrice floatValue]];
        }
    }
    [Topping toppingWithName:@"cheese" inManagedObjectContext:self.databaseContext];
    
    NSError *error = nil;
    if (![self.databaseContext save:&error]) {
        NSLog(@"Model database save error!");
    }
}

// -----------------------------------------------------------------

// -----------------------------------------------------------------

// -----------------------------------------------------------------

// -----------------------------------------------------------------

// -----------------------------------------------------------------

// -----------------------------------------------------------------

// -----------------------------------------------------------------


@end
