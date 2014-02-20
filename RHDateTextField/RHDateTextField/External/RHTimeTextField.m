//
//  RHDateTextField.m
//  RHDateTextField
//
//  Created by Ratha Hin on 2/20/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import "RHTimeTextField.h"
#import "RHTimePickerView.h"

@interface RHTimeTextField ()

@property (strong, nonatomic) UILongPressGestureRecognizer *longGesture;
@property (strong, nonatomic) RHTimePickerView *timePickerView;
@property (strong, nonatomic) UITextField *hourTextField;
@property (strong, nonatomic) UITextField *minuteTextField;

@end

@implementation RHTimeTextField

- (void)didMoveToSuperview {
  [self commonSetup];
}

- (void)commonSetup {
  self.layer.borderColor = [UIColor grayColor].CGColor;
  self.layer.borderWidth = 1.0f;
  [self addGestureRecognizer:self.longGesture];
}

- (UILongPressGestureRecognizer *)longGesture {
  if (!_longGesture) {
    _longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(longGestureAction:)];
  }
  
  return _longGesture;
}

- (void)longGestureAction:(UILongPressGestureRecognizer *)longGesture {
  [self.timePickerView showDatePicker];
}

- (RHTimePickerView *)timePickerView {
  if (!_timePickerView) {
    _timePickerView = [[RHTimePickerView alloc] init];
  }
  
  return _timePickerView;
}

@end
