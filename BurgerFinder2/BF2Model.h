//
//  BF2Model.h
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-28.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BF2Model : NSObject
//@property (nonatomic, strong) NSSet *selectedToppings;
//@property (nonatomic, strong) NSSet *selectedBurgers;
//@property (nonatomic, strong) NSSet *matchingBurgers;


-(NSMutableArray*)loadEntity:(NSString*)entityName onlyFavorites:(BOOL)onlyFavorites;

-(NSMutableArray*)getBurgersForToppings:(NSArray*)toppings;

-(void)changeFavoritesFor: (NSArray*)changeArray makeFavorites:(BOOL)makeFavorites;

@end
