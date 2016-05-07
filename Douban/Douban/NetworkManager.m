//
//  NetworkManager.m
//  Douban
//
//  Created by lkjy on 16/5/4.
//  Copyright © 2016年 heyuanwu. All rights reserved.
//

#import "NetworkManager.h"
#import "AppDelegate.h"
#import "SongInfo.h"
#import "ChannelInfor.h"

#import "PlayerController.h"
#import "DFMUpChanneIsEntity.h"
#import "DFMRecChanneIsEntity.h"
#import "DFMHotChanneIsEntity.h"

#import <UIKit/UIKit.h>
#import <MJExtension.h>
#import <AFNetworking/AFNetworking.h>

#define PLAYLISTURLFORMATSTRING @"http://douban.fm/j/mine/playlist?type=%@&sid=%@&pt=%f&channel=%@&from=mainsite"
#define LOGINURLSTRING @"http://douban.fm/j/login"
#define LOGOUTURLSTRING @"http://douban.fm/partner/logout"
#define CAPTCHAIDURLSTRING @"http://douban.fm/j/new_captcha"
#define CAPTCHAIMGURLFORNATSTRING @"http://douban.fm/misc/captcha?size=m&id=%@"

static NSMutableString *captchaID;
@interface  NetworkManager()
{
    AppDelegate*appDelegate;
    AFHTTPRequestOperationManager*operationManager;
    
    
    
}

@end

@implementation NetworkManager
-(instancetype)init
{
    if (self=[super init]) {
        appDelegate=[[UIApplication sharedApplication]delegate];
        operationManager=[AFHTTPRequestOperationManager manager];
        
        
    }
    return self;
    
}
+(instancetype)sharedInstanced{
    
    static NetworkManager*shareManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager=[[self alloc]init];
        
    });
    return shareManager;
    
}


@end
