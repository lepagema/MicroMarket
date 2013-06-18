//
//  MMCustomer.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 16.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MMCustomer.h"
#import "MMAmountFormatter.h"

@implementation MMCustomer

-(id)init
{
    self = [super init];
    
    if (self)
    {
        _name = @"";
        _balance = [[NSDecimalNumber alloc] initWithDouble:0.0];
    }
    
    return self;
}

-(id)initWithName:(NSString*) name balance:(NSDecimalNumber*) balance
{
    self = [super init];
    
    if (self)
    {
        _name = [name copy];
        _balance = [MMAmountFormatter roundAmount:balance];
    }
    
    return self;
}

-(id)initWithName:(NSString*) name
{
    self = [super init];
    
    if (self)
    {
        _name = [name copy];
        _balance = [[NSDecimalNumber alloc] initWithDouble:0.0];
    }
    
    return self;
}

@end
