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
@property (strong, nonatomic) NSArray *hourArray;
@property (strong, nonatomic) NSArray *minuteArray;
@property (strong, nonatomic) NSArray *hourViewPool;
@property (strong, nonatomic) NSArray *minuteViewPool;

@end

@implementation RHTimePickerView

#pragma mark - internal

- (void)setupHourMinute {
  
  NSMutableArray *mutableHourViewPool = [[NSMutableArray alloc] initWithCapacity:[self.hourArray count]];
  NSMutableArray *mutableMinuteViewPool = [[NSMutableArray alloc] initWithCapacity:[self.hourArray count]];
  
  CGFloat cy = 44;
  NSInteger index = 0;
  
  for (NSString *hour in self.hourArray) {
    UIView *hourView = [self viewWithlabelForText:hour tagNumber:index];
    UIView *minuteView = [self viewWithlabelForText:self.minuteArray[index] tagNumber:index];
    CGRect hourFrame = hourView.frame;
    CGRect minuteFrame = minuteView.frame;
    hourFrame.origin = CGPointMake(0, cy);
    minuteFrame.origin = CGPointMake(160, cy);
    hourView.frame = hourFrame;
    minuteView.frame = minuteFrame;
    [self.view addSubview:hourView];
    [self.view addSubview:minuteView];
    
    // align text for hour
    UILabel *label = (UILabel *)[hourView viewWithTag:99];
    if (label) label.textAlignment = NSTextAlignmentRight;
    
    index ++;
    cy += CGRectGetHeight(hourView.bounds);
    
    [mutableHourViewPool addObject:hourView];
    [mutableMinuteViewPool addObject:minuteView];
  }
  
  self.hourViewPool = [mutableHourViewPool copy];
  self.minuteViewPool = [mutableMinuteViewPool copy];
  
}

- (UIView *)viewWithlabelForText:(NSString *)text
                tagNumber:(NSUInteger)tag {
  UIView *result = [[UIView alloc] initWithFrame:[self viewRect]];
  UILabel *label = [[UILabel alloc] initWithFrame:[self labelRect]];
  
  // setup appearance for label
  label.font = [UIFont fontWithName:@"Avenir-Light" size:15.0];
  label.textColor = [UIColor colorWithRed:78.0 / 255.0 green:83 / 255.0 blue:91 / 255.0 alpha:1.0];
  label.text = text;
  label.tag = 99;
  
  result.tag = tag;
  [result addSubview:label];
  
  return result;
}

- (CGRect)viewRect {
  return CGRectMake(0, 0, 160, 34);
}

- (CGRect)labelRect {
  return CGRectMake(23, 0, 109, 34);
}

- (UIColor *)selectedColor {
  return [UIColor whiteColor];
}

- (UIColor *)normalColor {
  return [UIColor colorWithRed:78.0 / 255.0 green:83 / 255.0 blue:91 / 255.0 alpha:1.0];
}

#pragma mark - lazzy getter
- (UIWindow *)overlayWindow {
  if(!_overlayWindow) {
    _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _overlayWindow.backgroundColor = [UIColor clearColor];
    _overlayWindow.userInteractionEnabled = YES;
    _overlayWindow.multipleTouchEnabled = YES;
    _overlayWindow.windowLevel = UIWindowLevelNormal;
  }
  return _overlayWindow;
}

- (UIView *)view {
  
  if (!_view) {
    _view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _view.backgroundColor = [UIColor colorWithRed:19.0 / 255 green:29 / 255 blue:44 / 255 alpha:1.0];
    [_view addSubview:self.noButton];
    [_view addSubview:self.yesButton];
    
    self.noButton.center = CGPointMake(40, CGRectGetMaxY(_view.bounds) - 20);
    self.yesButton.center = CGPointMake(CGRectGetMaxX(_view.bounds) - 40, CGRectGetMaxY(_view.bounds) - 20);
    
    [self setupHourMinute];
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
  [self addSubview:self.view];
  [self.overlayWindow addSubview:self];
  [self.overlayWindow setHidden:NO];
}

- (void)hideDatePicker {
  [self removeFromSuperview];
  self.overlayWindow = nil;
}

- (NSArray *)hourArray {
  
  if (!_hourArray) {
    NSMutableArray *mutatbleHourArray = [[NSMutableArray alloc] initWithCapacity:12];
    for (NSInteger i = 0; i < 12 ; i++) {
      [mutatbleHourArray addObject:[NSString stringWithFormat:@"%0.2d", i + 1]];
    }
    _hourArray = [mutatbleHourArray copy];
  }
  
  return _hourArray;
}

- (NSArray *)minuteArray {
  
  if (!_minuteArray) {
    NSMutableArray *mutatbleMinuteArray = [[NSMutableArray alloc] initWithCapacity:12];
    for (NSInteger i = 0; i < 12 ; i++) {
      [mutatbleMinuteArray addObject:[NSString stringWithFormat:@"%0.2d", i*5]];
    }
    _minuteArray = [mutatbleMinuteArray copy];
  }
  
  return _minuteArray;
}

#pragma mark - touch

- (void)hightlightingWithTouch:(NSSet *)touches withEvent:(UIEvent *)event {
  
  NSLog(@"How many touch do you have (%d)", [touches count]);
  
  UITouch *leftTouch = nil;
  UITouch *rightTouch = nil;
  
  for (UITouch *touch in touches) {
    if ([touch locationInView:self.view].x < 160 ) {
      leftTouch = touch;
    } else {
      rightTouch = touch;
    }
  }
  
  for (UIView *eachHourView in self.hourViewPool) {
    UILabel *labelEachView = (UILabel *)[eachHourView viewWithTag:99];
    labelEachView.textColor = [self normalColor];
    
    if (CGRectContainsPoint(eachHourView.frame, [leftTouch locationInView:self.view])) {
      labelEachView.textColor = [self selectedColor];
    }
  }
  
  for (UIView *eachMinutView in self.minuteViewPool) {
    UILabel *labelEachView = (UILabel *)[eachMinutView viewWithTag:99];
    labelEachView.textColor = [self normalColor];
    
    if (CGRectContainsPoint(eachMinutView.frame, [rightTouch locationInView:self.view])) {
      labelEachView.textColor = [self selectedColor];
    }
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hightlightingWithTouch:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hightlightingWithTouch:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  //
}

@end
