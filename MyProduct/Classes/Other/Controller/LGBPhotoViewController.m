//
//  LGBPhotoViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/11.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBPhotoViewController.h"

@interface LGBPhotoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)UIImagePickerController * picker;

@end

@implementation LGBPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createPicker];
    
    [self createBackButton];
    
    
}
#pragma mark - 返回按钮
-(void)createBackButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, 100, 100);
    
    [button setTitle:@"返回" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

-(void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [self presentViewController:self.picker animated:YES completion:nil];
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
    
    //手动返回
    [picker dismissViewControllerAnimated:YES completion:nil];
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
