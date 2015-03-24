//
//  YXCornerMarkView.m
//  角标
//
//  Created by 沈 晨豪 on 15/3/23.
//  Copyright (c) 2015年 sch. All rights reserved.
//

#import "YXCornerMarkView.h"

//YXCornerMarkDirectionRightTop    = 0,  //右上 角标
//YXCornerMarkDirectionRightBottom = 1,  //右下 角标
//YXCornerMarkDirectionLeftBottom  = 2,  //左下 角标
//YXCornerMarkDirectionLeftTop     = 3   //左上 角标

static NSDictionary *CornerMarkDirectionDic = nil;

@interface YXCornerMarkView()

@property (nonatomic,strong) UILabel *titleLabel;


- (void)initData;
- (void)initUI;


@end


@implementation YXCornerMarkView

#pragma mark - 
#pragma mark - private 

- (void)initUI
{
    self.backgroundColor       = [UIColor clearColor];
    _cornerMarkBackgroundColor = [UIColor redColor];
    _cornerMarkDirection       = YXCornerMarkDirectionRightTop;
    _cornerMarkType            = YXCornerMarkTypeNormal;
    
    {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLabel];
    }
    
 
}

- (void)initData
{
    if (nil == CornerMarkDirectionDic)
    {
        CornerMarkDirectionDic =  @{@(YXCornerMarkDirectionRightTop)   : @(M_PI_4),
                                    @(YXCornerMarkDirectionRightBottom): @(-M_PI_4),
                                    @(YXCornerMarkDirectionLeftBottom) : @(M_PI_4),
                                    @(YXCornerMarkDirectionLeftTop)    : @(-M_PI_4)};
    }
    

}

- (void)updateTitleLabelDirection
{
    _titleLabel.transform = CGAffineTransformIdentity;
    
    switch (_cornerMarkDirection)
    {
        case YXCornerMarkDirectionRightTop:
            _titleLabel.frame = CGRectMake( self.bounds.size.width  / 6.0f,
                                           -self.bounds.size.height / 6.0f ,
                                            self.bounds.size.width,
                                            self.bounds.size.height);
            break;
        case YXCornerMarkDirectionRightBottom:

            _titleLabel.frame = CGRectMake( self.bounds.size.width  / 6.0f,
                                            self.bounds.size.height / 6.0f ,
                                            self.bounds.size.width,
                                            self.bounds.size.height);
            break;
        case YXCornerMarkDirectionLeftBottom:
            _titleLabel.frame = CGRectMake(-self.bounds.size.width  / 6.0f,
                                            self.bounds.size.height / 6.0f ,
                                            self.bounds.size.width,
                                            self.bounds.size.height);

            break;
        case YXCornerMarkDirectionLeftTop:
            _titleLabel.frame = CGRectMake(-self.bounds.size.width  / 6.0f,
                                           -self.bounds.size.height / 6.0f ,
                                            self.bounds.size.width,
                                            self.bounds.size.height);

            break;
        default:
            break;
    }

    _titleLabel.transform = CGAffineTransformIdentity;
    
    CGFloat angle = [CornerMarkDirectionDic[@(_cornerMarkDirection)] doubleValue];
    
    _titleLabel.transform = CGAffineTransformRotate(_titleLabel.transform, angle);
}


- (void)updateTitleLabelFont
{
    if (_cornerMarkType != YXCornerMarkTypeNormal) return;
    
    CGFloat size = self.frame.size.width  / 5.0f;
    

    [_titleLabel setFont:[UIFont systemFontOfSize:size]];
}



#pragma mark -
#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initData];
        [self initUI];
        
    }
    
    return self;
}

#pragma mark -
#pragma mark - public 

- (void)setCornerMarkBackgroundColor:(UIColor *)cornerMarkBackgroundColor
{
    _cornerMarkBackgroundColor = cornerMarkBackgroundColor;
    
    [self setNeedsDisplay];
    
}


- (void)setCornerMarkDirection:(YXCornerMarkDirection)cornerMarkDirection
{
    if (_cornerMarkDirection == cornerMarkDirection) return;
    
    _cornerMarkDirection = cornerMarkDirection;
    
    [self updateTitleLabelDirection];
    [self setNeedsDisplay];
    
}

- (void)setCornerMarkType:(YXCornerMarkType)cornerMarkType
{
    if (_cornerMarkType == cornerMarkType) return;
    
    _cornerMarkType = cornerMarkType;
    
    if (_cornerMarkType == YXCornerMarkTypeNormal)
    {
        _titleLabel.attributedText = nil;
        [self updateTitleLabelFont];
    }
    
}



- (void)setTitle:(NSString *)title
{
    if ([_title isEqualToString:title])
        return;
    
    _title = title;
    _titleLabel.text = title;
    
}

- (void)setAttriTitle:(NSAttributedString *)attriTitle
{
    _titleLabel.attributedText = attriTitle;
}

#pragma mark -
#pragma mark - view style

- (void)layoutSubviews
{
    [super layoutSubviews];


    [self updateTitleLabelDirection];
    [self updateTitleLabelFont];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIColor clearColor] set];

    UIRectFill([self bounds]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    
    switch (_cornerMarkDirection)
    {
        case YXCornerMarkDirectionRightTop:
            CGContextMoveToPoint(context,0, 0);
            CGContextAddLineToPoint(context,self.bounds.size.width, self.bounds.size.height);
            CGContextAddLineToPoint(context,self.bounds.size.width, 0);
            break;
        case YXCornerMarkDirectionRightBottom:
            CGContextMoveToPoint(context,self.bounds.size.width, 0);
            CGContextAddLineToPoint(context,self.bounds.size.width, self.bounds.size.height);
            CGContextAddLineToPoint(context,0, self.bounds.size.height);
            break;
        case YXCornerMarkDirectionLeftBottom:
            CGContextMoveToPoint(context,0, 0);
            CGContextAddLineToPoint(context,0, self.bounds.size.height);
            CGContextAddLineToPoint(context,self.bounds.size.width,self.bounds.size.height);
            break;
        case YXCornerMarkDirectionLeftTop:
            CGContextMoveToPoint(context,0, 0);
            CGContextAddLineToPoint(context,0, self.bounds.size.height);
            CGContextAddLineToPoint(context,self.bounds.size.width, 0);
            break;
        default:
            break;
    }

    CGContextClosePath(context);
    [self.cornerMarkBackgroundColor setFill];
    [[UIColor clearColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);

}


@end
