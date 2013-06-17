//
//  MMMarketDataController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 14.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MMMarketDataController.h"
#import "MMProduct.h"
#import "MMCustomer.h"

@implementation MMMarketDataController

-(id)init
{
    self = [super init];
    
    if (self)
    {
        _products = [[NSMutableArray alloc] init];
        _customers = [[NSMutableArray alloc] init];

        // Temp:
        [_products addObject:[[MMProduct alloc] initWithName:@"Menu" price:[[NSDecimalNumber alloc] initWithDouble:10.00]]];
        [_products addObject:[[MMProduct alloc] initWithName:@"Curry Cup" price:[[NSDecimalNumber alloc] initWithDouble:7.00]]];
        [_customers addObject:[[MMCustomer alloc] initWithName:@"Aurel" balance:[[NSDecimalNumber alloc] initWithDouble:20.00]]];
        [_customers addObject:[[MMCustomer alloc] initWithName:@"David" balance:[[NSDecimalNumber alloc] initWithDouble:-50.00]]];
    }
    
    return self;
}

#pragma mark - Product Table

-(NSUInteger)productCount
{
    return self.products.count;
}

-(MMProduct*)productAtIndex:(NSUInteger)index
{
    return [self.products objectAtIndex:index];
}

-(void)moveProductAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    MMProduct *product = [self.products objectAtIndex:fromIndex];
    [self.products removeObjectAtIndex:fromIndex];
    [self.products insertObject:product atIndex:toIndex];
}

-(void)removeProductAtIndex:(NSUInteger)index
{
    [self.products removeObjectAtIndex:index];
}

-(void)addProduct:(MMProduct *)product
{
    [self.products addObject:product];
}

#pragma mark - Customer Table

-(NSUInteger)customerCount
{
    return self.customers.count;
}

-(MMCustomer*)customerAtIndex:(NSUInteger)index
{
    return [self.customers objectAtIndex:index];
}

-(void)moveCustomerAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    MMCustomer *customer = [self.customers objectAtIndex:fromIndex];
    [self.customers removeObjectAtIndex:fromIndex];
    [self.customers insertObject:customer atIndex:toIndex];
}

-(void)removeCustomerAtIndex:(NSUInteger)index
{
    [self.customers removeObjectAtIndex:index];
}

-(void)addCustomer:(MMCustomer *)customer
{
    [self.customers addObject:customer];
}

@end
