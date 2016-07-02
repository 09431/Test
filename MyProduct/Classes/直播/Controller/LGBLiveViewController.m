//
//  LGBLiveViewController.m
//  MyProduct
//
//  Created by Bing on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBLiveViewController.h"
#import "LGBRecommondController.h"
#import "LGBLiveController.h"




@interface LGBLiveViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UISegmentedControl * segmentedControl;

@property (nonatomic,strong)UIScrollView * scrollView;

@end

@implementation LGBLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建导航
    [self setupNav];
    
    //创建UI
    [self createUI];
}
#pragma mark - 创建导航
-(void)setupNav
{
    //设置导航不透明
    self.navigationController.navigationBar.translucent = NO;
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 160, 30)];
    
    //添加标题
    [self.segmentedControl insertSegmentWithTitle:@"推荐" atIndex:0 animated:YES];
    [self.segmentedControl insertSegmentWithTitle:@"全民直播" atIndex:1 animated:YES];
    
    //设置字体颜色
    self.segmentedControl.tintColor = [UIColor blackColor];
    
    self.navigationItem.titleView = self.segmentedControl;
    
    //添加点击事件
    [self.segmentedControl addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    
    //设置默认选中项
    self.segmentedControl.selectedSegmentIndex = 0;
    
}
#pragma mark - 通过segment控制 scrollView
-(void)changeValue:(UISegmentedControl *)segment
{
    self.scrollView.contentOffset = CGPointMake(segment.selectedSegmentIndex * LGBScreenW, 0);
  
}
#pragma mark - 反向关连
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x / LGBScreenW;
}

#pragma mark - 创建UI
-(void)createUI
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, LGBScreenW, LGBScreenH)];
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(LGBScreenW * 2, 0);
    
    //子控制器的实例化
    LGBRecommondController * recommond = [[LGBRecommondController alloc]init];
    LGBLiveController * live = [[LGBLiveController alloc]init];
    
    NSArray * array = @[recommond,live];
    
    int i = 0;
    
    for (UIViewController * vc in array) {
        vc.view.frame = CGRectMake(i*LGBScreenW, 0, LGBScreenW, LGBScreenH);
        
        [self addChildViewController:vc];
        
        [self.scrollView addSubview:vc.view];
        
        i++;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
