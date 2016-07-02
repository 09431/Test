//
//  LGBWordCell.h
//  MyProduct
//
//  Created by Bing on 16/5/12.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGBWordModel;

@interface LGBWordCell : UITableViewCell

@property (nonatomic,strong)LGBWordModel * model;

+(instancetype)cell;


@end
