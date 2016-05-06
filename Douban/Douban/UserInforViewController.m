//
//  UserInforViewController.m
//  Douban
//
//  Created by lkjy on 16/5/4.
//  Copyright © 2016年 heyuanwu. All rights reserved.
//

#import "UserInforViewController.h"
#import "CDSideBarController.h"
@interface UserInforViewController ()
{
    NetworkManager* networkmanager;
    UIStoryboard* mainStoryboard;
    AppDelegate* appDelegate;

}
@end

@implementation UserInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    appDelegate=[[UIApplication sharedApplication] delegate];
    //给登陆图片添加手势
    UITapGestureRecognizer* singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginImageTapped)];
    [singleTap setNumberOfTapsRequired:1];
    
    self.loginImage.userInteractionEnabled=YES;
    [self.loginImage addGestureRecognizer:singleTap];
    
    networkmanager=[[NetworkManager alloc] init];
    networkmanager.delegate=(id)self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setUserInfo];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    _loginImage.layer.cornerRadius=_loginImage.frame.size.width/2.0;
    if (!_loginImage.clipsToBounds)
    {
        _loginImage.clipsToBounds=YES;
    }
}


-(void)loginImageTapped
{
    LoginViewContorllerViewController* loginVC=[mainStoryboard instantiateViewControllerWithIdentifier:@"loginVC"];

    loginVC.delgate=(id)self;
   // [[CDSideBarController sharedInstance]dismissMenu];
    [self presentViewController:loginVC animated:YES completion:nil];
}
//注
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            break;
        case 1:
            [networkmanager logout];
            break;
        default:
            break;
    }
    

}




//设置用户信息是从userInfo里获取
-(void)setUserInfo
{
    //如果已经登录过了，直接显示信息
    if (appDelegate.userInfo.cookies)
    {
        [_loginImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img3.douban.com/icon/ul%@-1.jpg",appDelegate.userInfo.userID]]];
        
        _loginImage.userInteractionEnabled=NO;//不允许交互
        _usernameLabel.text=appDelegate.userInfo.name;
        
        _playedLabel.text=appDelegate.userInfo.played;
        
        _likedLabel.text=appDelegate.userInfo.liked;
        
        _bannedLabel.text=appDelegate.userInfo.banned;
        
        _logoutButton.hidden=NO;
    
    }
    //如果没有登录，显示的信息
    else
    {
        [_loginImage setImage:[UIImage imageNamed:@"login"]];
    
        _loginImage.userInteractionEnabled=YES;
        _usernameLabel.text=@"";
        _playedLabel.text=@"0";
        _likedLabel.text=@"0";
        _bannedLabel.text=@"0";
        _logoutButton.hidden=YES;
    
    }
    
    
}
-(void)logoutSuccess
{
    [self setUserInfo];
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

//点击登出按钮响应的事件
- (IBAction)logoutButtonTapped:(UIButton *)sender
{
    UIAlertView* alertView=[[UIAlertView alloc] initWithTitle:@"登出" message:@"您确定要登出吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}
@end
