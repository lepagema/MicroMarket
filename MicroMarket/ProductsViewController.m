//
//  ProductsViewController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 13.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "ProductsViewController.h"
#import "MarketDataController.h"
#import "ProductDetailViewController.h"
#import "AmountFormatter.h"
#import "Product.h"

@interface ProductsViewController ()
@end

@implementation ProductsViewController

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
    return [self.dataController productCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Product *product = [self.dataController productAtIndex:indexPath.row];
    [cell.textLabel setText:product.name];
    [cell.detailTextLabel setText:[AmountFormatter textFromAmount:product.price]];

    return cell;
}

#pragma mark - Editing Table View

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataController removeProductAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.dataController moveProductAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navigationController = [segue destinationViewController];
    id detailController = navigationController.topViewController;
    
    if ([[segue identifier] isEqualToString:@"AddProduct"])
    {
        [detailController setDataController:self.dataController];
        [detailController setProduct:nil];
    }
    else if([[segue identifier] isEqualToString:@"EditProduct"])
    {
        [detailController setDataController:self.dataController];
        [detailController setProduct:[self.dataController productAtIndex:[self.tableView indexPathForSelectedRow].row]];
    }
}

-(IBAction)done:(UIStoryboardSegue *)segue
{
//    if ([[segue identifier] isEqualToString:@"ReturnProductInput"])
//    {
//    }

    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)cancel:(UIStoryboardSegue *)segue
{
//    if ([[segue identifier] isEqualToString:@"CancelProductInput"])
//    {
//    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
