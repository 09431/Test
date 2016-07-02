//
//  MineCommentViewController.h
//  YogaProject
//
//  Created by students on 16/2/19.
//  Copyright (c) 2016年 JackKingf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCommentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *context;

@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *iponeText;
- (IBAction)postComment:(id)sender;
- (IBAction)backBtn:(id)sender;
@end
