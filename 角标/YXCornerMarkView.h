//
//  YXCornerMarkView.h
//  角标
//
//  Created by 沈 晨豪 on 15/3/23.
//  Copyright (c) 2015年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YXCornerMarkDirection)
{
    YXCornerMarkDirectionRightTop    = 0,  //右上 角标
    YXCornerMarkDirectionRightBottom = 1,  //右下 角标
    YXCornerMarkDirectionLeftBottom  = 2,  //左下 角标
    YXCornerMarkDirectionLeftTop     = 3   //左上 角标
};


typedef NS_ENUM(NSUInteger, YXCornerMarkType)
{
    YXCornerMarkTypeNormal  = 0, //正常的  只需要设置 title 即可 自动计算 label font size
    YXCornerMarkTypeCustom  = 1  //个性话 开始这个则不 自动计算 label font size
    
};

@interface YXCornerMarkView : UIView

/**
 * 默认红色
 */
@property (nonatomic,strong) UIColor               *cornerMarkBackgroundColor;

/**
 * 默认为 右上 角标 YXCornerMarkDirectionRightTop
 */
@property (nonatomic,assign) YXCornerMarkDirection cornerMarkDirection;
/**
 * 角标的字符类型  默认 YXCornerMarkTypeRanking
 */
@property (nonatomic,assign )YXCornerMarkType      cornerMarkType;


@property (nonatomic,copy  ) NSString              *title;
@property (nonatomic,copy  ) NSAttributedString    *attriTitle;


@end
