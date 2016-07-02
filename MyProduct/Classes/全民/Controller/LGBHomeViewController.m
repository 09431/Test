//
//  LGBHomeViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBHomeViewController.h"
#import "LGBHeaderViewController.h"
#import "LGBNewsViewController.h"
#import "LGBFunnyViewController.h"
#import "LGBVRViewController.h"
#import "LGBMusicViewController.h"
#import "LGBSportsViewController.h"
#import "LGBMenViewController.h"
#import "LGBSTViewController.h"
#import "LGBCarViewController.h"
#import "LGBMilitaryViewController.h"
#import "LGBGeniusViewController.h"
#import "LGBBabyViewController.h"
#import "LGBFoodViewController.h"
#import "LGBConstellationViewController.h"
#import "LGBHealthyViewController.h"
#import "LGBTravelViewController.h"
#import "LGBPopNewsViewController.h"
#import "LGBEyesViewController.h"
#import "LGBFinancialViewController.h"

#import "CAPSPageMenu.h"


@interface LGBHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)CAPSPageMenu * pageMenu;

@end



@implementation LGBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];

    [self setupchildView];
  
    
}

#pragma mark -设置导航栏
-(void)setupNav
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    imageView.image = [UIImage imageNamed:@"关于我们logo~iphone"];
    
    self.navigationItem.titleView = imageView;
    
}
#pragma mark - 初始化子视图控制器
-(void)setupchildView
{
    LGBHeaderViewController * header = [[LGBHeaderViewController alloc]init];
    header.title = @"头条";
    
    LGBNewsViewController * news = [[LGBNewsViewController alloc]init];
    news.title = @"新闻";
    
    LGBFunnyViewController * funny = [[LGBFunnyViewController alloc]init];
    funny.title = @"搞笑";
    
    LGBVRViewController * vr = [[LGBVRViewController alloc]init];
    vr.title = @"VR";
    
    LGBMusicViewController * music = [[LGBMusicViewController alloc]init];
    music.title = @"音乐";
    
    LGBSportsViewController * sports = [[LGBSportsViewController alloc]init];
    sports.title = @"体育";
    
    LGBMenViewController * men = [[LGBMenViewController alloc]init];
    men.title = @"男神";
    
    LGBSTViewController * st = [[LGBSTViewController alloc]init];
    st.title = @"科技";
    
    LGBCarViewController * car = [[LGBCarViewController alloc]init];
    car.title = @"汽车";
    
    LGBMilitaryViewController * military = [[LGBMilitaryViewController alloc]init];
    military.title = @"军事";
    
    LGBGeniusViewController * genius = [[LGBGeniusViewController alloc]init];
    genius.title = @"牛人";
    
    LGBBabyViewController * baby = [[LGBBabyViewController alloc]init];
    baby.title = @"亲子";
    
    LGBFoodViewController * food = [[LGBFoodViewController alloc]init];
    food.title = @"美食";
    
    LGBConstellationViewController * constellation = [[LGBConstellationViewController alloc]init];
    constellation.title = @"星座";
    
    LGBHealthyViewController * healthy = [[LGBHealthyViewController alloc]init];
    healthy.title = @"健康";
    
    LGBTravelViewController * travel = [[LGBTravelViewController alloc]init];
    travel.title = @"旅行";
    
    LGBPopNewsViewController * popnews = [[LGBPopNewsViewController alloc]init];
    popnews.title = @"娱乐";
    
    LGBEyesViewController * eyes = [[LGBEyesViewController alloc]init];
    eyes.title = @"开眼";
    
    LGBFinancialViewController * financial = [[LGBFinancialViewController alloc]init];
    financial.title = @"财经";
    
    
    NSArray * controllerArray = @[header,news,financial,popnews,funny,eyes,vr,travel,healthy,constellation,food,baby,genius,sports,men,music,st];
    
    NSDictionary * params = @{
                              
                              CAPSPageMenuOptionSelectionIndicatorColor: [UIColor redColor],
                             
                              CAPSPageMenuOptionMenuHeight: @(LGBTitlesViewH),
                              CAPSPageMenuOptionMenuItemWidth: @(40.0),
                              CAPSPageMenuOptionCenterMenuItems: @(YES)
                              
                              };
    
    self.pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0, 64, LGBScreenW,LGBScreenH ) options:params];
    [self.view addSubview:self.pageMenu.view];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
