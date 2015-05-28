//
//  BF2AppDelegate.h
//  BurgerFinder2
//
//  Created by Steve Astels on 2012-09-26.
//  Copyright (c) 2012 Steve Astels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BF2AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
