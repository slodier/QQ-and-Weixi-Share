//
//  ShareView.m
//  TencentShare
//
//  Created by CC on 2017/3/22.
//  Copyright © 2017年 CC. All rights reserved.
//

#import "ShareView.h"
#import "ShareModel.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ShareView ()

@property (nonatomic, strong) UIImageView *bgView; // 背景图片

@property (nonatomic, strong) ShareModel *shareModel;

@end

@implementation ShareView

#pragma mark - 按钮点击事件
#pragma mark WX 群组分享图片
- (void)wxShareGroupPic {
    
    [_shareModel textWXShare:1];
}

#pragma mark WX 好友分享图片
- (void)wxShareFriendPic {
    
    [_shareModel pictureWXShare:0];
}

#pragma mark QQ 分享图片
- (void)qqSharePic {
    
    [_shareModel qqShare:YES];
}

#pragma mark QQ 分享链接
- (void)qqShareUrl {
    
    [_shareModel qqShare:NO];
}

#pragma mark - 构建 UI
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _shareModel = [[ShareModel alloc]init];
        
        _bgView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_bgView];
        _bgView.userInteractionEnabled = YES;
        _bgView.image = [UIImage imageNamed:@"bg.jpg"];
        
        //微信好友
        _wxFriBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bgView addSubview:_wxFriBtn];
        _wxFriBtn.frame = CGRectMake(0.2 *KScreenWidth, 0.2 *KScreenHeight, 0.327 *KScreenWidth, 0.06 *KScreenHeight);
        [_wxFriBtn setBackgroundImage:[UIImage imageNamed:@"wxFriend"] forState:UIControlStateNormal];
        
        //微信朋友圈
        _wxGroBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bgView addSubview:_wxGroBtn];
        _wxGroBtn.frame = CGRectMake(0.2 *KScreenWidth, 0.4 *KScreenHeight,  0.327 *KScreenWidth, 0.06 *KScreenHeight);
        [_wxGroBtn setBackgroundImage:[UIImage imageNamed:@"wxZone"] forState:UIControlStateNormal];
        
        //qq好友
        _qqFriBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bgView addSubview:_qqFriBtn];
        _qqFriBtn.frame = CGRectMake(0.2 *KScreenWidth, 0.6 *KScreenHeight,  0.327 *KScreenWidth, 0.06 *KScreenHeight);
        [_qqFriBtn setBackgroundImage:[UIImage imageNamed:@"qqFriend"] forState:UIControlStateNormal];
        
        //qq好友
        _qqGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bgView addSubview:_qqGroupBtn];
        _qqGroupBtn.frame = CGRectMake(0.2 *KScreenWidth, 0.8 *KScreenHeight,  0.327 *KScreenWidth, 0.06 *KScreenHeight);
        [_qqGroupBtn setBackgroundImage:[UIImage imageNamed:@"qqZone"] forState:UIControlStateNormal];
        
        //点击事件
        [_wxGroBtn   addTarget:self action:@selector(wxShareGroupPic) forControlEvents:UIControlEventTouchUpInside];
        [_wxFriBtn   addTarget:self action:@selector(wxShareFriendPic) forControlEvents:UIControlEventTouchUpInside];
        [_qqFriBtn   addTarget:self action:@selector(qqSharePic) forControlEvents:UIControlEventTouchUpInside];
        [_qqGroupBtn addTarget:self action:@selector(qqShareUrl) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
