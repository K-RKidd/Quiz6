//
//  Quiz6DetailViewController.m
//  Quiz6
//
//  Created by Krystle on 3/28/14.
//  Copyright (c) 2014 Krystle Kidd. All rights reserved.
//

#import "Quiz6DetailViewController.h"
#import "Tasks.h"

@interface Quiz6DetailViewController ()
- (void)configureView;
@end

@implementation Quiz6DetailViewController
@synthesize task;
@synthesize dismissBlock;
#pragma mark - Managing the detail item



- (void)configureView
{
    
    // Update the user interface for the detail item.
    slider.maximumValue = 10;
    slider.minimumValue = 0;
    
    int urgencyInteger = (int)(task.urgency);
    [urgency setText:[NSString stringWithFormat:@ "%u", urgencyInteger]];
    slider.value = task.urgency;
    [date setDate:[task dueDate]];
    [name setText:[task name]];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardUp:) name:UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardDown:) name:UIKeyboardWillHideNotification object:nil];
   
    
}
-(void) keyboardUp: (NSNotification *) note{
    CGSize keyboardSize =[[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    
    CGRect newFrame = self.view.frame;
    newFrame.origin.y -= keyboardSize.height;
    self.view.frame = newFrame;
    
}
-(void) keyboardDown: (NSNotification *)note {
    CGSize keyboardSize = [[[note userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect newFrame = self.view.frame;
    
    newFrame.origin.y += keyboardSize.height;
    self.view.frame= newFrame;
    
}
////save fields
-(void)viewWillDisappear:(BOOL)animated {
    
    [[self view] endEditing:YES];
    
    [super viewWillDisappear:animated];
    [task setUrgency:[[urgency text]intValue] ];
    [task setName:[name text]];
    [task setDueDate:[date date]];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveFields:(id)sender {
    [[self view] endEditing:YES];
    [task setUrgency:[[urgency text]intValue] ];
    [task setName:[name text]];
    [task setDueDate:[date date]];
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (IBAction)slider:(id)sender {
    int urgencyInteger = (int)(slider.value);
    [urgency setText:[NSString stringWithFormat:@ "%u", urgencyInteger]];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
