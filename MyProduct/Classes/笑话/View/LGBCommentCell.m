//
//  LGBCommentCell.m
//  MyProduct
//
//  Created by Bing on 16/5/13.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBCommentCell.h"
#import "LGBComment.h"


@interface LGBCommentCell ()
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end




@implementation LGBCommentCell

- (void)awakeFromNib {
    // Initialization code
    
}

-(void)setModel:(LGBComment *)model
{
    _model = model;
    
    self.loginLabel.text = model.user[@"login"];
    
    self.commentLabel.text = model.content;
    
    self.timeLabel.text = model.created_at;
    
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = LGBTopicCellMargin;
    frame.size.width = frame.size.width - 2*frame.origin.x;
    frame.size.height = self.model.cellHeight - LGBTopicCellMargin;
    frame.origin.y +=LGBTopicCellMargin;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
