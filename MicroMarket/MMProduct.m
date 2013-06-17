//
//  MMProduct.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 14.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MMProduct.h"
#import "MMAmountFormatter.h"

@interface MMProduct()
{
}

@end


@implementation MMProduct

-(id)initWithName:(NSString*) name price:(NSDecimalNumber*) price
{
    self = [super init];
    
    if (self)
    {
        _name = [name copy];
        _price = [MMAmountFormatter roundAmount:price];
    }
    
    return self;
}

@end
