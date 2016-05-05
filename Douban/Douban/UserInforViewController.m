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
    //[self.loginImage ];
    
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

- (IBAction)logoutButtonTapped:(UIButton *)sender {
}
@end
