//
//  MineCommentViewController.m
//  YogaProject
//
//  Created by students on 16/2/19.
//  Copyright (c) 2016年 JackKingf. All rights reserved.
//

#import "MineCommentViewController.h"
#import "KVNProgress.h"
@interface MineCommentViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *conpl;

@end

@implementation MineCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.context.delegate = self;
    self.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.iponeText.keyboardType = UIKeyboardTypePhonePad;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.conpl.hidden = YES;
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.iponeText resignFirstResponder];
    [self.context resignFirstResponder];
    [self.emailText resignFirstResponder];
}


- (IBAction)postComment:(id)sender {
    
    if (self.context.text.length > 0) {
        
        if (self.iponeText.text.length > 0 ) {
            if (self.iponeText.text.length == 11) {
                
            }else{
                self.iponeText.text = @"";
                [KVNProgress showErrorWithStatus:@"请输入11位手机号码"];
                return;
            }
        }
        
        if (self.emailText.text.length > 2 && [self.emailText.text containsString:@"@"]) {
            
        }else{
            [KVNProgress showErrorWithStatus:@"email格式不正确"];
            return;
        }
        
        
    }else{
        [KVNProgress showErrorWithStatus:@"建议不能为空"];
        return;
    }
    
    NSLog(@"提交建议");
    
}

- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


@end
