//
//  LGBLiveCell.m
//  MyProduct
//
//  Created by Bing on 16/5/4.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBLiveCell.h"
#import "LGBLiveModel.h"

@interface LGBLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *urlImageView;

@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *citynameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fanscountLabel;

@end


@implementation LGBLiveCell

- (void)awakeFromNib {
    // Initialization code
    
    self.faceImageView.layer.cornerRadius = 20;
    self.faceImageView.layer.masksToBounds = YES;
}

-(void)setModel:(LGBLiveModel *)model
{
    _model = model;
    
    [self.urlImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:model.face_url]];
    
    
    self.titleLabel.text = model.title;
    self.citynameLabel.text = model.city_name;
    
    if ([model.fancount integerValue] > 10000) {
         self.fanscountLabel.text = [NSString stringWithFormat:@"%.1f万人观看",[model.fancount integerValue]/10000.0];
    }
    else{
         self.fanscountLabel.text = [NSString stringWithFormat:@"%@人观看",model.fancount];
    }
}




@end
