//
//  ProtocolClass.h
//  Douban
//
//  Created by lkjy on 16/5/4.
//  Copyright © 2016年 heyuanwu. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DoubanDelegate<NSObject>
@optional
/**
 *  登录界面delegate
 */
-(void)setCaptchaImageWithURLInString:(NSString *)url;
-(void)loginSuccess;
-(void)setUserInfo;


@end

@interface ProtocolClass : NSObject

@end
