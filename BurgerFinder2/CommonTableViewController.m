//
//  CommonTableViewController.m
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-30.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import "CommonTableViewController.h"

@interface CommonTableViewController ()
@end

@implementation CommonTableViewController

// -----------------------------------------------------------------

#pragma mark - Getters with lazy instantiation

-(NSMutableArray*)selectedItems
{
    if (!_selectedItems)
        _selectedItems = [[NSMutableArray alloc] init];
    return _selectedItems;
}

-(NSMutableArray*)selectedIndexPaths
{
    if (!_selectedIndexPaths)
        _selectedIndexPaths = [[NSMutableArray alloc]init];
    return _selectedIndexPaths;
}

-(NSArray*)allowedItems
{
    if (!_allowedItems)
        _allowedItems = [[NSArray alloc] init];
    return _allowedItems;
}

-(NSMutableArray*)inTable
{
    if (!_inTable)
        _inTable =  [[NSMutableArray alloc] init];
    return _inTable;
}

-(NSMutableArray*)notInTable
{
    if (!_notInTable)
        _notInTable = [[NSMutableArray alloc] init];
    return _notInTable;
}

// -----------------------------------------------------------------

#pragma mark - Actions

/*
-(IBAction)pressedAddRemoveFavorites:(id)sender
{    
    [self.model changeFavoritesFor:self.selectedItems makeFavorites:!self.onlyFavorites];

    self.tableArray = [self.model loadEntity:self.tableType onlyFavorites:self.onlyFavorites];
    self.allowedItems = [self.tableArray copy];
      if (self.onlyFavorites) {
// indexpaths might be relative to table containing more rows!
        [self.tableView beginUpdates];
        [self.tableArray removeObjectsInArray:self.selectedItems];
        [self.tableView deleteRowsAtIndexPaths:self.selectedIndexPaths withRowAnimation:YES];
        [self.tableView endUpdates];
    
    } else {
        self.tableArray = [self.allowedItems mutableCopy];
    }
    [self.selectedItems removeAllObjects];
    [self.selectedIndexPaths removeAllObjects];

    [self.tableView reloadData];

}
*/

// this won't recompute the topping rows (ie burger numbers)
-(IBAction)pressedAddRemoveFavorites:(id)sender
{
    NSLog(@"ERROR, this function should be overridden");
    assert(0);
    
}

// -----------------------------------------------------------------

-(IBAction)pressedClear:(id)sender
{    
    [self.selectedItems removeAllObjects];
    if ([self.tableType isEqualToString:@"Topping"])
        [self refreshTableData];
    else
        [self.tableView reloadRowsAtIndexPaths:self.selectedIndexPaths
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.selectedIndexPaths removeAllObjects];
}

// -----------------------------------------------------------------

#pragma mark - Startup

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(pressedClear:)];
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *addRemoveButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(pressedAddRemoveFavorites:)];
    
    self.toolbarItems = [NSArray arrayWithObjects:clearButton, spaceButton, addRemoveButton, nil];
    if (self.onlyFavorites) {
        self.title = @"Favorites";
        addRemoveButton.title = @"Remove From Favorites";
    } else {
        self.title = @"All";
        addRemoveButton.title = @"Add To Favorites";
    }
    
    self.inTable = [self.model loadEntity:self.tableType onlyFavorites:self.onlyFavorites];

// make notInTable empty to start
//    self.notInTable = [self.model loadEntity:self.tableType onlyFavorites:NO];
//    [self.notInTable removeObjectsInArray:self.inTable];

}

// -----------------------------------------------------------------

#pragma mark - Tableview

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    id item = [self.inTable objectAtIndex:indexPath.row];
    if ([self.selectedItems containsObject:item]) {
        [self.selectedItems removeObject:item];
        [self.selectedIndexPaths removeObject:indexPath];
    } else {
        [self.selectedItems addObject:item];
        [self.selectedIndexPaths addObject:indexPath];
    }
    if ([self.tableType isEqualToString:@"Topping"]) {
        [self refreshTableData];
//        [tableView reloadData];
    }
    else
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

// -----------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

// -----------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.inTable count];
}

// -----------------------------------------------------------------

#pragma mark - This gets overridden if desired

-(void)refreshTableData
{
}

@end
