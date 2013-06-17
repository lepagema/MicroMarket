//
//  MMCustomersViewController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 13.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MMCustomersViewController.h"
#import "MMMarketDataController.h"
#import "MMAmountFormatter.h"
#import "MMCustomer.h"

@interface MMCustomersViewController ()

@end

@implementation MMCustomersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController customerCount] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    double balance;
    
    if (indexPath.row == 0)
    {
        static NSString *TotalCellIdentifier = @"TotalCell";
        cell = [tableView dequeueReusableCellWithIdentifier:TotalCellIdentifier];
        
        balance = 0.0; // to init correctly
        
        [cell.detailTextLabel setText:[MMAmountFormatter textFromAmount:[[NSDecimalNumber alloc] initWithDouble:balance]]];
    }
    else
    {
        static NSString *CustomerCellIdentifier = @"CustomerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CustomerCellIdentifier];
        
        MMCustomer *customer = [self.dataController customerAtIndex:indexPath.row - 1];
        balance = customer.balance.doubleValue;
        
        [cell.textLabel setText:customer.name];
        [cell.detailTextLabel setText:[MMAmountFormatter textFromAmount:customer.balance]];
    }

    UIColor *balanceTextColor;
    if (balance >= 0.0)
    {
        balanceTextColor = [[UIColor alloc] initWithRed:0.0 green:0.5 blue:0.0 alpha:1.0];
    }
    else
    {
        balanceTextColor = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    }
    
    cell.detailTextLabel.textColor = balanceTextColor;
    
    return cell;
}

#pragma mark - Editing Table View

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataController removeCustomerAtIndex:indexPath.row - 1];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.dataController moveCustomerAtIndex:fromIndexPath.row - 1 toIndex:toIndexPath.row - 1];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    UINavigationController *navigationController = [segue destinationViewController];
//    id detailController = navigationController.topViewController;
//    
//    if ([[segue identifier] isEqualToString:@"AddProduct"])
//    {
//        [detailController setOperationType:AddProduct];
//    }
//    else if([[segue identifier] isEqualToString:@"EditProduct"])
//    {
//        [detailController setProduct:[self.dataController productAtIndex:[self.tableView indexPathForSelectedRow].row]];
//        [detailController setOperationType:EditProduct];
//    }
}

-(IBAction)done:(UIStoryboardSegue *)segue
{
//    if ([[segue identifier] isEqualToString:@"ReturnProductInput"])
//    {
//        MMProductDetailViewController * detailController = [segue sourceViewController];
//        
//        if (detailController.OperationType == AddProduct)
//        {
//            [self.dataController addProduct:detailController.product];
//        }
//        //        else if (detailController.OperationType == EditProduct)
//        //        {
//        //
//        //        }
//        
//        [self.tableView reloadData];
//        [self dismissViewControllerAnimated:YES completion:NULL];
//    }
}

-(IBAction)cancel:(UIStoryboardSegue *)segue
{
//    if ([[segue identifier] isEqualToString:@"CancelProductInput"])
//    {
//        [self dismissViewControllerAnimated:YES completion:NULL];
//    }
}

#pragma mark - Temp for debug

- (IBAction)buttonTouchUpInside:(id)sender
{
    [self.tableView reloadData];
}

@end
