//
//  LoginViewContorllerViewController.m
//  Douban
//
//  Created by lkjy on 16/5/4.
//  Copyright © 2016年 heyuanwu. All rights reserved.
//

#import "LoginViewContorllerViewController.h"
#import "NetworkManager.h"
#import <UIImageView+AFNetworking.h>
@interface LoginViewContorllerViewController ()
{
    NSMutableString*captchID;//验证码
    NetworkManager*workManager;
    AppDelegate*appDelegate;
    
    
    
}

@end

@implementation LoginViewContorllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    appDelegate=[UIApplication sharedApplication].delegate;
    workManager=[[NetworkManager alloc]init];
    workManager.delegate=(id)self;
    
    
    //初始化图片点击事件
    UITapGestureRecognizer*singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadCaptchaImage)];//单击
    
    [singleTap setNumberOfTapsRequired:1];
    
    self.captchaImageView.userInteractionEnabled=YES;
    
    [self.captchaImageView addGestureRecognizer:singleTap];//将单击事件添加到验证码图片上

    
    
}

//验证码图片点击刷新验证码时间
-(void)loadCaptchaImage
{
    [workManager loadCaptchaImage];
    
    
}

-(void)loginSuccess//登录成功
{
    [_delgate setUserInfo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [self loadCaptchaImage];//加载验证码图片
    
    [super viewWillAppear:animated];//消失时，动画
    
}

-(void)setCaptchaImageWithURLInString:(NSString*)url//设置验证码图片
{
    
    [self.captchaImageView setImageWithURL:[NSURL URLWithString:url]];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submitButtonTapped:(UIButton *)sender
{ NSString*username=_username.text;
    NSString*password=_password.text;
    NSString*captcha=_captcha.text;
    
    [workManager LoginwithUsername:username Password:password Captcha:captcha RememberOnorOff:@"off"];
    
    

    
    
}

- (IBAction)cancelButtonTapped:(UIButton *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
 
}

- (IBAction)backgroundTaped:(id)sender
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    [_captcha resignFirstResponder];
    
    

    
    
}
@end
