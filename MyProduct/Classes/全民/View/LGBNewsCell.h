//
//  LGBNewsCell.h
//  MyProduct
//
//  Created by Bing on 16/5/7.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LGBNewsModel;

@interface LGBNewsCell : UITableViewCell

@property (nonatomic,strong)LGBNewsModel * model;




@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@end
