//
//  Burger.h
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-26.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Topping;

@interface Burger : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSSet *toppingList;
@end

@interface Burger (CoreDataGeneratedAccessors)

- (void)addToppingListObject:(Topping *)value;
- (void)removeToppingListObject:(Topping *)value;
- (void)addToppingList:(NSSet *)values;
- (void)removeToppingList:(NSSet *)values;

@end
