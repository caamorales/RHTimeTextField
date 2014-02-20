//
//  ViewController.m
//  RHDateTextField
//
//  Created by Ratha Hin on 2/20/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import "ViewController.h"
#import "RHTimeTextField.h"

@interface ViewController ()

@property (strong, nonatomic) RHTimeTextField *timeTextField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  [self configureView];
}

- (void)configureView {
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self.view addSubview:self.timeTextField];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (RHTimeTextField *)timeTextField {
  
  if (!_timeTextField) {
    _timeTextField = [[RHTimeTextField alloc] initWithFrame:CGRectMake(0, 100, 320, 44)];
  }
  
  return _timeTextField;
  
}

@end
