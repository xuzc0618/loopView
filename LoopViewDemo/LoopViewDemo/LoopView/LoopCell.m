//
//  LoopCell.m
//  Loop
//
//  Created by xuzhichao on 2018/5/3.
//  Copyright © 2018年 xuzhichao. All rights reserved.
//

#import "LoopCell.h"

@interface LoopCell()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LoopCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return self;
}


- (void)setImageStr:(NSString *)imageStr
{
    _imageStr = imageStr;
    
    self.imageView.image = [UIImage imageNamed:imageStr];
}

@end
