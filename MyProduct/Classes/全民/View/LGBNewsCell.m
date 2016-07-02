//
//  LGBNewsCell.m
//  MyProduct
//
//  Created by Bing on 16/5/7.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBNewsCell.h"
#import "LGBNewsModel.h"


@interface LGBNewsCell ()


@end



@implementation LGBNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(LGBNewsModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.title;
    
    NSInteger min = [model.duration integerValue]/60;
    NSInteger sec = [model.duration integerValue]%60;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"recommendAppPlaceHolder~iphone"]];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = LGBTopicCellMargin;
    frame.size.width = frame.size.width - 2*frame.origin.x;
    frame.size.height -=10;
    
    frame.origin.y +=LGBTopicCellMargin;
    
    [super setFrame:frame];
}
@end
