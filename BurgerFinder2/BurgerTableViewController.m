//
//  BurgerTableViewController.m
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-26.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import "BurgerTableViewController.h"
#import "Burger.h"
#import "Topping.h"

@interface BurgerTableViewController ()
@property (nonatomic, strong) NSMutableDictionary *toppingName;
@end

// -----------------------------------------------------------------

@implementation BurgerTableViewController

-(IBAction)pressedAddRemoveFavorites:(id)sender
{
    [self.model changeFavoritesFor:self.selectedItems makeFavorites:!self.onlyFavorites];
    
    if (self.onlyFavorites) {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:self.selectedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.inTable removeObjectsInArray:self.selectedItems];
        [self.tableView endUpdates];
        [self.selectedItems removeAllObjects];
        [self.selectedIndexPaths removeAllObjects];

    } else {
        [self pressedClear:sender];
    }
}

// -----------------------------------------------------------------

-(NSMutableDictionary*)toppingName {
    if (!_toppingName) {
        _toppingName = [[NSMutableDictionary alloc] init];
        [_toppingName setObject:@"cheddar" forKey:@"cheese: cheddar"];
        [_toppingName setObject:@"blue cheese" forKey:@"cheese: blue"];
        [_toppingName setObject:@"brie" forKey:@"cheese: brie"];
        [_toppingName setObject:@"cream cheese" forKey:@"cheese: cream"];
        [_toppingName setObject:@"feta" forKey:@"cheese: feta"];
        [_toppingName setObject:@"goat cheese" forKey:@"cheese: goat"];
        [_toppingName setObject:@"gouda" forKey:@"cheese: gouda"];
        [_toppingName setObject:@"havarti" forKey:@"cheese: havarti"];
        [_toppingName setObject:@"jack cheese" forKey:@"cheese: jack"];
        [_toppingName setObject:@"swiss cheese" forKey:@"cheese: swiss"];
    }
    return _toppingName;
}

// -----------------------------------------------------------------

- (void)viewDidLoad
{
    self.tableType = @"Burger";
    [super viewDidLoad];

    if (!self.onlyFavorites) {
        self.inTable = [self.model getBurgersForToppings:self.requiredToppings];
//        self.notInTable = [self.model loadEntity:self.tableType onlyFavorites:NO];
//        [self.notInTable removeObjectsInArray:self.inTable];
    }
    NSLog(@"found %lu burgers", (unsigned long)[self.inTable count]);
}

// -----------------------------------------------------------------

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Burger Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Burger *burger = [self.inTable objectAtIndex:indexPath.row];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@"$"];
 //   NSLog(@"%@", [formatter stringFromNumber:burger.price]);
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", burger.name, [formatter stringFromNumber:burger.price]];
//    cell.textLabel.text = burger.name;
    cell.detailTextLabel.text = @"";
    // change the way "cheese: swiss, etc" is written
    for (Topping *topping in burger.toppingList) {
        NSString *name = [NSString stringWithString:topping.name];
        if ([name isEqualToString:@"cheese"]) // don't print "cheese" in list of toppings
            continue;
        if ([self.toppingName objectForKey:name])
            name = [self.toppingName objectForKey:name];
        cell.detailTextLabel.text = [cell.detailTextLabel.text stringByAppendingFormat:@"%@, ", name];
        cell.detailTextLabel.numberOfLines = 2;
    }
    cell.detailTextLabel.text = [cell.detailTextLabel.text substringToIndex:[cell.detailTextLabel.text length]-2];
    if ([self.selectedItems containsObject:burger])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;

}

@end
