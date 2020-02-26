//
//  BaseMacro.h
//  ShareAlert
//
//  Created by boWen on 2020/2/26.
//  Copyright © 2020 boWen. All rights reserved.
//

#ifndef BaseMacro_h
#define BaseMacro_h



#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

/** ---- 屏幕适配（Masonry） ----
 */
#define AutoConstraint(number) (number) * ([UIScreen mainScreen].bounds.size.width) / 375.0f

//当前windows
#define BTKeyWindows [[UIApplication sharedApplication].windows firstObject]
/** ---- 字体 ----
 */
// 根据名字设置字体
#define UIFontWithNameAndSize(fontName,fontSize) ([UIFont fontWithName:fontName size:fontSize])
// 正常的字体
#define UIFontWithSize(size) ([UIFont systemFontOfSize:size])
// 屏幕适配的字体
#define UIFontWithAutoSize(size) ([UIFont systemFontOfSize:AutoConstraint(size)])
// 加粗字体
#define UIBoldFontWithSize(size) ([UIFont boldSystemFontOfSize:size])
// 加粗屏幕适配的字体
#define UIBoldFontWithAutoSize(size) ([UIFont boldSystemFontOfSize:AutoConstraint(size)])


#endif /* BaseMacro_h */
