//
//  LGBJokeViewController.m
//  MyProduct
//
//  Created by Bing on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBJokeViewController.h"
#import "LGBWordModel.h"
#import "MBProgressHUD.h"
#import "LGBWordCell.h"

#import "LGBJokeDetailViewController.h"


@interface LGBJokeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray * dataSource;

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,assign)NSInteger page;

@end

static NSString * const LGBWordCellID = @"cell";

@implementation LGBJokeViewController
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"糗百段子";
    
    [self createTableView];
    
    [self setupRefresh];
}
#pragma mark - 创建tableView
-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LGBScreenW, LGBScreenH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = LGBGlobalBg;
    
    [self.view addSubview:self.tableView];
    
   
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGBWordCell class]) bundle:nil] forCellReuseIdentifier:LGBWordCellID];

}
#pragma mark - tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBWordCell * cell = [tableView dequeueReusableCellWithIdentifier:LGBWordCellID forIndexPath:indexPath];
    
    LGBWordModel * model = self.dataSource[indexPath.row];
    
    cell.model = model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBJokeDetailViewController * detail = [[LGBJokeDetailViewController alloc]init];

    LGBWordModel * model = self.dataSource[indexPath.row];
    
    detail.model = model;
    
    detail.hidesBottomBarWhenPushed = YES;
 
    [self.navigationController pushViewController:detail animated:YES];
    
}
#pragma mark - 创建刷新
-(void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.header beginRefreshing];
}
-(void)loadNewData
{
    self.page = 1;
    [self loadData];
}
-(void)loadMoreData
{
    self.page++;
    [self loadData];
}
-(void)loadData
{
   [self addHud];
    
  [[AFHTTPSessionManager manager]GET:[NSString stringWithFormat:WordURL,self.page] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
      
      NSArray * array = responseObject[@"items"];
      
      for (NSDictionary * dict in array) {
          
          LGBWordModel * model = [[LGBWordModel alloc]init];
        
          [model setValuesForKeysWithDictionary:dict];
          
          [self.dataSource addObject:model];
      }
      
      if (self.page == 1) {
           [self.tableView.header endRefreshing];
      }
      else{
           [self.tableView.footer endRefreshing];
      }
      
      [self removeHud];
      
      [self.tableView reloadData];
      
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
      [self removeHud];
      
      NSLog(@"%@",error);
  }];
}

//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBWordModel * model = self.dataSource[indexPath.row];
    
    return model.cellHeight;
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
