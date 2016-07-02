//
//  LGBRecommondController.m
//  MyProduct
//
//  Created by Bing on 16/5/3.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBRecommondController.h"
#import "NBWaterFlowLayout.h"

#import "LGBLiveModel.h"
#import "LGBLiveCell.h"
#import "LGBLiveDetailController.h"

@interface LGBRecommondController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout>

{
    UICollectionView * _collectionView;
}

@property (nonatomic,strong)NSMutableArray * dataSource;

//分页
@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)MBProgressHUD * hud;

@end


@implementation LGBRecommondController

-(MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc]initWithView:self.view];
        
         _hud.labelText = @"加载中...";
        [self.view addSubview:_hud];
    }
   
    return _hud;
}


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
    
    self.page = 0;
    
    [self createUI];
    
    [self createRefresh];
    
}
#pragma mark - 创建UI
-(void)createUI
{
    
    //创建网格布局对象
    NBWaterFlowLayout * flowLayout = [[NBWaterFlowLayout alloc]init];
    
    //设置item的大小
    flowLayout.itemSize = CGSizeMake((LGBScreenW-40)/2, 230);
    
    //设置显示的列数
    flowLayout.numberOfColumns = 2;
    //设置代理
    flowLayout.delegate = self;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, LGBScreenW-20, LGBScreenH) collectionViewLayout:flowLayout];
  
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //设置背景色,默认是黑色的
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LGBLiveCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];

}
#pragma mark - 实现代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGBLiveCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    LGBLiveModel * model = self.dataSource[indexPath.item];
    
    [cell setModel:model];
    
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(NBWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

#pragma mark - 创建刷新
-(void)createRefresh
{
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //第一次进入 自动进入刷新
    [_collectionView.header beginRefreshing];
}
-(void)loadNewData
{
    self.page = 0;
    
    [self loadData];

}
-(void)loadMoreData
{
    self.page++;
    
    [self loadData];

}
-(void)loadData
{
    [self.hud show:YES];
    
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:LiveRecommond,self.page] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        for (NSDictionary * dict in responseObject[@"data"]) {
           LGBLiveModel * model = [[LGBLiveModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataSource addObject:model];
        }
     
        if (self.page == 0) {
            [_collectionView.header endRefreshing];
        }
        else{
            [_collectionView.footer endRefreshing];
        }
        
        //隐藏
        [self.hud hide:YES];
        
        //刷新界面
        [_collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGBLiveDetailController * detail = [[LGBLiveDetailController alloc]init];
    
    LGBLiveModel * model = self.dataSource[indexPath.item];
    
    detail.roomid = model.roomid;
    
    detail.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detail animated:YES];
    
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
