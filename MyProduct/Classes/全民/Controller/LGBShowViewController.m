//
//  LGBShowViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/6.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBShowViewController.h"
#import "WMPlayer.h"
#import "SDCycleScrollView.h"
#import "LGBDetailCell.h"
#import "LGBDetailModel.h"

@interface LGBShowViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    WMPlayer * _wmPlayer;
}
//评论的信息
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *zenLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *bofangLabel;


@property (nonatomic,strong)SDCycleScrollView * scrollView;

//下面的tableView
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray * dataSource;

@property (nonatomic,strong)NSMutableArray * imageArray;

@end
static NSString * const LGBDetailCellID = @"detail";

@implementation LGBShowViewController
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}
- (void)viewDidLoad {
  
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self loadMovie];
    
    [self createRefresh];
    
    [self setupTableView];
    
}
#pragma mark - 创建刷新
-(void)createRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.tableView.header beginRefreshing];
}
-(void)loadData
{
   [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:DetailUrl,self.vid] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
       //评论 窗口
       NSDictionary * dic = responseObject[@"body"][@"obj"][@"videoDetail"];
       self.zenLabel.text = dic[@"praise"];
       self.titleLabel.text = dic[@"title"];
       self.shareLabel.text = dic[@"forward"];
       self.bofangLabel.text = dic[@"playNum"];
       
      
       //轮播图
       NSArray * array = responseObject[@"body"][@"obj"][@"carousels"];
       for (NSDictionary * dict in array) {
           [self.imageArray addObject:dict[@"imageUrl"]];
       }
       //创建tableViewHeader
       [self createHeader];
       
     
       //tableView 数据
       NSArray * arr = responseObject[@"body"][@"obj"][@"relatedVideoDetails"];
       
       for (NSDictionary * dict in arr) {
           
           LGBDetailModel * model = [[LGBDetailModel alloc]init];
           
           [model setValuesForKeysWithDictionary:dict];
           
           [self.dataSource addObject:model];
       }
       
       [self.tableView.header endRefreshing];
       
       [self.tableView reloadData];
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       NSLog(@"%@",error);
   }];
}


#pragma mark - 创建tableView
-(void)setupTableView
{
    
    self.tableView.rowHeight = 100;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGBDetailCell class]) bundle:nil] forCellReuseIdentifier:LGBDetailCellID];
   
}
#pragma mark - tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:LGBDetailCellID forIndexPath:indexPath];
    
    LGBDetailModel * model = self.dataSource[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

-(void)loadMovie
{
    NSString * urlStr = [NSString stringWithFormat:@"http://f02.v1.cn/transcode/%@MOBILET2.mp4",self.vid];
    
    _wmPlayer = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 20, LGBScreenW, 250) videoURLStr:urlStr];
    
    [self.view addSubview:_wmPlayer];
    
    _wmPlayer.closeBtn.hidden= YES;
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 15, 20, 20);
  
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
  
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [_wmPlayer addSubview:backBtn];
    
    
    _wmPlayer.isPlaying = YES;
    [_wmPlayer play];
    
}

//返回按钮的点击方法
-(void)backBtn
{
    _wmPlayer.isPlaying = NO;
    [_wmPlayer pause];
    [_wmPlayer.player pause];
 
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)createHeader
{
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, LGBScreenW, 100) delegate:nil placeholderImage:[UIImage imageNamed:@"我的-默认~iphone"]];
    
    _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    _scrollView.currentPageDotColor = [UIColor redColor]; // 自定义分页控件小圆标颜色
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _scrollView.imageURLStringsGroup = self.imageArray;
    });
    
    
    self.tableView.tableHeaderView = _scrollView;

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
