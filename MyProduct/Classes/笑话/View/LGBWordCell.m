//
//  LGBWordCell.m
//  MyProduct
//
//  Created by Bing on 16/5/12.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBWordCell.h"

#import "LGBWordModel.h"

#import "UMSocial.h"

@interface LGBWordCell ()

//name
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//type类型
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
//type类型名字
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
//正文
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
//评论数
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
//分享数
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;



@end


@implementation LGBWordCell
//分享按钮
- (IBAction)shareButton:(id)sender {
    
    //shareText 在实际项目开发中是从服务器获取的字符串
    //shareImage 是从服务器获取的图片 (一般从服务器获取到的图片的地址,需要转换成UIImage对象)
//    //shareToSnsNames 表示需要分享到的平台名称
//    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@""]]];
//    
//    [UMSocialSnsService presentSnsIconSheetView:[UIApplication sharedApplication].keyWindow.rootViewController appKey:@"" shareText:@"" shareImage:image shareToSnsNames:@[UMShareToTencent,UMShareToTwitter,UMShareToSina,UMShareToQzone,UMShareToWechatTimeline] delegate:nil];
//    
}

+(instancetype)cell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(LGBWordModel *)model
{
    _model = model;
    
    self.nameLabel.text = model.user[@"login"];

    self.commentLabel.text = [NSString stringWithFormat:@"%zd",model.comments_count];
    
    self.shareLabel.text = [NSString stringWithFormat:@"%zd",model.share_count];
    self.wordLabel.text = model.content;
    
    //热门
    if ([model.type isEqualToString:@"hot"]) {
        self.typeImageView.image = [UIImage imageNamed:@"hot"];
        self.typeNameLabel.text = @"热门";
    }
    else if ([model.type isEqualToString:@"fresh"]){
        self.typeImageView.image = [UIImage imageNamed:@"fresh"];
        self.typeNameLabel.text = @"新鲜";
    }
    else{
        self.typeImageView.frame = CGRectMake(0, 0, 0, 0);
        self.typeNameLabel.frame = CGRectMake(0, 0, 0, 0);
    }

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
