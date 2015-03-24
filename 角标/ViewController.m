//
//  ViewController.m
//  角标
//
//  Created by 沈 晨豪 on 15/3/23.
//  Copyright (c) 2015年 sch. All rights reserved.
//

#import "ViewController.h"
#import "UIView+YXCornerMark.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet UIView *view1;
@property (nonatomic,weak) IBOutlet UIView *view2;
@property (nonatomic,weak) IBOutlet UIView *view3;
@property (nonatomic,weak) IBOutlet UIView *view4;
@property (nonatomic,weak) IBOutlet UIView *view5;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [_view1 yxSetCornerMarkNumber:1 withColor:[UIColor greenColor] withWidth:40];
    [_view2 yxSetCornerMarkNumber:2 withColor:[UIColor blackColor] withWidth:40];
    [_view3 yxSetCornerMarkNumber:3 withColor:[UIColor grayColor] withWidth:120];
    [_view4 yxSetCornerMarkNumber:16 withColor:[UIColor blackColor] withWidth:45 characterFontSize:9 numberFontSize:15];
    [_view5 yxSetCornerMarkNumber:15 withSize:CGSizeMake(45, 45) withColor:[UIColor blueColor]
                    withDirection:YXCornerMarkDirectionLeftTop];
    
 
    
//    YXCornerMarkView *v = [[YXCornerMarkView alloc] init];
//    v.frame = CGRectMake(100, 100, 100, 100);
//    [v setTitle:@"NO.1"];
//    
//    YXCornerMarkView *v1 = [[YXCornerMarkView alloc] init];
//    v1.frame = CGRectMake(100, 220, 50, 50);
//    v1.cornerMarkBackgroundColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f];
//    [v1 setCornerMarkDirection:YXCornerMarkDirectionRightBottom];
//    [v1 setTitle:@"NO.2"];
//    [self.view addSubview:v];
//    [self.view addSubview:v1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
       _view5.frame = CGRectMake(_view5.frame.origin.x,
                                 _view5.frame.origin.y - 10,
                                 100,
                                 100);
}

@end
