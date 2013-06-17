//
//  MMMarketDataController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 14.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMProduct;
@class MMCustomer;

@interface MMMarketDataController : NSObject

@property (nonatomic, copy) NSMutableArray *products;
@property (nonatomic, copy) NSMutableArray *customers;

-(NSUInteger)productCount;
-(MMProduct*)productAtIndex:(NSUInteger)index;
-(void)moveProductAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(void)removeProductAtIndex:(NSUInteger)index;
-(void)addProduct:(MMProduct*)product;

-(NSUInteger)customerCount;
-(MMCustomer*)customerAtIndex:(NSUInteger)index;
-(void)moveCustomerAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(void)removeCustomerAtIndex:(NSUInteger)index;
-(void)addCustomer:(MMCustomer*)customer;

@end
