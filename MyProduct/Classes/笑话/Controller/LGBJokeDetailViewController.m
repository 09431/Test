//
//  LGBJokeDetailViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/13.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBJokeDetailViewController.h"
#import "LGBWordCell.h"
#import "LGBWordModel.h"

#import "LGBComment.h"
#import "LGBCommentCell.h"

@interface LGBJokeDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic,strong)NSMutableArray * dataSource;
@end

static NSString * const LGBJokeCellID = @"cell";

@implementation LGBJokeDetailViewController
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
    
    [self setupHeader];
    
    [self setupBasic];
    
    [self setupRefresh];
    
}
#pragma mark - tableViewHeader
-(void)setupHeader
{
    self.navigationController.navigationBar.translucent = NO;
    
    UIView * header = [[UIView alloc]init];
    
    LGBWordCell * cell = [LGBWordCell cell];
    cell.model = self.model;
    
    header.size = cell.size;
    
    cell.size = CGSizeMake(LGBScreenW, self.model.cellHeight);
    
    [header addSubview:cell];
    
    header.height = cell.height + LGBTopicCellMargin;
    
    self.tableView.tableHeaderView = header;

    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGBCommentCell class]) bundle:nil] forCellReuseIdentifier:LGBJokeCellID];
}

#pragma mark - 创建通知
-(void)setupBasic
{
    
    self.title = @"评论";
    
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWithChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}
-(void)keyboardWithChangeFrame:(NSNotification *)note
{
  //键盘显示/隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.bottomSpace.constant = LGBScreenH - frame.origin.y;
    
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];  //强制布局
    }];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//滑动的时候结束编辑
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - 创建tableView
-(void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.tableView.header beginRefreshing];
}
-(void)loadData
{
    [self addHud];
    
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:CommentURL,self.model.ID] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self.dataSource removeAllObjects];
        
        NSArray * array = responseObject[@"items"];
        
        for (NSDictionary * dict in array) {
            
            LGBComment * model = [[LGBComment alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataSource addObject:model];
        }
        
        [self.tableView.header endRefreshing];
        
        [self removeHud];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
        [self removeHud];
        [self.tableView.header endRefreshing];
    
    }];
}
#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:LGBJokeCellID forIndexPath:indexPath];
    
    LGBComment * model = self.dataSource[indexPath.row];
    
    cell.model = model;
    
    cell.numLabel.text = [NSString stringWithFormat:@"%ld楼",indexPath.row+1];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBComment * model = self.dataSource[indexPath.row];
    
    return model.cellHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc]init];
    header.backgroundColor = LGBGlobalBg;
    
    UILabel * label = [[UILabel alloc]init];
    label.textColor = LGBColor(70, 70, 70);
    label.x = LGBTopicCellMargin;
    
    label.width = 200;
    
    label.text = @"最新评论:";
    //自动调整子控件与父控件中间的位置,
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight; //自动调整自己的高度,保证父视图顶部与顶部距离不变
    
    [header addSubview:label];
    
    return header;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
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
