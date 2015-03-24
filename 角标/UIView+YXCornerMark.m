//
//  UIView+YXCornerMark.m
//  角标
//
//  Created by 沈 晨豪 on 15/3/23.
//  Copyright (c) 2015年 sch. All rights reserved.
//

#import "UIView+YXCornerMark.h"
#import <objc/runtime.h>

static char YXCornerMarkKey;
static char YXCornerMarkDirectionKey;
static char YXCornerMarkNumberKey;
static char YXCornerMarkSizeKey;

@implementation UIView (YXCornerMark)

- (void)setCornerMarkView:(YXCornerMarkView *)cornerMarkView
{
    [self willChangeValueForKey:@"YXCornerMarkKey"];
    objc_setAssociatedObject(self, &YXCornerMarkKey, cornerMarkView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"YXCornerMarkKey"];
}

- (YXCornerMarkView *)cornerMarkView
{
    return objc_getAssociatedObject(self, &YXCornerMarkKey);
}

- (void)setCornerMarkDirection:(NSNumber *)cornerMarkDirection
{
    [self willChangeValueForKey:@"YXCornerMarkDirectionKey"];
    objc_setAssociatedObject(self, &YXCornerMarkDirectionKey, cornerMarkDirection, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"YXCornerMarkDirectionKey"];
}

- (NSNumber *)cornerMarkDirection
{
    return objc_getAssociatedObject(self, &YXCornerMarkDirectionKey);
}

- (void)setCornerMarkNumber:(NSNumber *)cornerMarkNumber
{
    [self willChangeValueForKey:@"YXCornerMarkNumberKey"];
    objc_setAssociatedObject(self, &YXCornerMarkNumberKey, cornerMarkNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"YXCornerMarkNumberKey"];
}

- (NSNumber *)cornerMarkNumber
{
    return objc_getAssociatedObject(self, &YXCornerMarkNumberKey);
}

- (void)setCornerMarkSize:(NSValue *)cornerMarkSize
{
    [self willChangeValueForKey:@"cornerMarkSize"];
    objc_setAssociatedObject(self, &YXCornerMarkSizeKey, cornerMarkSize, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"cornerMarkSize"];
}

- (NSValue *)cornerMarkSize
{
    return objc_getAssociatedObject(self, &YXCornerMarkSizeKey);
}

- (NSAttributedString *)numberStringWihtNumber: (NSInteger) number withSize: (CGSize) size
{
    
    CGFloat width = size.width;
    
    CGFloat NOFontSize     = width / 6.0;
    CGFloat offsetFontSize = NOFontSize * 15.0f / 9.0f;
    
    if(offsetFontSize - NOFontSize < 1.0f)
    {
        offsetFontSize = NOFontSize + 1.0f;
    }
    
    return [self numberStringWihtNumber:number withSize:size characterFontSize:NOFontSize numberFontSize:offsetFontSize];
    
    
}


- (NSAttributedString *)numberStringWihtNumber: (NSInteger) number withSize: (CGSize) size             characterFontSize: (CGFloat) cSize  numberFontSize: (CGFloat) nSize
{
    NSString *str = [NSString stringWithFormat:@"NO.%@",@(number)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range = [str rangeOfString:@"NO."];
    
    /*NO.XXX NO. 的属性*/
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:cSize]
                             range:range];
    
    /*NO.XXX XXX的属性*/
    NSRange range2 = NSMakeRange(range.length, str.length - range.length);
    
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:nSize]
                             range:range2];
    
    return attributedString;
    
}

- (void)yxHiddenCornerMarkView
{
    if (nil == self.cornerMarkView) return;
    
    self.cornerMarkView.hidden = YES;
}
- (void)yxShowCorerMarkView
{
    if (nil == self.cornerMarkView) return;
    
    self.cornerMarkView.hidden = NO;
}

