//
//  MenuViewController.m
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-27.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import "MenuViewController.h"
#import "BurgerTableViewController.h"
#import "BF2DatabaseUtilities.h"
#import "MapViewController.h"
#import "MapViewAnnotation.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.model = [[BF2Model alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    NSLog(@"Segue ftw %@!", sender.textLabel.text);

    if ([sender.textLabel.text isEqualToString:@"Ottawa"]) {
/*        MapViewController *mapVC = segue.destinationViewController;
        NSMutableArray *annotations = [[NSMutableArray alloc] init];
        MapViewAnnotation *annotation = [[MapViewAnnotation alloc] init];
        annotation.annotationTitle = @"Westboro";
        annotation.annotationCoordinate = CLLocationCoordinate2DMake(45.39225, -75.75328);
        [annotations addObject:annotation];
        mapVC.annotations = annotations;
*/        
    } else {
        [segue.destinationViewController setModel:self.model];
        if ([sender.textLabel.text isEqualToString:@"Favorites"])
            [segue.destinationViewController setOnlyFavorites:YES];
        else
            [segue.destinationViewController setOnlyFavorites:NO];
    }
}


@end
