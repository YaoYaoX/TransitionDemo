//
//  Const.h
//  TransitionDemo
//
//  Created by YY on 16/7/5.
//  Copyright © 2016年 YY. All rights reserved.
//

#ifndef Const_h
#define Const_h

// 系统版本信息
#define iOSVersion [[UIDevice currentDevice] systemVersion]
#define iOS7Later  ([iOSVersion floatValue] >= 7.0)
#define iOS8Later  ([iOSVersion floatValue] >= 8.0)
#define iOS9Later  ([iOSVersion floatValue] >= 9.0)


// 屏幕尺寸
#define SCREEN_WIDTH   ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

#endif
