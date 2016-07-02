//
//  LGBContentViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/9.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBContentViewController.h"
#import "LGBNewsCell.h"
#import "LGBNewsModel.h"
#import "WMPlayer.h"
#import "DetailViewController.h"





@interface LGBContentViewController ()<UIScrollViewDelegate>

{
    
    WMPlayer * _wmPlayer;
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
}
@property (nonatomic,strong)NSMutableArray * dataSource;

@property (nonatomic,retain)LGBNewsCell * currentCell;
//记录当前页数
@property (nonatomic,assign)int page;

//视频进度条的单击事件
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

static NSString * const LGBNewsCellID = @"news";

@implementation LGBContentViewController

//初始化数据源
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
        isSmallScreen = NO;
    }
    return _dataSource;
}

// tabBar 显示与隐藏状态的
-(BOOL)prefersStatusBarHidden
{
    if (_wmPlayer){
        if (_wmPlayer.isFullscreen) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}
-(void)videoDidFinished:(NSNotification *)notice
{
    
    LGBNewsCell *currentCell = (LGBNewsCell *)[self.tableView cellForRowAtIndexPath:
                                               [NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [currentCell.timeLabel.superview bringSubviewToFront:currentCell.timeLabel];//加
    
    [self releaseWMPlayer];
    
    [self setNeedsStatusBarAppearanceUpdate];
}
-(void)closeTheVideo:(NSNotification *)obj
{
    
    LGBNewsCell * currentCell = (LGBNewsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [currentCell.timeLabel.superview bringSubviewToFront:currentCell.timeLabel];//加
    
    [self releaseWMPlayer];
    
    [self setNeedsStatusBarAppearanceUpdate];
}
-(void)fullScreenBtnClick:(NSNotification *)notice
{
    
    UIButton *fullScreenBtn = (UIButton *)[notice object];
  
    if (fullScreenBtn.isSelected) {//全屏显示
        _wmPlayer.isFullscreen = YES;
        
        [self setNeedsStatusBarAppearanceUpdate];
        
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        if (isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange
{
    if (_wmPlayer==nil||_wmPlayer.superview==nil){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (_wmPlayer.isFullscreen) {
                if (isSmallScreen) {
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }else{
                    [self toCell];
                }
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            if (_wmPlayer.isFullscreen == NO) {
                _wmPlayer.isFullscreen = YES;
                
                [self setNeedsStatusBarAppearanceUpdate];
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            if (_wmPlayer.isFullscreen == NO) {
                _wmPlayer.isFullscreen = YES;
                
                [self setNeedsStatusBarAppearanceUpdate];
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        default:
            break;
    }
}
-(void)toCell
{
    LGBNewsCell * currentCell = (LGBNewsCell  *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    
    [_wmPlayer removeFromSuperview];
   
    [UIView animateWithDuration:0.5f animations:^{
        _wmPlayer.transform = CGAffineTransformIdentity;
        _wmPlayer.frame = currentCell.picImageView.bounds;
        _wmPlayer.playerLayer.frame =  _wmPlayer.bounds;
        
        [currentCell.picImageView addSubview:_wmPlayer];
        [currentCell.picImageView bringSubviewToFront:_wmPlayer];
        [_wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmPlayer).with.offset(0);
            make.right.equalTo(_wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_wmPlayer).with.offset(0);
        }];
        
        [_wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_wmPlayer).with.offset(5);
        }];
    }completion:^(BOOL finished) {
        _wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        isSmallScreen = NO;
        _wmPlayer.fullScreenBtn.selected = NO;
        
    }];
    
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation
{
    [_wmPlayer removeFromSuperview];
    _wmPlayer.transform = CGAffineTransformIdentity;
    
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        _wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
        
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        _wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    
    _wmPlayer.frame = CGRectMake(0, 0, LGBScreenW, LGBScreenH);
    _wmPlayer.playerLayer.frame =  CGRectMake(0,0, LGBScreenH, LGBScreenW);
    
    [_wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(LGBScreenW-40);
        make.width.mas_equalTo(LGBScreenH);
    }];
    
    [_wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_wmPlayer).with.offset((-LGBScreenH/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(_wmPlayer).with.offset(5);
        
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:_wmPlayer];
    
    _wmPlayer.fullScreenBtn.selected = YES;
    [_wmPlayer bringSubviewToFront:_wmPlayer.bottomView];
    
}
-(void)toSmallScreen
{
    //放widow上
    [_wmPlayer removeFromSuperview];
    
    [UIView animateWithDuration:0.5f animations:^{
        _wmPlayer.transform = CGAffineTransformIdentity;
        _wmPlayer.frame = CGRectMake(LGBScreenW/2,LGBScreenH-LGBTableBarH-(LGBScreenW/2)*0.75, LGBScreenW/2, (LGBScreenW/2)*0.75);
        _wmPlayer.playerLayer.frame =  _wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:_wmPlayer];
        [_wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmPlayer).with.offset(0);
            make.right.equalTo(_wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_wmPlayer).with.offset(0);
        }];
        
        [_wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_wmPlayer).with.offset(5);
            
        }];
        
    }completion:^(BOOL finished) {
        _wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        _wmPlayer.fullScreenBtn.selected = NO;
        isSmallScreen = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_wmPlayer];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:WMPlayerFullScreenButtonClickedNotification object:nil];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGBNewsCell class]) bundle:nil] forCellReuseIdentifier:LGBNewsCellID];
    
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeTheVideo:)
                                                 name:WMPlayerClosedNotification
                                               object:nil
     ];
    
