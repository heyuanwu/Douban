//
//  UserInfo.h
//  
//
//  Created by lkjy on 16/5/4.
//
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>//NSCoding编码

@property(nonatomic,copy)NSString* isNotLogin;

@property(nonatomic,copy)NSString* cookies;

@property(nonatomic,copy)NSString* userID;//用户身份
@property(nonatomic,copy)NSString* name;//

//歌曲里面的禁止、喜欢、播放歌曲列表的属性
@property(nonatomic,copy)NSString* banned;//禁止

@property(nonatomic,copy)NSString* liked;

@property(nonatomic,copy)NSString* played;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;
-(void)archiverUserInfo;//存储用户信息


@end
