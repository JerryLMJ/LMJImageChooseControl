//
//  LMJImageChooseControl.m
//  LMJImageChoose
//
//  Created by Major on 16/3/9.
//  Copyright © 2016年 iOS开发者公会. All rights reserved.
//
//  iOS开发者公会-技术1群 QQ群号：87440292
//  iOS开发者公会-技术2群 QQ群号：232702419
//  iOS开发者公会-议事区  QQ群号：413102158
//


#import "LMJImageChooseControl.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@implementation LMJImageChooseControl
{
    UILabel  * _markLabel;
    UIButton * _imgBtn;
    UIButton * _clearBtn;
}

- (id)init{
    self = [super init];
    if (self) {
        [self initData];
        [self buildViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self buildViews];
        [self setFrames];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    [self setFrames];
}

- (void)initData{
    _pickerTitle = @"选择";
    _image       = nil;
}


- (void)buildViews{
    
    self.backgroundColor = [UIColor lightGrayColor];

    // 标签
    _markLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _markLabel.text            = @"点击添加图片";
    _markLabel.textColor       = [UIColor blackColor];
    _markLabel.textAlignment   = NSTextAlignmentCenter;
    _markLabel.font            = [UIFont systemFontOfSize:15.f];
    _markLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_markLabel];
    
    
    // 图片按钮
    _imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imgBtn setImage:nil forState:UIControlStateNormal];
    [_imgBtn addTarget:self action:@selector(clickImgBtnAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_imgBtn];
    
    
    // 清除按钮
    _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearBtn setImage:[UIImage imageNamed:@"ImageChooseCloseBtn.png"] forState:UIControlStateNormal];
    [_clearBtn setHidden:YES];
    [_clearBtn addTarget:self action:@selector(clickClearBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clearBtn];
    
}

- (void)setFrames{
    _markLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [_imgBtn setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_clearBtn setFrame:CGRectMake(self.frame.size.width -40, 0, 40, 40)];
}

#pragma mark - ClickBtn Methods

- (void)clickImgBtnAddImage:(UIButton *)button{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:_pickerTitle
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"从相册选取", @"拍照", nil];
    [sheet showInView:self];
}

- (void)clickClearBtn{
    [_imgBtn setImage:nil forState:UIControlStateNormal];
    [_clearBtn setHidden:YES];
    _image = nil;
    
    
    if ([self.delegate respondsToSelector:@selector(imageChooseControl:didClearImage:)]) {
        [self.delegate imageChooseControl:self didClearImage:nil];
    }
}


#pragma mark - ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 2) {
        return;
    }
    
    if (buttonIndex == 0) {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            //无权限
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"未获得授权访问相册" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            [alertView show];
            return;
        }
    }else if (buttonIndex == 1) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            //无权限
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"未获得授权使用摄像头" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            [alertView show];
            return;
        }
    }
    
    
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate      = self;
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self.superViewController presentViewController:imagePicker animated:YES completion:nil];
    
}
#pragma mark - ImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image =  [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    [_imgBtn setImage:image forState:UIControlStateNormal];
    [_clearBtn setHidden:NO];
    _image = image;
    
    if ([self.delegate respondsToSelector:@selector(imageChooseControl:didChooseFinished:)]) {
        [self.delegate imageChooseControl:self didChooseFinished:image];
    }

    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SettingCenterUrl]];
    }
}


@end
