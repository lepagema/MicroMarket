//
//  MMProduct.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 14.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMProduct : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSDecimalNumber *price;

-(id)initWithName:(NSString*) name price:(NSDecimalNumber*) price;

@end
