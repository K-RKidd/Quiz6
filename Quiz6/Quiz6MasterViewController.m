//
//  Quiz6MasterViewController.m
//  Quiz6
//
//  Created by Krystle on 3/28/14.
//  Copyright (c) 2014 Krystle Kidd. All rights reserved.
//

#import "Quiz6MasterViewController.h"

#import "Quiz6DetailViewController.h"

@interface Quiz6MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation Quiz6MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    Tasks *task = [[Tasks alloc]init];
    task.name = @"New Task";
    task.dueDate = [[NSDate alloc]init];
    task.urgency = 1;

    [_objects insertObject:task atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Tasks *task = [_objects objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[task name]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterLongStyle];
    [cell setTextColor:[UIColor colorWithRed:task.urgency/10.0 green:1.0-(task.urgency/10.4) blue:0 alpha:0.5]];
    NSString *dateInText = [df stringFromDate:task.dueDate];
    int urgencyInteger = (int)roundf(task.urgency);
    NSString *urgencyText = [NSString stringWithFormat: @" (%u)",urgencyInteger];
    NSString *new = [dateInText stringByAppendingString:urgencyText];

    [[cell detailTextLabel] setText:new];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tasks *task = [_objects objectAtIndex:[indexPath row]];
    
    Quiz6DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    [detailViewController setTask:task];
    
      [detailViewController setDismissBlock:^{ [[self tableView]reloadData];}];
    [detailViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];

    
    [self presentViewController:detailViewController animated:YES completion:nil];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
 
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self tableView]reloadData];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
        return NO;
}
@end
