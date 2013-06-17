//
//  MMAmountFormatter.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 16.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MMAmountFormatter.h"

@implementation MMAmountFormatter

+(NSDecimalNumber*)roundAmount:(NSDecimalNumber*)amount
{
    NSDecimalNumberHandler * decimalHandler = [[NSDecimalNumberHandler alloc]
                                               initWithRoundingMode:NSRoundBankers
                                               scale:2
                                               raiseOnExactness:NO
                                               raiseOnOverflow:NO
                                               raiseOnUnderflow:NO
                                               raiseOnDivideByZero:NO];
    
    return [amount decimalNumberByRoundingAccordingToBehavior:decimalHandler];
}

+(NSString*)textFromAmount:(NSDecimalNumber*)amount;
{
    return [NSNumberFormatter localizedStringFromNumber:amount numberStyle:NSNumberFormatterCurrencyStyle];
}

+(NSString*)editTextFromAmount:(NSDecimalNumber*)amount;
{
    static NSNumberFormatter *formatter = nil;
    
    if (formatter == nil)
    {
        formatter = [[NSNumberFormatter alloc] init];
        formatter.maximumFractionDigits = 2;
        formatter.minimumFractionDigits = 2;
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    
    return [formatter stringFromNumber:amount];
}

+(NSDecimalNumber*)amountFromEditText:(NSString*)editText;
{
    return [MMAmountFormatter roundAmount:[[NSDecimalNumber alloc] initWithString:editText]];
}

+(NSString*)reformatEditText:(NSString*)editText
{
    return [MMAmountFormatter editTextFromAmount:[MMAmountFormatter amountFromEditText:editText]];
}

@end
