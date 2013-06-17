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

@end
