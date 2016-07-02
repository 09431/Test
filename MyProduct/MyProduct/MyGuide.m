//
//  MyGuide.m
//  Love  Limit  Free
//
//  Created by Bing on 16/3/30.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "MyGuide.h"

@interface MyGuide()<UIScrollViewDelegate>

{
    __block void(^_callBack)();
}

@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIPageControl * pageControl;
@property (nonatomic,assign)NSUInteger totalPage;


@end



@implementation MyGuide

-(instancetype)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray goBack:(void (^)())hander
{
    if (self == [super initWithFrame:frame]) {
        _callBack = hander;
        
        [self createSubView:imageArray];
    }
    return self;
    
}
-(void)createSubView:(NSArray *)imageArray
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 30)];
        
        _pageControl.backgroundColor = [UIColor clearColor];
        
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor blackColor];
        
        _pageControl.numberOfPages = imageArray.count;
        
        _scrollView.pagingEnabled = YES;
        
        [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * [imageArray count], self.frame.size.height);
        
        //移除已有图片
        for (UIImageView * imageView in _scrollView.subviews) {
            [imageView removeFromSuperview];
        }
        
        NSInteger i = 0;
        for (NSString * imageName in imageArray) {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i* self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            imageView.image = [UIImage imageNamed:imageName];
            
            [_scrollView addSubview:imageView];
            i++;
        }
        _totalPage = imageArray.count;
        
        
    }
    
}
-(void)pageChange:(UIPageControl *)pageControl
{
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * pageControl.currentPage, 0);
    //判断,如果是最后一页,却换视图,执行block
    if (pageControl.currentPage == _totalPage - 1) {
        if (_callBack) {
            _callBack();
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger pageCount = scrollView.contentOffset.x/_scrollView.frame.size.width;
    
    _pageControl.currentPage = pageCount;
    if (pageCount == _totalPage - 1) {
        if (_callBack) {
            _callBack();
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
