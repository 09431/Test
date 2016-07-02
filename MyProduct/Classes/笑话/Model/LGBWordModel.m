//
//  LGBWordModel.m
//  MyProduct
//
//  Created by Bing on 16/5/12.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBWordModel.h"

@implementation LGBWordModel

{
    CGFloat _cellHeight; //防止外界更改高度
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

-(CGFloat)cellHeight
{
    if (!_cellHeight) {
       
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * LGBTopicCellMargin - 2*8, MAXFLOAT);
              
        CGFloat textH = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        //cell的高度 (到文字)
        _cellHeight = 58 + textH + 8;
        
        //加上底部 评论view 和bottom
        _cellHeight += 85 + LGBTopicCellMargin;

    }
    
    return _cellHeight;
}

@end