- (void)yxSetCornerMarkNumber: (NSInteger) number
                     withSize: (CGSize) size
                    withColor: (UIColor*) color
                withDirection: (YXCornerMarkDirection) direction
{
    if (nil == self.cornerMarkView)
    {
        self.cornerMarkView = [[YXCornerMarkView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                 0.0f,
                                                                                 size.width,
                                                                                 size.height)];
        self.cornerMarkNumber    = @(number);
        self.cornerMarkSize      = [NSValue valueWithCGSize:size];
        self.cornerMarkDirection = @(direction);
        [self.cornerMarkView setCornerMarkType:YXCornerMarkTypeCustom];
        self.cornerMarkView.cornerMarkDirection = direction;
        [self.cornerMarkView setAttriTitle:[self numberStringWihtNumber:number withSize:size]];
        self.cornerMarkView.cornerMarkBackgroundColor = color;
        [self addSubview:self.cornerMarkView];
    }
    else
    {
        /*判断cornerMarkView大小有没有改变*/
        CGSize pSize = [self.cornerMarkSize CGSizeValue];
        
        if (!CGSizeEqualToSize(pSize, size))
        {
            self.cornerMarkView.frame = CGRectMake(0.0f,
                                                   0.0f,
                                                   size.width,
                                                   size.height);
            
            self.cornerMarkNumber = @(number);
            self.cornerMarkSize   = [NSValue valueWithCGSize:size];
            [self.cornerMarkView setAttriTitle:[self numberStringWihtNumber:number withSize:size]];
            [self updateCornerMarkViewFrame];
        }
        
        /*判断 数字是否改变*/
        if ([self.cornerMarkNumber integerValue] != number)
        {
            self.cornerMarkNumber = @(number);
            [self.cornerMarkView setAttriTitle:[self numberStringWihtNumber:number withSize:size]];
        }
        
        /*判断方位有没有改变*/
        if ([self.cornerMarkDirection integerValue] != direction)
        {
            self.cornerMarkDirection = @(direction);
            [self.cornerMarkView setCornerMarkDirection:direction];
        }
        
        
        self.cornerMarkView.cornerMarkBackgroundColor = color;
        
    }
}

/**
 * 默认 YXCornerMarkDirectionRightTop    = 0,  //右上 角标
 */
- (void)yxSetCornerMarkNumber: (NSInteger) number
                    withColor: (UIColor*) color
                     withSize: (CGSize) size
{
    [self yxSetCornerMarkNumber:number withSize:size withColor: (UIColor*) color withDirection:YXCornerMarkDirectionRightTop];
}

/**
 * 默认 YXCornerMarkDirectionRightTop    = 0,  //右上 角标
 */
- (void)yxSetCornerMarkNumber: (NSInteger) number
                    withColor: (UIColor*) color
                    withWidth: (CGFloat) width
{
    [self yxSetCornerMarkNumber:number withSize:CGSizeMake(width, width) withColor: (UIColor*) color withDirection:YXCornerMarkDirectionRightTop];
}



