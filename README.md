# QQ 、微信分享
### QQ 分享链接的时候，并不会显示缩略图、Title、Description, 只会显示链接
### 参考链接

<a href="https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN" target="_blank">WX 文档</a></br>
<a href="http://wiki.connect.qq.com/ios_sdk%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA" target="_blank">QQ 文档</a>

### 其他
`info.plist` 中需要添加以下
	
	<key> LSApplicationQueriesSchemes </key>
	<array>
		<string> weixin </string>
		<string> mqq </string>
		<string> wtloginmqq2 </string>
		<string> mqqopensdkapiV3 </string>
		<string> mqqopensdkapiV2 </string>
		<string> mqqOpensdkSSoLogin </string>
		<string> mqqapi </string>
		<string> wechat </string>
	</array>

URL Types 中需要添加 `wx`、`QQ`, `QQ` 的 `URL Schemes` 需要添加 `tencent`
### How to use?

```Objective-C
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
```