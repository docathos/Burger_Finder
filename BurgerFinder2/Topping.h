//
//  Topping.h
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-26.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Burger;

@interface Topping : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSSet *burgerList;
@end

@interface Topping (CoreDataGeneratedAccessors)

- (void)addBurgerListObject:(Burger *)value;
- (void)removeBurgerListObject:(Burger *)value;
- (void)addBurgerList:(NSSet *)values;
- (void)removeBurgerList:(NSSet *)values;

@end
