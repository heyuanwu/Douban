//
//  LoginViewContorllerViewController.h
//  Douban
//
//  Created by lkjy on 16/5/4.
//  Copyright © 2016年 heyuanwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "AppDelegate.h"
#import "ProtocolClass.h"
@interface LoginViewContorllerViewController : UIViewController<DoubanDelegate>

@property(weak,nonatomic)id<DoubanDelegate>delgate;

@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) IBOutlet UITextField *captcha;

@property (strong, nonatomic) IBOutlet UIImageView *captchaImageView;

- (IBAction)submitButtonTapped:(UIButton *)sender;

- (IBAction)cancelButtonTapped:(UIButton *)sender;

- (IBAction)backgroundTaped:(id)sender;


@end
