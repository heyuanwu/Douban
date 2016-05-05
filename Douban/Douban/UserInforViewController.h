//
//  UserInforViewController.h
//  Douban
//
//  Created by lkjy on 16/5/4.
//  Copyright © 2016年 heyuanwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIKit+AFNetworking.h>
#import "LoginViewContorllerViewController.h"
#import "NetworkManager.h"
#import "AppDelegate.h"
#import "ProtocolClass.h"
@interface UserInforViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *loginImage;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *playedLabel;
@property (strong, nonatomic) IBOutlet UILabel *likedLabel;
@property (strong, nonatomic) IBOutlet UILabel *bannedLabel;

@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
- (IBAction)logoutButtonTapped:(UIButton *)sender;


-(void)setUserInfo;
-(void)logoutSuccess;
@end
