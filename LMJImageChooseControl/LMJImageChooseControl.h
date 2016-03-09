//
//  LMJImageChooseControl.h
//  LMJImageChoose
//
//  Created by Major on 16/3/9.
//  Copyright © 2016年 iOS开发者公会. All rights reserved.
//
//  iOS开发者公会-技术1群 QQ群号：87440292
//  iOS开发者公会-技术2群 QQ群号：232702419
//  iOS开发者公会-议事区  QQ群号：413102158
//


#import <UIKit/UIKit.h>

@class LMJImageChooseControl;

#define SettingCenterUrl @"prefs:root=com.ArtPollo.Artpollo"

@protocol LMJImageChooseControlDelegate <NSObject>

@optional
- (void)imageChooseControl:(LMJImageChooseControl *)control didChooseFinished:(UIImage *)image;

- (void)imageChooseControl:(LMJImageChooseControl *)control didClearImage:(UIImage *)image;

@end

@interface LMJImageChooseControl : UIView <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,copy) NSString * pickerTitle;

@property (nonatomic,assign) UIViewController * superViewController;

@property (nonatomic,assign) id<LMJImageChooseControlDelegate> delegate;

@property (nonatomic,strong,readonly) UIImage * image;

@end
