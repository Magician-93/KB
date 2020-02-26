//
//  ShareView.m
//  ShareAlert
//
//  Created by boWen on 2020/2/26.
//  Copyright © 2020 boWen. All rights reserved.
//

#import "ShareView.h"
#import "BaseMacro.h"
@interface ShareView ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imgNameArray;
@property (nonatomic, copy) void (^blockTapAction)(NSInteger index);
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end


@implementation ShareView


/**
 从底部显示更多操作模式的按钮视图

 @param titleArray 标题名称
 @param imgNameArray 图片名称
 @param blockTapAction 点击返回事件(返回顺序:左->右,上->下, 0,1,2,3...)
 */
+ (void)showMoreWithTitle:(NSArray *)titleArray
             imgNameArray:(NSArray *)imgNameArray
           blockTapAction:( void(^)(NSInteger index) )blockTapAction {
    if (titleArray.count != imgNameArray.count || !titleArray.count) {
        return;
    }
    
    ShareView *modeView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    modeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    modeView.alpha = 0;
    modeView.titleArray = titleArray;
    modeView.imgNameArray = imgNameArray;
    modeView.blockTapAction = blockTapAction;
    
//       if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
//            view = [[UIApplication sharedApplication].windows firstObject];
//        } else {
//            view = [[UIApplication sharedApplication].windows lastObject];
//
//        }
    //获取当前windows
//#############################################
    [BTKeyWindows addSubview:modeView];
    
    // 创建内容
     [modeView bulidContentView];
     
     [modeView show];
     [modeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:modeView action:@selector(dismiss)]];
}


- (void)bulidContentView {
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, AutoConstraint(50) + ((self.titleArray.count-1)/5+1)*AutoConstraint(100) + AutoConstraint(30))];
     UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(AutoConstraint(20), AutoConstraint(15))];
     CAShapeLayer *shapeLayer = [CAShapeLayer layer];
     shapeLayer.path = path.CGPath;
     shapeLayer.fillColor = [UIColor whiteColor].CGColor;
     [self.contentView.layer addSublayer:shapeLayer];
     [self addSubview:self.contentView];
     
     [self bulidContent];
     [self bulidCancle];
}

- (void)bulidContent{
    
    self.buttonArray = [[NSMutableArray alloc] init];
    CGFloat itemW = (self.contentView.bounds.size.width-AutoConstraint(30))/5;
    for (int i = 0; i < self.titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.titleLabel.font = UIFontWithAutoSize(10);
        button.frame = CGRectMake(AutoConstraint(15) + i%5*itemW, AutoConstraint(10) + i/5*AutoConstraint(100), itemW, AutoConstraint(100));
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.imgNameArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        // button标题/图片的偏移量
        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.bounds.size.height + AutoConstraint(10), -button.imageView.bounds.size.width, 0,0);
        button.imageEdgeInsets = UIEdgeInsetsMake(AutoConstraint(5), button.titleLabel.bounds.size.width/2, button.titleLabel.bounds.size.height + AutoConstraint(5), -button.titleLabel.bounds.size.width/2);
        [self.buttonArray addObject:button];
        
        button.alpha = 0;
        button.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showButton];
    });
}

- (void)showButton{
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        
        UIButton *button = self.buttonArray[i];
        
        [UIView animateWithDuration:0.7 delay:i*0.05 - i/4*0.2 usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            button.alpha = 1;
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

// 取消按钮
- (void)bulidCancle{
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, self.contentView.bounds.size.height - AutoConstraint(50), self.contentView.bounds.size.width, AutoConstraint(50));
    cancleButton.titleLabel.font = UIFontWithAutoSize(15);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, cancleButton.bounds.size.width, 1);
    layer.backgroundColor = [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.00f].CGColor;
    [cancleButton.layer addSublayer:layer];

    [self.contentView addSubview:cancleButton];
}

- (void)addLineWithFrame:(CGRect)frame color:(UIColor *)color{
    
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (void)show{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentView.bounds.size.height);
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)tapAction:(UIButton *)button{
    
    [self dismiss];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.blockTapAction) {
            self.blockTapAction(button.tag);
        }
    });
}

@end
