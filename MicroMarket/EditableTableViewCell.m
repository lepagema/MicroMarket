//
//  EditableTableViewCell.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 30.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "EditableTableViewCell.h"

@implementation EditableTableViewCell

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

@end
