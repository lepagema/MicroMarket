//
//  PurchaseTableViewCell.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 30.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "PurchaseTableViewCell.h"
#import "PurchaseItem.h"

@interface PurchaseTableViewCell()
{
}

@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UIStepper *productStepper;

+(NSString*) computeProductWithName:(NSString*)productName number:(double)number;
- (IBAction)stepperValueChanged:(id)sender;

@end

@implementation PurchaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setPurchaseItem:(PurchaseItem *)purchaseItem
{
    if (_purchaseItem != purchaseItem)
    {
        _purchaseItem = purchaseItem;
        self.productStepper.value = (double)purchaseItem.productCount;
        self.productLabel.text = [PurchaseTableViewCell computeProductWithName:purchaseItem.productName number:self.productStepper.value];
    }
}

- (IBAction)stepperValueChanged:(id)sender
{
    self.purchaseItem.productCount = self.productStepper.value;
    self.productLabel.text = [PurchaseTableViewCell computeProductWithName:self.purchaseItem.productName number:self.productStepper.value];
}

+(NSString*) computeProductWithName:(NSString*)productName number:(double)number
{
    static NSNumberFormatter *formatter = nil;
    
    if (formatter == nil)
    {
        formatter = [[NSNumberFormatter alloc] init];
    }
    
    NSNumber *productCount = [[NSNumber alloc] initWithDouble:number];
    return [[NSString alloc] initWithFormat:@"%@ %@", [formatter stringFromNumber:productCount] , productName];
}

@end
