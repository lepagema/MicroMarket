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
#import "MMAddCustomerDetailViewController.h"

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
    return [self.dataController customerCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomerCellIdentifier = @"CustomerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomerCellIdentifier];
        
    MMCustomer *customer = [self.dataController customerAtIndex:indexPath.row];
    double balance = customer.balance.doubleValue;
        
    [cell.textLabel setText:customer.name];
    [cell.detailTextLabel setText:[MMAmountFormatter textFromAmount:customer.balance]];

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
        [self.dataController removeCustomerAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.dataController moveCustomerAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navigationController = [segue destinationViewController];
    id detailController = navigationController.topViewController;
    
    if([[segue identifier] isEqualToString:@"EditCustomer"])
    {
        [detailController setCustomer:[self.dataController customerAtIndex:[self.tableView indexPathForSelectedRow].row]];
        [detailController setProducts:[self.dataController products]];
    }
//    else if ([[segue identifier] isEqualToString:@"AddCustomer"])
//    {
//    }
}

-(IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnAddCustomerInput"])
    {
        MMAddCustomerDetailViewController * detailController = [segue sourceViewController];
        
        [self.dataController addCustomer:detailController.customer];
    }
//    else if ([[segue identifier] isEqualToString:@"ReturnEditCustomerInput"])
//    {
//    }
    
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelAddCustomerInput"] || [[segue identifier] isEqualToString:@"CancelEditCustomerInput"])
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark - Temp for debug

- (IBAction)buttonTouchUpInside:(id)sender
{
    [self.tableView reloadData];
}

@end
