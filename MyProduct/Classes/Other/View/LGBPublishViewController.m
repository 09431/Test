//
//  LGBPublishViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/11.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBPublishViewController.h"
#import "LGBVerticalButton.h"
#import <POP.h>


@interface LGBPublishViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *
backImageView;

@property (nonatomic,strong)UIImagePickerController * picker;

@end

static CGFloat const LGBAnimationDelay = 0.1;
static CGFloat const LGBSpringFactor = 10;
@implementation LGBPublishViewController

- (IBAction)cancel:(id)sender {
    
    [UIView animateWithDuration:0.1 animations:^{
        //旋转 90
        self.backImageView.transform = CGAffineTransformMakeRotation(M_PI_4);
    }];
    
    [self cancleWithCompletionBlock:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //一进来让控制器不能被点击
    self.view.userInteractionEnabled = NO;
    
    NSArray * icons = @[@"MPTCapture_Photo~iphone",@"MPTCapture_Shot~iphone",@"MPTCapture_Import~iphone",@"addFriends_qq~iphone",@"addFriends_wechat~iphone",@"addFriends_sina~iphone"];
    
    NSArray * titles = @[@"上传图片",@"上传视频",@"发表文字",@"QQ分享",@"微信分享",@"新浪分享"];
    
    //中间6个按钮
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = LGBScreenH * 0.5 - buttonH;
    
    int macCols = 3;
    CGFloat buttonStartX = 45;
    CGFloat xMargin = (LGBScreenW - 2*buttonStartX - macCols * buttonW) / (macCols-1);
    
    for (int i=0; i<titles.count; i++) {
        LGBVerticalButton * button = [LGBVerticalButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 800, 0, 0); //给个初始位置,以免运行时在原点出现
        button.tag = 1000+i;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.view addSubview:button];
        
        //设置内容
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
        
        button.width = buttonW;
        button.height = buttonH;
        int row = i / macCols; //行号
        int col = i % macCols; //列号
        
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY + LGBScreenH;
        
        //添加动画
        POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        
        //下降速度 弹力
        anim.springBounciness = LGBSpringFactor;
        anim.springSpeed = LGBSpringFactor;
        
        anim.beginTime = CACurrentMediaTime() + LGBAnimationDelay;
        
        [button pop_addAnimation:anim forKey:nil];
        
        
        //监听 动画过程,恢复点击
        [anim setCompletionBlock:^(POPAnimation * anim, BOOL finished) {
            self.view.userInteractionEnabled = YES;
        }];
        
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancleWithCompletionBlock:nil];
}
//先执行动画退出,动画完毕后执行completionBlock
-(void)cancleWithCompletionBlock:(void(^)())completionBlock
{
    //一进来让控制器不能不能被点击
    self.view.userInteractionEnabled = NO;
    
    int beiginIndex = 0;  //子控件的个数
    
    for (int i=beiginIndex; i<self.view.subviews.count; i++) {
        UIView * subView = self.view.subviews[i];
        
        
        POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY +LGBScreenH;
        
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.springBounciness = LGBSpringFactor;
        anim.springSpeed = LGBSpringFactor;
        
        anim.beginTime = CACurrentMediaTime() +  LGBAnimationDelay;
        
        [subView pop_addAnimation:anim forKey:nil];
        
        //监听最后一个动画
        if (i == self.view.subviews.count -1) {
            [anim setCompletionBlock:^(POPAnimation * anim, BOOL finished) {
            
                //执行传进来的completionBlock参数
                if (completionBlock) {
                    completionBlock();
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }
    }
}

#pragma mark - 实例化图片选择控制器
-(void)createPicker
{
    self.picker = [[UIImagePickerController alloc]init];
    
    //在设置sourceType = Camera 的时候需要设置相机是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //表示相机可用
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        NSLog(@"相机不可用");
    }
    
    //选择图片的回调
    self.picker.delegate = self;
    
    //是否允许继续编辑 (默认是NO)
    self.picker.allowsEditing = YES;
    
    
    
    
}
//点击取消按钮的回调
//实现了这个协议方法,也需要手动返回
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
      [picker dismissViewControllerAnimated:YES completion:nil];
    
}

//选择图片的回调
//实现了这个协议方法,选择图片之后,需要点击进行返回的操作
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = image;
    
    [self.view addSubview:imageView];
    
    NSLog(@"-------");
    //手动返回
    [picker dismissViewControllerAnimated:NO completion:nil];
}


-(void)buttonClick:(UIButton *)button
{
    switch (button.tag-1000) {
        case 0:
        {
            [self presentViewController:self.picker animated:YES completion:nil];
            
            break;
        }
        case 1:
        {
            
            
            break;
        }
        case 2:
        {
            
            
            break;
        }
        case 3:
        {
            
            
            break;
        }
        case 4:
        {
            
            
            break;
        }
        case 5:
        {
            
            
            break;
        }
        default:
            break;
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
