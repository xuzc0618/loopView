//
//  LoopView.m
//  Loop
//
//  Created by xuzhichao on 2018/5/3.
//  Copyright © 2018年 xuzhichao. All rights reserved.
//

#import "LoopView.h"
#import "LoopCell.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kMaxSection 100 //设置一个最大的分区值

static NSString *ID = @"loopCell";


@interface LoopView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    CGRect _frame;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation LoopView

+ (instancetype)loopViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _frame = frame;
                
        //初始化collectionView
        [self setupCollectionView];
        
        //初始化pageControll
        [self setupPageControl];
        
        //初始化定时器
        [self startTimer];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, _frame.size.width, _frame.size.height);
    
    CGSize pageControlSize = [self.pageControl sizeForNumberOfPages:self.imageArray.count];
    self.pageControl.frame = CGRectMake(_frame.size.width - pageControlSize.width - 10, _frame.size.height - pageControlSize.height + 5, pageControlSize.width, pageControlSize.height);
    //在该方法中设置页码数.在创建pageControl时数组个数为0.
    self.pageControl.numberOfPages = self.imageArray.count;

}


//初始化collectionView
- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self addSubview:self.collectionView];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //注册cell
    [self.collectionView registerClass:[LoopCell class] forCellWithReuseIdentifier:ID];
    
}

//初始化pageControll
- (void)setupPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    [self addSubview:self.pageControl];
    self.pageControl.hidesForSinglePage = YES;

}

//初始化定时器
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextPage
{
    //1 获取当前正在展示的位置
    NSIndexPath *currentIndexPath =[self.collectionView.indexPathsForVisibleItems lastObject];
    
    //!!!马上显示回最中间那组的数据!!!
    NSIndexPath *midIndexPath =[NSIndexPath indexPathForItem:currentIndexPath.item inSection:kMaxSection/2];
    [self.collectionView scrollToItemAtIndexPath:midIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    //2 计算出下一个需要展示的位置
    NSInteger nextItem = midIndexPath.item + 1;
    NSInteger nextSection = midIndexPath.section;
    if (nextItem == self.imageArray.count) {
        nextItem = 0;
        nextSection++;
    }
    
    //3 通过动画滚动到下一个位置
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
}

//销毁定时器
- (void)endTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - collection代理方法

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return kMaxSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LoopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageStr = self.imageArray[indexPath.item];
    return cell;
}


#pragma mark - scrollView代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % self.imageArray.count;
}








@end

