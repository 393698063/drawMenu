//
//  drawDownMenu.m
//  drawMenu
//
//  Created by HEcom on 16/7/9.
//  Copyright © 2016年 HEcom. All rights reserved.
//

#define kHeight 64

#import "drawDownMenu.h"

@interface drawDownMenu ()
{
  UIImageView * _toggleView;
  UILabel * _lineLabel;
}
@property (nonatomic,strong) UIView * contentView;
@end

@implementation drawDownMenu

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"draw" ofType:@"bundle"];
    NSString * imagePath = [[NSBundle bundleWithPath:path] pathForResource:@"down@2x" ofType:@"png"];
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat x = (self.bounds.size.width - image.size.width)/2.0;
    CGFloat y = 0;
    imageView.frame = CGRectMake(x, y, image.size.width, image.size.height);
    _toggleView = imageView;
    [self addSubview:imageView];
    
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)];
    _lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineLabel];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
//    self.backgroundColor = [UIColor cyanColor];
  }
  return self;
}
+(drawDownMenu *)drawMenuView:(UIView *)contentView
{
  drawDownMenu * menuView = [[drawDownMenu alloc] init];
  menuView.contentView = contentView;
  return menuView;
}
-(void)setFrame:(CGRect)frame
{
  [super setFrame:frame];
  UIImageView *img = _toggleView;
  CGFloat x = (self.bounds.size.width - img.image.size.width)/2.0;
  CGFloat y = 0;
  img.frame = CGRectMake(x, y, img.image.size.width, img.image.size.height);
  _lineLabel.frame = CGRectMake(0, 0, frame.size.width, 0.5);
}
- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer
{
  CGPoint location = [gestureRecognizer locationInView:self.superview];
  CGFloat y = location.y;
  
  UIGestureRecognizerState state = gestureRecognizer.state;
  CGFloat contentHeight = _contentView.frame.size.height;
  NSLog(@"state ---- %ld",(long)state);
  if (y > (kHeight + contentHeight)) {
    y = kHeight + contentHeight;
  }
  
  BOOL animated = NO;
  if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled)
  {
    CGFloat maxY = kHeight + contentHeight/2.0;
    
    if (y <= maxY) {
      y =  kHeight;
    }
    else
    {
      y = kHeight + contentHeight;
    }
    animated = YES;
  }
  else if (state == UIGestureRecognizerStateChanged)
  {
    CGFloat offset = y ;
    if (offset > kHeight + contentHeight) {
      y = kHeight + contentHeight;
    }
    else if (y <= kHeight)
    {
      y = kHeight;
    }
    else
    {
      animated = YES;
    }
  }
  
  if (animated) {
    [UIView animateWithDuration:0.2 animations:^
    {
      self.center = CGPointMake(self.center.x, y + self.frame.size.height/2.0);
      
      CGRect rect =  _contentView.frame;
      rect.origin.y = y - contentHeight;
      _contentView.frame = rect;
    }];
    return;
  }
  self.center = CGPointMake(self.center.x, y + self.frame.size.height/2.0);
  CGRect rect =  _contentView.frame;
  rect.origin.y = y - contentHeight;
  _contentView.frame = rect;

}
- (void)tap:(UITapGestureRecognizer *)gestureRecognizer
{
  [self show];
}
-(void)show{
  [self hideContent:NO];
}

-(void)hide{
  [self hideContent:YES];
}

- (void)hideContent:(BOOL)hidden {
  CGRect frame =  _contentView.frame;
  CGRect hideFrame = frame;
  CGRect showFrame = frame;
  
  hideFrame.origin.y = kHeight - frame.size.height;
  showFrame.origin.y = kHeight;
  
  BOOL showContentView = !CGRectEqualToRect(showFrame,  _contentView.frame);
  
  __block CGRect rect =  self.frame;
  
  
  [UIView animateWithDuration:0.2 animations:^
   {
     if (showContentView)
     {
       _contentView.frame = showFrame;
       rect.origin.y = CGRectGetMaxY(showFrame);
       self.frame = rect;
     }
     else
     {
       _contentView.frame = hideFrame;
       rect.origin.y = CGRectGetMaxY(hideFrame);
       self.frame = rect;
     }
   }completion:nil];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  
  CGRect frame = _toggleView.frame;
  frame = CGRectInset(frame, - 5, 0);
  return  CGRectContainsPoint(frame, point);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
