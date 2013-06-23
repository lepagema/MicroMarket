//
//  AppDelegate.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 13.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketDataController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MarketDataController *dataController;


//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//
//- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;

@end
