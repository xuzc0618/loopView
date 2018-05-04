//
//  LoopView.h
//  Loop
//
//  Created by xuzhichao on 2018/5/3.
//  Copyright © 2018年 xuzhichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopView : UIView

//创建方法
+ (instancetype)loopViewWithFrame:(CGRect)frame;

//图片名称数组
@property (nonatomic, strong) NSArray *imageArray;

@end
