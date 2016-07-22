//
//  drawUpMenu.m
//  drawMenu
//
//  Created by HEcom on 16/7/12.
//  Copyright © 2016年 HEcom. All rights reserved.
//
#define kHeight 199

#import "drawUpMenu.h"

@interface drawUpMenu ()
{
  UIImageView * _toggleView;
  UILabel * _lineLabel;
}
@property (nonatomic,strong) UIView * contentView;
@end

@implementation drawUpMenu
- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"draw" ofType:@"bundle"];
    NSString * imagePath = [[NSBundle bundleWithPath:path] pathForResource:@"up@2x" ofType:@"png"];
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat x = (self.bounds.size.width - image.size.width)/2.0;
    CGFloat y = self.bounds.size.height - image.size.height;
    imageView.frame = CGRectMake(x, y, image.size.width, image.size.height);
    _toggleView = imageView;
    [self addSubview:imageView];
    
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29.5, self.bounds.size.width, 0.5)];
    _lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineLabel];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
  }
  return self;
}
+(drawUpMenu *)drawUpMenuView:(UIView *)contentView
{
  drawUpMenu * menuView = [[drawUpMenu alloc] init];
  menuView.contentView = contentView;
  return menuView;
}
-(void)setFrame:(CGRect)frame
{
  [super setFrame:frame];
  UIImageView *img = _toggleView;
  CGFloat x = (self.bounds.size.width - img.image.size.width)/2.0;
  CGFloat y = self.bounds.size.height - img.image.size.height;
  img.frame = CGRectMake(x, y, img.image.size.width, img.image.size.height);
  
  _lineLabel.frame = CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5);
}
- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer
{
  CGPoint location = [gestureRecognizer locationInView:self.superview];
  CGFloat y = location.y;
  
  UIGestureRecognizerState state = gestureRecognizer.state;
  CGFloat contemntHeight = _contentView.frame.size.height;
  CGFloat maxHeight = [UIScreen mainScreen].bounds.size.height;
  if (y < (maxHeight - kHeight - contemntHeight)) {
    y = maxHeight - kHeight - contemntHeight;
  }
  
  BOOL animated = NO;
  if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled)
  {
    CGFloat maxY = maxHeight - kHeight - contemntHeight/2.0;
    
    if (y <= maxY) {
      y =  maxHeight - kHeight - contemntHeight;
    }
    else
    {
      y = maxHeight - kHeight;
    }
    animated = YES;
  }
  else if (state == UIGestureRecognizerStateChanged)
  {
    CGFloat offset = y - (maxHeight - kHeight - contemntHeight) ;
    if (offset <= 0) {
      y = maxHeight - kHeight - contemntHeight;
    }
    else if (offset >= contemntHeight)
    {
      y = maxHeight - kHeight;
    }
    else
    {
      animated = YES;
    }
  }
  
  if (animated) {
    [UIView animateWithDuration:0.2 animations:^{
      NSLog(@"1111");
      self.center = CGPointMake(self.center.x, y - self.frame.size.height/2.0);
      
      CGRect rect =  _contentView.frame;
      rect.origin.y = y;
      _contentView.frame = rect;
    }];
    return;
  }
  self.center = CGPointMake(self.center.x, y - self.frame.size.height/2.0);
  CGRect rect =  _contentView.frame;
  rect.origin.y = y;
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
  
  hideFrame.origin.y = [UIScreen mainScreen].bounds.size.height- kHeight;
  showFrame.origin.y = [UIScreen mainScreen].bounds.size.height - kHeight - frame.size.height;
  
  BOOL showContentView = !CGRectEqualToRect(showFrame,  _contentView.frame);
  
  __block CGRect rect =  self.frame;
  [UIView animateWithDuration:0.2 animations:^
   {
     if (showContentView)
     {
       _contentView.frame = showFrame;
       rect.origin.y = CGRectGetMinY(showFrame) - 30;
       self.frame = rect;
     }
     else
     {
       _contentView.frame = hideFrame;
       rect.origin.y = CGRectGetMinY(hideFrame) - 30;
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
