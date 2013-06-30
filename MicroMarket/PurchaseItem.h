//
//  PurchaseItem.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 30.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseItem : NSObject

@property (strong, nonatomic) NSString *productName;
@property (nonatomic) NSInteger productCount;

@end
