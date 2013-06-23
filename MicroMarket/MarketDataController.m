//
//  MarketDataController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 14.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "MarketDataController.h"
#import "Product.h"
#import "Customer.h"
#import "ProductEntity.h"
#import "CustomerEntity.h"


@interface MarketDataController()
{
    NSMutableArray *products;
    NSMutableArray *customers;

    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
    NSURL *applicationDocumentsDirectory;
}

@end

@implementation MarketDataController

-(id)init
{
    self = [super init];
    
    if (self)
    {
        applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MicroMarket" withExtension:@"momd"];
        managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"MicroMarket.sqlite"];
        NSError *error = nil;
        persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: managedObjectModel];
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             Typical reasons for an error here include:
             * The persistent store is not accessible;
             * The schema for the persistent store is incompatible with current managed object model.
             Check the error message to determine what the actual problem was.
        
             If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
        
             If you encounter schema incompatibility errors during development, you can reduce their frequency by:
             * Simply deleting the existing store:
             [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
        
             * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
             @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
        
             Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
             */
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
            
            error = nil;
            if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
            {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
        
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];

        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ProductEntity" inManagedObjectContext:managedObjectContext];
        [request setEntity:entity];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
        
        error = nil;
        NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
        if (mutableFetchResults == nil)
        {
            // Handle the error.
        }

        products = mutableFetchResults;

        request = [[NSFetchRequest alloc] init];
        entity = [NSEntityDescription entityForName:@"CustomerEntity" inManagedObjectContext:managedObjectContext];
        [request setEntity:entity];
        
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
        sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
        
        error = nil;
        mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
        if (mutableFetchResults == nil)
        {
            // Handle the error.
        }
        
        customers = mutableFetchResults;        
    }
    
    return self;
}


#pragma mark - Product Table

-(NSUInteger)productCount
{
    return products.count;
}

-(Product*)productAtIndex:(NSUInteger)index
{
    return [products objectAtIndex:index];
}

-(void)moveProductAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    ProductEntity *product = [products objectAtIndex:fromIndex];
    [products removeObjectAtIndex:fromIndex];
    [products insertObject:product atIndex:toIndex];
    
    [self saveData];
}

-(void)removeProductAtIndex:(NSUInteger)index
{
    NSManagedObject *productToDelete = [products objectAtIndex:index];
    [managedObjectContext deleteObject:productToDelete];
    [products removeObjectAtIndex:index];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
}

-(void)addProductWithName:(NSString *)name price:(NSDecimalNumber *)price
{
    ProductEntity *product = (ProductEntity *)[NSEntityDescription insertNewObjectForEntityForName:@"ProductEntity" inManagedObjectContext:managedObjectContext];

    product.name = name;
    product.price = price;
    product.index = [[NSNumber alloc] initWithUnsignedInteger:products.count];
    
    [products addObject:product];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
}


#pragma mark - Customer Table

-(NSUInteger)customerCount
{
    return customers.count;
}

-(Customer*)customerAtIndex:(NSUInteger)index
{
    return [customers objectAtIndex:index];
}

-(void)moveCustomerAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    CustomerEntity *customer = [customers objectAtIndex:fromIndex];
    [customers removeObjectAtIndex:fromIndex];
    [customers insertObject:customer atIndex:toIndex];
    
    [self saveData];
}

-(void)removeCustomerAtIndex:(NSUInteger)index
{
    NSManagedObject *customerToDelete = [customers objectAtIndex:index];
    [managedObjectContext deleteObject:customerToDelete];
    [customers removeObjectAtIndex:index];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
}

-(void) addCustomerWithName:(NSString *)name
{
    CustomerEntity *customer = (CustomerEntity *)[NSEntityDescription insertNewObjectForEntityForName:@"CustomerEntity" inManagedObjectContext:managedObjectContext];
    
    customer.name = name;
    customer.balance = [[NSDecimalNumber alloc] initWithDouble:0.00];
    customer.index = [[NSNumber alloc] initWithUnsignedInteger:customers.count];
    
    [customers addObject:customer];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
}


#pragma mark - Context management

-(void)saveData
{
    int i = 0;
    for (ProductEntity* product in products) {
        product.index = [[NSNumber alloc] initWithInt:i];
        i++;
    }
    
    i = 0;
    for (CustomerEntity* customer in customers) {
        customer.index = [[NSNumber alloc] initWithInt:i];
        i++;
    }
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
}

@end
