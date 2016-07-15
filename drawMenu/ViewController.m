//
//  ViewController.m
//  drawMenu
//
//  Created by HEcom on 16/7/9.
//  Copyright © 2016年 HEcom. All rights reserved.
//
#define kScreenSize [UIScreen mainScreen].bounds.size
#import "ViewController.h"
#import "drawDownMenu.h"
#import "drawUpMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, -95 + 64, [UIScreen mainScreen].bounds.size.width, 95)];
  contentView.backgroundColor = [UIColor redColor];
  [self.view addSubview:contentView];
  
  CGRect frame = contentView.frame;
  frame.origin.y = 64;
  frame.size.height = 30;
  drawDownMenu * drawMenu = [drawDownMenu drawMenuView:contentView];
  drawMenu.frame = frame;
  [self.view addSubview:drawMenu];
  
  UIView * downContentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 199,kScreenSize.width, 150)];
  downContentView.backgroundColor = [UIColor yellowColor];
  [self.view addSubview:downContentView];
  
  drawUpMenu * upMenu = [drawUpMenu drawUpMenuView:downContentView];
  CGRect downFrame = downContentView.frame;
  downFrame.origin.y -= 30;
  downFrame.size.height = 30;
  upMenu.frame = downFrame;
  [self.view addSubview:upMenu];
  
  
  
  UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 199, kScreenSize.width, 150)];
  downView.backgroundColor = [UIColor whiteColor];
  downView.userInteractionEnabled = NO;
  [self.view addSubview:downView];
  
  UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 64)];
  upView.backgroundColor = [UIColor whiteColor];
  upView.userInteractionEnabled = NO;
  [self.view addSubview:upView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
