//
//  LGBCommentCell.h
//  MyProduct
//
//  Created by Bing on 16/5/13.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGBComment;
@interface LGBCommentCell : UITableViewCell

@property (nonatomic,strong)LGBComment * model;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
