//
//  LGBRootViewController.h
//  MyProduct
//
//  Created by Bing on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGBRootViewController : UIViewController

@property (nonatomic,retain) MBProgressHUD* hud;
- (void)addHud;

- (void)removeHud;

@end
