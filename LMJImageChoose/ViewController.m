//
//  ViewController.m
//  LMJImageChoose
//
//  Created by Major on 16/3/9.
//  Copyright © 2016年 iOS开发者公会. All rights reserved.
//
//  iOS开发者公会-技术1群 QQ群号：87440292
//  iOS开发者公会-技术2群 QQ群号：232702419
//  iOS开发者公会-议事区  QQ群号：413102158
//

#import "ViewController.h"

#import "LMJImageChooseControl.h"

@interface ViewController ()<LMJImageChooseControlDelegate>
{

    UIImageView * _resualtImgView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    LMJImageChooseControl * imgChooseControl = [[LMJImageChooseControl alloc] initWithFrame:CGRectMake(20, 60, 300, 200)];
    imgChooseControl.pickerTitle         = @"选择照片";
    imgChooseControl.superViewController = self;
    imgChooseControl.delegate            = self;
    [self.view addSubview:imgChooseControl];
    
    
    
    
    
    
    
    
    UILabel * markLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 320, 200, 20)];
    markLabel.text = @"resualt image :";
    [self.view addSubview:markLabel];
    
    _resualtImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 350, 300, 200)];
    _resualtImgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_resualtImgView];
    
}

- (void)imageChooseControl:(LMJImageChooseControl *)control didChooseFinished:(UIImage *)image{
    
    NSLog(@"Choose Finished!");
    
    [_resualtImgView setImage:image];
}

- (void)imageChooseControl:(LMJImageChooseControl *)control didClearImage:(UIImage *)image{
    
    NSLog(@"Clear!");
    
    [_resualtImgView setImage:image];
}

@end
