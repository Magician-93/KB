//
//  ViewController.m
//  ShareAlert
//
//  Created by boWen on 2020/2/26.
//  Copyright © 2020 boWen. All rights reserved.
//

#import "ViewController.h"
#import "BaseMacro.h"
#import "ShareView.h"
@interface ViewController ()
@property (nonatomic, strong) UIButton * clickBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.clickBtn];
}

- (UIButton *)clickBtn {
    if (!_clickBtn) {
        UIButton * clickButton = [UIButton buttonWithType:UIButtonTypeSystem];
        clickButton.frame = CGRectMake(Screen_Width/2, Screen_Height/2, 50, 50);
        clickButton.backgroundColor = [UIColor lightGrayColor];
        [clickButton addTarget:self action:@selector(alertClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _clickBtn = clickButton;
    }
    return _clickBtn;
}

- (void)alertClickAction:(UIButton *)sender {
    NSArray * titleAry = @[@"分享给好友", @"分享到朋友圈", @"分享到微博", @"分享到QQ", @"反馈&建议"];
    NSArray * iconAry = @[@"btn_wechat", @"btn_circle", @"btn_weibo", @"btn_QQ", @"btn_proposal"];
    [ShareView showMoreWithTitle:titleAry imgNameArray:iconAry blockTapAction:^(NSInteger index) {
          NSLog(@"%zd",index);
    }];
}

@end
