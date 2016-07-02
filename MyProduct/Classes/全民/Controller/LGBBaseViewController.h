//
//  LGBBaseViewController.h
//  MyProduct
//
//  Created by Bing on 16/5/9.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGBBaseViewController : UITableViewController

@property (nonatomic,retain) MBProgressHUD* hud;
- (void)addHud;

- (void)removeHud;
@end
