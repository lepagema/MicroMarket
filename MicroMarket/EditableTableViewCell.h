//
//  EditableTableViewCell.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 30.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditableTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;

@end
