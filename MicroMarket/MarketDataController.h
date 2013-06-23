//
//  MarketDataController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 14.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;
@class Customer;

@interface MarketDataController : NSObject

-(NSUInteger)productCount;
-(Product*)productAtIndex:(NSUInteger)index;
-(void)moveProductAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(void)removeProductAtIndex:(NSUInteger)index;
-(void)addProductWithName:(NSString*)name price:(NSDecimalNumber*)price;

-(NSUInteger)customerCount;
-(Customer*)customerAtIndex:(NSUInteger)index;
-(void)moveCustomerAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(void)removeCustomerAtIndex:(NSUInteger)index;
-(void)addCustomerWithName:(NSString*)name;

-(void)saveData;

@end
