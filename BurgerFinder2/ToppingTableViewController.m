//
//  ToppingTableViewController.m
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-27.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import "ToppingTableViewController.h"
#import "BurgerTableViewController.h"
#import "Topping.h"
#import "Burger.h"
#import "BF2Model.h"

@interface ToppingTableViewController ()
@end

@implementation ToppingTableViewController

// -----------------------------------------------------------------

- (void)viewDidLoad
{
    self.tableType = @"Topping";
    [super viewDidLoad];
    NSLog(@"found %lu toppings", (unsigned long)[self.inTable count]);
}

// -----------------------------------------------------------------

-(void) pressedAddToFavorites
{
    [self.model changeFavoritesFor:self.selectedItems makeFavorites:YES];
    
    [self pressedClear:nil];
    
}

-(void) pressedRemoveFromFavorites
{
    NSMutableArray *toppingsToDelete   = [[NSMutableArray alloc] init];
    NSMutableArray *toppingsToReload   = [[NSMutableArray alloc] init];
    NSMutableArray *toppingsToAdd      = [[NSMutableArray alloc] init];
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
    NSMutableArray *indexPathsToAdd    = [[NSMutableArray alloc] init];
    
    self.allowedItems = [self.model loadEntity:@"Topping" onlyFavorites:self.onlyFavorites];
    [self.model changeFavoritesFor:self.selectedItems makeFavorites:NO];
    
    for (Topping *topping in self.allowedItems) {
 //       NSInteger numberOfBurgersForTopping = [self getCountForTopping:topping];

        if ([self.selectedItems containsObject:topping]) {
            [toppingsToDelete addObject:topping];
            [indexPathsToDelete addObject:[self indexPathForTopping:topping]];
            NSLog(@"marking to delete: %@", topping.name);
        } else if(![self.inTable containsObject:topping]) {
            [toppingsToAdd addObject:topping];
            NSLog(@"marking to add: %@", topping.name);
        } else if ([self.inTable containsObject:topping]) {
            [toppingsToReload addObject:topping];
            [indexPathsToReload addObject:[self indexPathForTopping:topping]];
            NSLog(@"marking to reload: %@", topping.name);
        }
    }
    [self.inTable removeObjectsInArray:toppingsToDelete];
    [self.inTable addObjectsFromArray:toppingsToAdd];
    [self sortTableArray];
    for (Topping *topping in toppingsToAdd)
        [indexPathsToAdd addObject:[self indexPathForTopping:topping]];
    
    [self.selectedItems removeAllObjects];
    [self.selectedIndexPaths removeAllObjects];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadRowsAtIndexPaths:indexPathsToReload
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView insertRowsAtIndexPaths:indexPathsToAdd
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];




/*

    [self.model changeFavoritesFor:self.selectedItems makeFavorites:NO];

    NSMutableArray *selectedRows = [[NSMutableArray alloc] init];
    for (Topping *topping in self.selectedItems) {
        [selectedRows addObject:[NSNumber numberWithInteger:[self.inTable indexOfObject:topping]]];
    }
    NSLog(@"selected=%@", selectedRows);
    
    
    
    
    [self pressedClear:nil];
    
    
//    self.inTable = [self.model loadEntity:@"Topping" onlyFavorites:YES];
//    [self.notInTable removeAllObjects];
//    [self.tableView reloadData];

*/

}

// -----------------------------------------------------------------


-(IBAction)pressedAddRemoveFavorites:(id)sender
{
    if (self.onlyFavorites)
        [self pressedRemoveFromFavorites];
    else
        [self pressedAddToFavorites];
}

    /*
     if (self.onlyFavorites) {
     // indexpaths might be relative to table containing more rows!
     //        [self.tableView beginUpdates];
     //        [self.tableArray removeObjectsInArray:self.selectedItems];
     //        [self.tableView deleteRowsAtIndexPaths:self.selectedIndexPaths withRowAnimation:YES];
     //        [self.tableView endUpdates];
     
     } else {
     self.tableArray = [self.allowedItems mutableCopy];
     }
     [self.selectedItems removeAllObjects];
     [self.selectedIndexPaths removeAllObjects];
     
     [self.tableView reloadData];
     */

// -----------------------------------------------------------------

-(void)refreshTableData
{
    NSMutableArray *toppingsToDelete   = [[NSMutableArray alloc] init];
    NSMutableArray *toppingsToReload   = [[NSMutableArray alloc] init];
    NSMutableArray *toppingsToAdd      = [[NSMutableArray alloc] init];
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
    NSMutableArray *indexPathsToAdd    = [[NSMutableArray alloc] init];

    self.allowedItems = [self.model loadEntity:@"Topping" onlyFavorites:self.onlyFavorites];

    for (Topping *topping in self.allowedItems) {
        NSInteger numberOfBurgersForTopping = [self getCountForTopping:topping];
        if ((numberOfBurgersForTopping == 0) && ([self.inTable containsObject:topping])) {
            [toppingsToDelete addObject:topping];
            [indexPathsToDelete addObject:[self indexPathForTopping:topping]];
        } else if ((numberOfBurgersForTopping > 0) && (![self.inTable containsObject:topping])) {
            [toppingsToAdd addObject:topping];
        } else if ([self.inTable containsObject:topping]) {
            [toppingsToReload addObject:topping];
            [indexPathsToReload addObject:[self indexPathForTopping:topping]];
        }
    }
    [self.inTable removeObjectsInArray:toppingsToDelete];
    [self.inTable addObjectsFromArray:toppingsToAdd];
    [self sortTableArray];
    for (Topping *topping in toppingsToAdd)
        [indexPathsToAdd addObject:[self indexPathForTopping:topping]];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadRowsAtIndexPaths:indexPathsToReload
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView insertRowsAtIndexPaths:indexPathsToAdd
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

// -----------------------------------------------------------------

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    [segue.destinationViewController setModel:self.model];
    [segue.destinationViewController setRequiredToppings:self.selectedItems];
}

// -----------------------------------------------------------------

#pragma mark - Tableview

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Topping Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // ask NSFetchedResultsController for the NSMO at the row in question
    id item = [self.inTable objectAtIndex:indexPath.row];
    // Then configure the cell using it ...
    cell.textLabel.text = [NSString stringWithFormat:@"(%ld) %@", (long)[self getCountForTopping:item], [item name]];
    if ([self.selectedItems containsObject:item]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

// -----------------------------------------------------------------

#pragma mark - Private methods

-(void) sortTableArray
{
    [self.inTable sortUsingComparator:^NSComparisonResult(Topping *a, Topping *b) {
        return [a.name compare:b.name];
    }];
}

// -----------------------------------------------------------------

-(NSInteger) getCountForTopping:(Topping*)topping
{
    if (topping == nil)
        return [[self.model getBurgersForToppings:self.selectedItems] count];
    else {
        NSMutableArray *toppings = [self.selectedItems mutableCopy];
        [toppings addObject:topping];
        return [[self.model getBurgersForToppings:toppings] count];
    }
}

// -----------------------------------------------------------------

-(NSIndexPath*) indexPathForTopping:(Topping*)topping
{
    if (![self.inTable containsObject:topping])
        return nil;
    else
        return [NSIndexPath indexPathForRow:[self.inTable indexOfObject:topping]
                                  inSection:0];
    
}

@end