//    
//    //加
//    // 单击的 Recognizer
//    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
//    singleTap.numberOfTapsRequired = 1; // 单击
//    [self.view addGestureRecognizer:singleTap];
//    
//    // 双击的 Recognizer
//    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap)];
//    doubleTap.numberOfTapsRequired = 2; // 双击
//    [self.view addGestureRecognizer:doubleTap];
    
    
    
    //创建刷新
    [self setupRefresh];
    
}
#pragma mark - 创建刷新
-(void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.header beginRefreshing];
    
    //自动改变透明度
    self.tableView.header.automaticallyChangeAlpha = YES;
    
    self.tableView.rowHeight = 220;
    
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
    //添加活动指示器
    [self addHud];
    
    dispatch_queue_t global_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(global_t, ^{
        
        [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:self.path,self.page] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSArray * array = responseObject[@"body"][@"data"];
            
            for (NSDictionary * dict in array) {
                LGBNewsModel * model = [[LGBNewsModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [self.dataSource addObject:model];
            }
            
            
            //隐藏活动指示器
            [self removeHud];
            
            //结束上下拉刷新,刷新tableView
            if (_page == 0) {
                [self.tableView.header endRefreshing];
            }
            else{
                [self.tableView.footer endRefreshing];
            }
            [self.tableView reloadData];
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
            
            //隐藏活动指示器
            [self removeHud];
            
            //结束上下拉刷新,刷新tableView
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            
        }];
     
    });
    
}

#pragma mark - 代理方法

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:LGBNewsCellID forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];
    
    [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.playBtn.tag = indexPath.row;
    
    
    if (_wmPlayer&&_wmPlayer.superview) {
        if (indexPath.row==currentIndexPath.row) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
            [cell.timeLabel.superview sendSubviewToBack:cell.timeLabel]; //加
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
            [cell.timeLabel.superview bringSubviewToFront:cell.timeLabel]; //加
        }
        
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:currentIndexPath]) {//复用
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_wmPlayer]) {
                _wmPlayer.hidden = NO;
            }else{
                _wmPlayer.hidden = YES;
                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
                [cell.timeLabel.superview bringSubviewToFront:cell.timeLabel]; //加
            }
        }else{
            if ([cell.picImageView.subviews containsObject:_wmPlayer]) {
                [cell.picImageView addSubview:_wmPlayer];
                
                [_wmPlayer play];
                _wmPlayer.hidden = NO;
            }
            
        }
    }
    
    
    return cell;
    
}
-(void)startPlayVideo:(UIButton *)sender
{
    
    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=8||[UIDevice currentDevice].systemVersion.floatValue<7) {
        self.currentCell = (LGBNewsCell *)sender.superview.superview;
        
    }else{//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
        self.currentCell = (LGBNewsCell *)sender.superview.superview.subviews;
        
    }
    
    LGBNewsModel *model = self.dataSource[sender.tag];
    
    isSmallScreen = NO;
    
    if (_wmPlayer) {
        [_wmPlayer removeFromSuperview];
        [_wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
        [_wmPlayer setVideoURLStr:model.videoUrl];
        [_wmPlayer play];
        
    }else{
        _wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.picImageView.bounds videoURLStr:model.videoUrl];
        
    }
    //播放的时候,改变 imageView上UI的状态
    [self.currentCell.picImageView addSubview:_wmPlayer];
    [self.currentCell.picImageView bringSubviewToFront:_wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
   // self.currentCell.playBtn.hidden = YES;
    
    [self.currentCell.timeLabel.superview sendSubviewToBack:self.currentCell.timeLabel];
    [self.tableView reloadData];
    
}
#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.tableView){
        if (_wmPlayer==nil) {
            return;
        }

    if(_wmPlayer.superview){
        
        CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:currentIndexPath];
        CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
        
        if (rectInSuperview.origin.y<-self.currentCell.picImageView.frame.size.height||rectInSuperview.origin.y>LGBScreenH -kNavbarHeight + LGBTableBarH) {//往上拖动
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_wmPlayer]&&isSmallScreen) {
                isSmallScreen = YES;
            }else{
                //放widow上,小屏显示
                [self toSmallScreen];
            }

            
        }else{
            if ([self.currentCell.picImageView.subviews containsObject:_wmPlayer]) {
                
            }else{
                [self toCell];
            }
          }
        }
    }
}
//关闭  tableView  选中
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    LGBNewsModel *   model = self.dataSource[indexPath.row];
//    
//
//    DetailViewController *detailVC = [[DetailViewController alloc]init];
//    
//    detailVC.URLString  = model.videoUrl;
//    detailVC.title = model.title;
//    [self.navigationController pushViewController:detailVC animated:YES];
//}


/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer
{
    [_wmPlayer.player.currentItem cancelPendingSeeks];
    [_wmPlayer.player.currentItem.asset cancelLoading];
    [_wmPlayer pause];
    
    //移除观察者
    [_wmPlayer.currentItem removeObserver:_wmPlayer forKeyPath:@"status"];
    
    [_wmPlayer removeFromSuperview];
    [_wmPlayer.playerLayer removeFromSuperlayer];
    [_wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    _wmPlayer.player = nil;
    _wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [_wmPlayer.autoDismissTimer invalidate];
    _wmPlayer.autoDismissTimer = nil;
    [_wmPlayer.durationTimer invalidate];
    _wmPlayer.durationTimer = nil;
    
    
    _wmPlayer.playOrPauseBtn = nil;
    _wmPlayer.playerLayer = nil;
    _wmPlayer = nil;
    
    currentIndexPath = nil;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self releaseWMPlayer];
}

@end

