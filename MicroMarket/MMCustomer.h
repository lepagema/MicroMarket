//
//  MMCustomer.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 16.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMCustomer : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSDecimalNumber *balance;

-(id)initWithName:(NSString*) name balance:(NSDecimalNumber*) balance;

@end
