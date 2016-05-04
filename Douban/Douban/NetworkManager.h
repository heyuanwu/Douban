//
//  NetworkManager.h
//  Douban
//
//  Created by lkjy on 16/5/4.
//  Copyright © 2016年 heyuanwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolClass.h"
@interface NetworkManager : NSObject

@property(weak,nonatomic)id<DoubanDelegate>delegate;
@property(nonatomic)NSMutableArray* captchaID;//身份验证码
+(instancetype)sharedInstanced;
-(instancetype)init;

-(void)setChannel:(NSInteger)channelIndex withURLWithString:(NSString*)urlWithString;

-(void)LoginwithUsername:(NSString*)username            Password:(NSString*)password
                 Captcha:(NSString*)captcha
         RememberOnorOff:(NSString*)rememberOnorOff;

-(void)logout;//退出
-(void)loadCaptchaImage;//加载验证码图片
-(void)loadPlaylistwithType:(NSString*)type;//加载什么类型的播放列表


@end
