//
//  CommonTableViewController.h
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-30.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BF2Model.h"

@interface CommonTableViewController : UITableViewController
@property (nonatomic, strong) NSString *tableType;
@property (nonatomic, strong) BF2Model *model;
@property (nonatomic, strong) NSMutableArray *inTable;
@property (nonatomic, strong) NSMutableArray *notInTable;
@property (nonatomic) BOOL onlyFavorites;

@property (nonatomic, strong) NSMutableArray *selectedItems;
@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;
@property (nonatomic, strong) NSArray *allowedItems;

-(void)refreshTableData;
-(IBAction)pressedClear:(id)sender;

@end
