//
//  ShareView.m
//  Share
//
//  Created by CC on 2016/11/19.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "ShareView.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define WXappid @"wx123"

#define QQappid @"123"

@interface ShareView ()<TencentSessionDelegate>
{
    
}
@property (nonatomic, strong) UIImageView *bgView; //背景图片
@property (nonatomic, strong) TencentOAuth *tencent;;

@end

@implementation ShareView

static NSString *KLinkURL = @"http://v.youku.com/v_show/id_XNTY1ODY1OTA0.html";
static NSString *KLinkTitle = @"老司机带你飞";
static NSString *KLinkDescription = @"快上车,来不及解释了!";

#pragma mark -- 按钮点击事件
- (void)wxShareGPic {
    [self wxShare:1];
}

- (void)wxShareFPic {

    [self wxShare:0];
}

- (void)qqSharePic {

    [self qqShare:NO];
}

- (void)qqShareUrl {

    [self qqShare:YES];
}

#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"Not installe weixi");
        [self alert:@"Not installe weixi"];
    }else{
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
        sendReq.bText = NO; //不使用文本信息
        sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
        
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title = KLinkTitle;
        urlMessage.description = KLinkDescription;
        
        UIImage *image = [UIImage imageNamed:@"maliao"];
        //缩略图,压缩图片,不超过 32 KB
        NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
        [urlMessage setThumbData:thumbData];
        //分享实例
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = KLinkURL;
        
        urlMessage.mediaObject = webObj;
        sendReq.message = urlMessage;
        //发送分享
        [WXApi sendReq:sendReq];
    }
}

#pragma mark QQ 分享的是图片
- (void)qqShare:(BOOL)flag
{   //检测是否安装 QQ
    if (![TencentOAuth iphoneQQInstalled]) {
        NSLog(@"请移步 Appstore 去下载腾讯 QQ 客户端");
        [self alert:@"请移步 Appstore 去下载腾讯 QQ 客户端"];
    }else{
        
        _tencent = [[TencentOAuth alloc]initWithAppId:QQappid andDelegate:self];
        UIImage *image = [UIImage imageNamed:@"maliao"];
        //QQ 分享图片不超过 1M ，没有压缩的必要
        NSData *data = UIImagePNGRepresentation(image);
        QQApiImageObject *imgObj = [QQApiImageObject objectWithData:data
                                                   previewImageData:data
                                                              title:KLinkTitle
                                                        description:KLinkDescription];
        
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
        //因为分享的是联系人和空间的结合体，下面的判断其实多此一举
        if (!flag){
            //分享好友
            QQApiSendResultCode code = [QQApiInterface sendReq:req];
            NSLog(@"%d",code);
        }else{
            //分享空间
            [QQApiInterface SendReqToQZone:req];
        }
    }
}

#pragma mark 微信、QQ 没有安装，提示框
- (void)alert:(NSString *)str {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:str
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark -- 构建 UI
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _bgView = [[UIImageView alloc]initWithFrame:self.bounds];
        //_bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        _bgView.userInteractionEnabled = YES;
        _bgView.image = [UIImage imageNamed:@"shareBg.jpg"];
        
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
        [_wxGroBtn   addTarget:self action:@selector(wxShareGPic) forControlEvents:UIControlEventTouchUpInside];
        [_wxFriBtn   addTarget:self action:@selector(wxShareFPic) forControlEvents:UIControlEventTouchUpInside];
        [_qqFriBtn   addTarget:self action:@selector(qqSharePic) forControlEvents:UIControlEventTouchUpInside];
        [_qqGroupBtn addTarget:self action:@selector(qqShareUrl) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark -- QQ 代理
- (void)tencentDidLogin {
    
}

- (void)tencentDidNotNetWork {
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    
}

@end
