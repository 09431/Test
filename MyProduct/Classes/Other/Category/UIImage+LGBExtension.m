//
//  UIImage+LGBExtension.m
//  MyProduct
//
//  Created by Bing on 16/5/14.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "UIImage+LGBExtension.h"

@implementation UIImage (LGBExtension)
+(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    UIGraphicsBeginImageContext(image1.size);
    
    //Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    //Draw image2
    
    [image2 drawInRect:CGRectMake((image1.size.width - 60)/ 2, (image1.size.height - 60)/2, 60, 60)];
    
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}
@end
