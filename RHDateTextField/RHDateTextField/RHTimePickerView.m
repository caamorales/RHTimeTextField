//
//  RHDatePickerView.m
//  RHDateTextField
//
//  Created by Ratha Hin on 2/20/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import "RHTimePickerView.h"

@interface RHTimePickerView ()

@property (strong, nonatomic) UIWindow *overlayWindow;
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIButton *yesButton;
@property (strong, nonatomic) UIButton *noButton;
@property (assign, nonatomic) CGRect buttonFrame;

@end

@implementation RHTimePickerView

- (UIWindow *)overlayWindow {
  if(!_overlayWindow) {
    _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _overlayWindow.backgroundColor = [UIColor clearColor];
    _overlayWindow.userInteractionEnabled = YES;
    _overlayWindow.windowLevel = UIWindowLevelNormal;
  }
  return _overlayWindow;
}

- (UIView *)view {
  
  if (!_view) {
    _view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _view.backgroundColor = [UIColor blackColor];
    [_view addSubview:self.noButton];
    [_view addSubview:self.yesButton];
    
    self.noButton.center = CGPointMake(40, CGRectGetMaxY(_view.bounds) - 40);
    self.yesButton.center = CGPointMake(CGRectGetMaxX(_view.bounds) - 40, CGRectGetMaxY(_view.bounds) - 40);
    
  }
  
  return _view;
}

- (UIButton *)yesButton {
  
  if (!_yesButton) {
    _yesButton = [[UIButton alloc] initWithFrame:self.buttonFrame];
    [_yesButton setTitle:@"YES" forState:UIControlStateNormal];
    [_yesButton addTarget:self action:@selector(yesAction) forControlEvents:UIControlEventTouchUpInside];
  }
  
  return _yesButton;
  
}

- (UIButton *)noButton {
  
  if (!_noButton) {
    _noButton = [[UIButton alloc] initWithFrame:self.buttonFrame];
    [_noButton setTitle:@"NO" forState:UIControlStateNormal];
    [_noButton addTarget:self action:@selector(noAction) forControlEvents:UIControlEventTouchUpInside];
  }
  
  return _noButton;
  
}

- (void)noAction {
  [self hideDatePicker];
}

- (void)yesAction {
  
}

- (CGRect)buttonFrame {
  return CGRectMake(0, 0, 60, 44);
}

- (void)showDatePicker {
  [self.overlayWindow addSubview:self.view];
  [self.overlayWindow setHidden:NO];
}

- (void)hideDatePicker {
  [self.view removeFromSuperview];
  self.overlayWindow = nil;
}

@end
