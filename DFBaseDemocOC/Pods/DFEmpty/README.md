# DFEmpty
本框架是基于DZNEmptyDataSet写的，在使用DZNEmptyDataSet时如果列表的ContentSize比较大的时候，显示的空白页位置会偏移很多，一直不知道怎么解决，所以自己基于DZNEmptyDataSet写了DFEmpty。

# 使用pod导入
```
pod 'DFEmpty'
```

# 使用方法
```
#import "UIScrollView+EmptyData.h"
```
# 协议
```
<DFEmptyDataSetSource, DFEmptyDataSetDelegate>
self.tableView.emptyDataSetSource = self;
self.tableView.emptyDataSetDelegate = self;
```

# DFEmptyDataSetSource
```
/**
* 空白页标题
*/
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView;
/**
* 空白页描述
*/
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView;
/**
* 空白页图片
*/
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView;
/**
* 空白页图片动画
*/
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView;
/**
* 空白页按钮标题
*/
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
/**
* 空白页按钮图片
*/
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
/**
* 空白页按钮背景图片
*/
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

/**
* 返回自定义的空白页
*/
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView;

/**
* 垂直偏移
*/
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView;

/**
* 空白页中元素之间的空隙，默认11
*/
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView;
```

# DFEmptyDataSetDelegate
```
/**
* 空白页userInteractionEnabled是否有效，默认YES
*/
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView;

/**
* 默认空白页是否有动画效果
*/
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView;
/**
* 点击空白页回调
*/
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view;
/**
* 点击按钮回调
*/
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button;
```



