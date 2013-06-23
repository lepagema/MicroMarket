//
//  AmountFormatter.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 16.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmountFormatter : NSObject

+(NSString*)textFromAmount:(NSDecimalNumber*)amount;
+(NSString*)editTextFromAmount:(NSDecimalNumber*)amount;
+(NSDecimalNumber*)amountFromEditText:(NSString*)editText;
+(NSString*)reformatEditText:(NSString*)editText;
+(NSDecimalNumber*)roundAmount:(NSDecimalNumber*)amount;

@end
