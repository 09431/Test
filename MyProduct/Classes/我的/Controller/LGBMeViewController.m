//
//  LGBMeViewController.m
//  MyProduct
//
//  Created by Bing on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBMeViewController.h"
#import "AppDelegate.h"
#import "MineCommentViewController.h"
#import "LGBAboutViewController.h"


@interface LGBMeViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray * dataSource;




//夜间模式
@property (nonatomic,strong)UIView * darkView;

@end

@implementation LGBMeViewController

#pragma mark - 登录按钮
- (IBAction)loginButton:(id)sender {
}
#pragma mark - 我的收藏
- (IBAction)stroeButton:(id)sender {
}
#pragma mark - 历史记录
- (IBAction)recoderButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //隐藏
    self.navigationController.navigationBarHidden = YES;
    
    _darkView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.dataSource = @[@"清除缓存",@"夜间模式",@"意见反馈",@"关于我们"];
    
}
#pragma mark - 代理协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
   
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 1) {
        UISwitch * swi = [[UISwitch alloc]initWithFrame:CGRectMake(LGBScreenW-60, 5, 40, 40)];
        //设置外边框颜色
        [swi addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        
        [cell.contentView addSubview:swi];
    }

    return cell;
}
-(void)switchClick:(UISwitch *)swi
{
    if (swi.on) {
        //设置背景
        _darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        //需要找到window ,并将添加到 window 上
        UIApplication * app = [UIApplication sharedApplication];
        AppDelegate * delegate = app.delegate;
        [delegate.window addSubview:_darkView];
        
        //响应者链
        _darkView.userInteractionEnabled = NO;
    }
    else{
      //从父类上移除
        [_darkView removeFromSuperview];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清除缓存
    if (indexPath.row == 0) {
        [self folderSizeWithPath:[self getPath]];
    }
    else if (indexPath.row == 2){
    
        MineCommentViewController *comm = [[MineCommentViewController alloc] init];
        comm.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:comm animated:YES];
    }
    else if (indexPath.row == 3){
        LGBAboutViewController * about = [[LGBAboutViewController alloc]init];
        about.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:about animated:YES];
    
    }
}


#pragma mark - 计算缓存文件的大小
//首先需要找到缓存文件的路径
-(NSString *)getPath
{
  //系统的缓存文件在沙盒目录下的Library文件下Cache文件夹,取出Library文件夹数组中的最后一个元素,表示的是缓存文件夹
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return path;
    
}
//计算缓存文件夹的大小
-(CGFloat)folderSizeWithPath:(NSString *)path
{
    //获取文件管理类的对象
    NSFileManager * manager = [NSFileManager defaultManager];
    
    CGFloat folderSize =  0.0;
    
    if ([manager fileExistsAtPath:path]) {
        
        //首先需要获取文件夹下的文件
        NSArray * fileArray = [manager subpathsAtPath:path];
        
        for (NSString * fileName in fileArray) {
            
            //获取每个子文件的路径
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            
            //每个文件的大小
            NSInteger fileSize = [manager attributesOfItemAtPath:filePath error:nil].fileSize;
            
            //字节 -> M转换
            folderSize += fileSize/1000.0/1000.0;
        }
        
        //删除文件夹
        [self deleteFolderSizeWith:folderSize];
        
        return folderSize;
    }

    return 0.0;
}
-(void)deleteFolderSizeWith:(CGFloat)folderSize
{
    if (folderSize > 0.01) {
        //提示用户
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"当前有%.2fM缓存,是否清理",folderSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
        
    }
    else{
      //告诉用户不用清理
        //提示用户
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经清理过了" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alertView show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1 ) {
        //彻底清理缓存
        [self clearCacheAtPath:[self getPath]];
    }
}
-(void)clearCacheAtPath:(NSString *)path
{
    NSFileManager * manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:path]) {
        NSArray * fileArray = [manager subpathsAtPath:path];
        //我们可以操作保留某些格式文件
        for (NSString * fileName in fileArray) {
            if ([fileName hasSuffix:@",mp4"]) {
                NSLog(@"不删除");
            }
            else{
            //删除其余文件
                NSString * filePath = [path stringByAppendingPathComponent:fileName];
                
                [manager removeItemAtPath:filePath error:nil];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
