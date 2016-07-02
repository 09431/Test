//
//  LGBHeaderViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBHeaderViewController.h"
#import "AFNetworking.h"
#import "SDCycleScrollView.h"
#import "LGBHeaderModel.h"
#import "LGBHeaderCell.h"
#import "MBProgressHUD.h"
#import "LGBShowViewController.h"

@interface LGBHeaderViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray * dataSource;
//轮播图 文字 图片数组 tid
@property (nonatomic,strong)NSMutableArray * titles;
@property (nonatomic,strong)NSMutableArray * imageArray;
@property (nonatomic,strong)NSMutableArray * tidArray;

//加载图片 菊花
@property (nonatomic,strong)UIImageView * imageView;


@property (nonatomic,strong)SDCycleScrollView * cycleScrollView;

//当前页码
@property (nonatomic,assign)int page;

@property (nonatomic,strong)MBProgressHUD *hud;

@end

static NSString * const LGBHeaderCellID = @"header";

@implementation LGBHeaderViewController
-(NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [[NSMutableArray alloc]init];
    }
    return _titles;
}
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
    
}
-(NSMutableArray *)tidArray
{
    if (!_tidArray) {
        _tidArray = [[NSMutableArray alloc]init];
    }
    return _tidArray;
}
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
-(void)viewWillAppear:(BOOL)animated
{
   //self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = LGBGlobalBg;
    
    [self initImageView];

    [self createTableView];
    
    [self setupRefresh];
    
    
}
#pragma mark - 菊花
-(void)initImageView
{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(LGBScreenW/2-60, LGBScreenH/2-150, 120, 120)];
  
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i=0; i<12; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~iphone",i]];
        [array addObject:image];
    }
    
    self.imageView.animationImages = array;
    self.imageView.animationRepeatCount = 0;
    
    [self.tableView addSubview:self.imageView];
}
#pragma mark - 设置tableView
-(void)createTableView
{
  // 设置内边距
    
//    CGFloat top = LGBTitlesViewH + LGBTitlesViewY;
//    
//    CGFloat bottom = self.tabBarController.tabBar.height;
//    
//    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    self.tableView.rowHeight = 100;
    
    //设置滚动条的内边距
  //  self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGBHeaderCell class]) bundle:nil] forCellReuseIdentifier:LGBHeaderCellID];
}
#pragma mark - 设置刷新
-(void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.header beginRefreshing];
    
    //自动改变透明度
    self.tableView.header.automaticallyChangeAlpha = YES;
}
-(void)loadNewData
{
    self.page = 0;
    
    [self.dataSource removeAllObjects];
    [self loadData];
}
-(void)loadMoreData
{
    self.page++;
    
    [self loadData];
}
-(void)loadData
{
    //清除上一次加载的数据
    [self.titles removeAllObjects];
    [self.imageArray removeAllObjects];
    [self.tidArray removeAllObjects];
    
    //显示活动指示器
    [self.imageView startAnimating];
    
   [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:HeaderURL,self.page] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    
       //解析轮播图 文字 图片
       NSArray * arr = responseObject[@"body"][@"focus"];
       for (NSDictionary * dict in arr) {
           NSString * title = dict[@"title"];
           NSString * pic = dict[@"pic"];
           NSString * tid = dict[@"tid"];
           
           [self.titles addObject:title];
           [self.imageArray addObject:pic];
           [self.tidArray addObject:tid];
       }
      //设置轮播图
      [self setupHeader];
       
       
       NSArray * array = responseObject[@"body"][@"block"];
      
       for (NSDictionary * dict in array) {
           LGBHeaderModel * model = [[LGBHeaderModel alloc]init];
           
           [model setValuesForKeysWithDictionary:dict];
           
           [self.dataSource addObject:model];
       }
       
       
       //隐藏活动指示器
       [self.imageView stopAnimating];
       
       //结束上下拉刷新,刷新tableView
       if (_page ==0) {
           [self.tableView.header endRefreshing];
       }
       else{
           [self.tableView.footer endRefreshing];
       }
       [self.tableView reloadData];
       
       
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       NSLog(@"%@",error);
       //隐藏活动指示器
       [self.imageView stopAnimating];
       
       //结束上下拉刷新,刷新tableView
       [self.tableView.header endRefreshing];
       [self.tableView.footer endRefreshing];
       
   }];
}
#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:LGBHeaderCellID forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBShowViewController * show = [[LGBShowViewController alloc]init];
    
    show.hidesBottomBarWhenPushed = YES;
    
    LGBHeaderModel * model = self.dataSource[indexPath.row];
    
    //传递播放vid
    show.vid = model.vid;
    
    
    [self presentViewController:show animated:YES completion:nil];
}


#pragma mark - 设置header
-(void)setupHeader
{
    NSLog(@"gfhjsdh");
    
   self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, LGBTitlesViewH + LGBTitlesViewY, LGBScreenW, 200) delegate:self placeholderImage:[UIImage imageNamed:@"我的-默认~iphone"]];
    
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.titlesGroup = self.titles;
    self.cycleScrollView.currentPageDotColor = [UIColor redColor]; // 自定义分页控件小圆标颜色
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleScrollView.imageURLStringsGroup = self.imageArray;
    });

    
    self.tableView.tableHeaderView = self.cycleScrollView;
    
  
    
    __weak LGBHeaderViewController * weakSelf = self;
    // block监听点击方式
    self.cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
      
        LGBShowViewController * show = [[LGBShowViewController alloc]init];
        show.hidesBottomBarWhenPushed = YES;
        
        show.vid = weakSelf.tidArray[index];
        
        [weakSelf presentViewController:show animated:YES completion:nil];
        
    };

}


@end



