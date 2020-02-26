//
//  ShareView.h
//  ShareAlert
//
//  Created by boWen on 2020/2/26.
//  Copyright © 2020 boWen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareView : UIView

/**
 从底部显示更多操作模式的按钮视图

 @param titleArray 标题名称
 @param imgNameArray 图片名称
 @param blockTapAction 点击返回事件(返回顺序:左->右,上->下, 0,1,2,3...)
 */
+ (void)showMoreWithTitle:(NSArray *)titleArray
             imgNameArray:(NSArray *)imgNameArray
           blockTapAction:( void(^)(NSInteger index) )blockTapAction;


@end

NS_ASSUME_NONNULL_END
