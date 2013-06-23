//
//  Product.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 22.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * price;

@end
