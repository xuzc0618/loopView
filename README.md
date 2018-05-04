# loopView
无限轮播图
使用collectionView实现无限轮播图.
使用简单.

    LoopView *loopView = [LoopView loopViewWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    loopView.imageArray = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    [self.view addSubview:loopView];
