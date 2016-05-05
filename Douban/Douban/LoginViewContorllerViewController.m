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
    NetworkManager*workManage;
    AppDelegate*appDelegate;
    
    
    
}

@end

@implementation LoginViewContorllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    appDelegate=[UIApplication sharedApplication].delegate;
    workManage=[[NetworkManager alloc]init];
    workManage.delegate=(id)self;
    
    
    //初始化图片点击事件
    UITapGestureRecognizer*singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadCaptchaImage)];//单击
    
    [singleTap setNumberOfTapsRequired:1];
    
    self.captchaImageView.userInteractionEnabled=YES;
    
    [self.captchaImageView addGestureRecognizer:singleTap];//将单击事件添加到验证码图片上

    
    
}
-(void)loadCaptchaImage
{
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self loadCaptchaImage];//加载验证码图片
    
    [super viewWillAppear:animated];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitButtonTapped:(UIButton *)sender
{
    
    
}

- (IBAction)cancelButtonTapped:(UIButton *)sender
{
    
    
}

- (IBAction)backgroundTaped:(id)sender
{
    
    
    
}
@end