- (void)yxSetCornerMarkNumber: (NSInteger) number
                    withColor: (UIColor*) color
                     withSize: (CGSize) size
            characterFontSize: (CGFloat) cSize
               numberFontSize: (CGFloat) nSize
                withDirection: (YXCornerMarkDirection) direction
{
    if (nil == self.cornerMarkView)
    {
        self.cornerMarkView = [[YXCornerMarkView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                 0.0f,
                                                                                 size.width,
                                                                                 size.height)];
        self.cornerMarkNumber    = @(number);
        self.cornerMarkSize      = [NSValue valueWithCGSize:size];
        self.cornerMarkDirection = @(direction);
        [self.cornerMarkView setCornerMarkType:YXCornerMarkTypeCustom];
        self.cornerMarkView.cornerMarkDirection = direction;
        [self.cornerMarkView setAttriTitle:[self numberStringWihtNumber:number withSize:size characterFontSize:cSize numberFontSize:nSize]];
        self.cornerMarkView.cornerMarkBackgroundColor = color;
        [self addSubview:self.cornerMarkView];
    }
    else
    {
        /*改变数字*/
        self.cornerMarkNumber = @(number);
        [self.cornerMarkView setAttriTitle:[self numberStringWihtNumber:number withSize:size characterFontSize:cSize numberFontSize:nSize]];
        
        /*判断cornerMarkView大小有没有改变*/
        CGSize pSize = [self.cornerMarkSize CGSizeValue];
        
        if (!CGSizeEqualToSize(pSize, size))
        {
            self.cornerMarkView.frame = CGRectMake(0.0f,
                                                   0.0f,
                                                   size.width,
                                                   size.height);
            
            self.cornerMarkNumber = @(number);
            self.cornerMarkSize   = [NSValue valueWithCGSize:size];
            [self updateCornerMarkViewFrame];
        }
        
        /*判断方位有没有改变*/
        if ([self.cornerMarkDirection integerValue] != direction)
        {
            self.cornerMarkDirection = @(direction);
            [self.cornerMarkView setCornerMarkDirection:direction];
        }
        
        
        self.cornerMarkView.cornerMarkBackgroundColor = color;
        
    }
}

- (void)yxSetCornerMarkNumber: (NSInteger) number
                    withColor: (UIColor*) color
                    withWidth: (CGFloat) width
            characterFontSize: (CGFloat) cSize
               numberFontSize: (CGFloat) nSize
                withDirection: (YXCornerMarkDirection) direction
{
    [self yxSetCornerMarkNumber:number
                      withColor:color
                       withSize:CGSizeMake(width, width)
              characterFontSize:cSize
                 numberFontSize:nSize
                  withDirection:direction];
}

/**
 * 默认 YXCornerMarkDirectionRightTop    = 0,  //右上 角标
 * 自己设置字体的大小 NO.XXXXX  NO. 为 cSzie  XXXX为 nSize
 */
- (void)yxSetCornerMarkNumber: (NSInteger) number
                    withColor: (UIColor*) color
                    withWidth: (CGFloat) width
            characterFontSize: (CGFloat) cSize
               numberFontSize: (CGFloat) nSize
{
    [self yxSetCornerMarkNumber:number
                      withColor:color
                      withWidth:width
              characterFontSize:cSize
                 numberFontSize:nSize
                  withDirection:YXCornerMarkDirectionRightTop];
}

//YXCornerMarkDirectionRightTop    = 0,  //右上 角标
//YXCornerMarkDirectionRightBottom = 1,  //右下 角标
//YXCornerMarkDirectionLeftBottom  = 2,  //左下 角标
//YXCornerMarkDirectionLeftTop     = 3   //左上 角标

- (void)updateCornerMarkViewFrame
{
    if (nil == self.cornerMarkView) return;
    
    [self bringSubviewToFront:self.cornerMarkView];
    
    CGSize size = [self.cornerMarkSize CGSizeValue];
    
    switch ([self.cornerMarkDirection integerValue])
    {
        case YXCornerMarkDirectionRightTop:
            
            self.cornerMarkView.frame = CGRectMake(self.bounds.size.width - size.width,
                                                   0.0f,
                                                   size.width,
                                                   size.height);
            
            break;
        case YXCornerMarkDirectionRightBottom:
            
            self.cornerMarkView.frame = CGRectMake(self.bounds.size.width - size.width,
                                                   self.bounds.size.height - size.height,
                                                   size.width,
                                                   size.height);
            break;
        case YXCornerMarkDirectionLeftBottom:
            
            self.cornerMarkView.frame = CGRectMake(0.0f,
                                                   self.bounds.size.height - size.height,
                                                   size.width,
                                                   size.height);
            break;
        case YXCornerMarkDirectionLeftTop:
            
            self.cornerMarkView.frame = CGRectMake(0.0f,
                                                   0.0f,
                                                   size.width,
                                                   size.height);
            break;
            
        default:
            break;
    }
}

- (void)layoutSubviews
{
    [self updateCornerMarkViewFrame];
}

@end














