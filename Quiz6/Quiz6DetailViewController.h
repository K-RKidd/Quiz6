//
//  Quiz6DetailViewController.h
//  Quiz6
//
//  Created by Krystle on 3/28/14.
//  Copyright (c) 2014 Krystle Kidd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tasks;
@interface Quiz6DetailViewController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *name;
    __weak IBOutlet UILabel *urgency;
    __weak IBOutlet UISlider *slider;
    __weak IBOutlet UIDatePicker *date;
    
}

@property (strong, nonatomic) Tasks *task;
- (IBAction)saveFields:(id)sender;
- (IBAction)slider:(id)sender;
@property (nonatomic, copy) void (^dismissBlock)(void);


@end
