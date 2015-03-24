//
//  UIView+YXCornerMark.h
//  角标
//
//  Created by 沈 晨豪 on 15/3/23.
//  Copyright (c) 2015年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXCornerMarkView.h"

@interface UIView (YXCornerMark)
@property (readonly,strong,nonatomic) YXCornerMarkView *cornerMarkView;
@property (readonly,strong,nonatomic) NSNumber         *cornerMarkDirection;
@property (readonly,strong,nonatomic) NSNumber         *cornerMarkNumber;
@property (readonly,strong,nonatomic) NSValue          *cornerMarkSize;

- (void)yxHiddenCornerMarkView;
- (void)yxShowCorerMarkView;

- (void)yxSetCornerMarkNumber: (NSInteger) number
                     withSize: (CGSize) size
                    withColor: (UIColor*) color
                withDirection: (YXCornerMarkDirection) direction;

/**
 * 默认 YXCornerMarkDirectionRightTop    = 0,  //右上 角标
 * 根据size自动匹配字体大小的
 */
- (void)yxSetCornerMarkNumber: (NSInteger) number
                    withColor: (UIColor*) color
                     withSize: (CGSize) size;

/**
 * 默认 YXCornerMarkDirectionRightTop    = 0,  //右上 角标
 * 根据width自动匹配字体大小的
 */
- (void)yxSetCornerMarkNumber: (NSInteger) number
                    withColor: (UIColor*) color
                    withWidth: (CGFloat) width;


- (void)yxSetCornerMarkNumber: (NSInteger) number
                    withColor: (UIColor*) color
                    withWidth: (CGFloat) width
            characterFontSize: (CGFloat) cSize
               numberFontSize: (CGFloat) nSize
                withDirection: (YXCornerMarkDirection) direction;

/**
 * 默认 YXCornerMarkDirectionRightTop    = 0,  //右上 角标
 * 自己设置字体的大小 NO.XXXXX  NO. 为 cSzie  XXXX为 nSize
 */
- (void)yxSetCornerMarkNumber: (NSInteger) number
                    withColor: (UIColor*) color
                    withWidth: (CGFloat) width
            characterFontSize: (CGFloat) cSize
               numberFontSize: (CGFloat) nSize;


- (void)updateCornerMarkViewFrame;

@end
