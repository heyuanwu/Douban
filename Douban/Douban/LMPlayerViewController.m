//
//  LMPlayerViewController.m
//  Douban
//
//  Created by liman on 16/5/7.
//  Copyright © 2016年 heyuanwu. All rights reserved.
//

#import "LMPlayerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface LMPlayerViewController ()
{
    NSTimer *timer;/**<当前歌曲时间*/
    CGFloat screenWidth;
    CGFloat screenHeight;
    UILabel* currentTimer;
    NSArray* songs;
    int index;
    int j;
    BOOL isPlaying;
    BOOL isAnimation;
    CABasicAnimation* animation;
    UILabel* panduan;
    
}
@property(nonatomic,strong)UILabel* channelTitleLabel;/**<频道标题*/
@property(nonatomic,strong)UIImageView* albumCoverImage;/**<覆盖的唱片背景*/
@property(nonatomic,strong)UIImageView*albumCoverMaskImage;
@property(nonatomic,strong)UIProgressView* timerBar;/**<歌曲进度条*/
@property(nonatomic,strong)UILabel* timerLabel;/**<歌曲  总时间*/
@property(nonatomic,strong)UILabel* songTitleLabel;/**<歌曲名*/
@property(nonatomic,strong)UILabel* songArtistLabel;/**<歌手*/
@property(nonatomic,strong)UIToolbar* toolbar;

@property(nonatomic,strong)AVAudioPlayer* audio;/**<播放*/
@property (strong, nonatomic) UIButton *pauseButton;/**<暂停*/
@property (strong, nonatomic) UIButton *likeButton;/**<收藏*/
@property (strong, nonatomic) UIButton *deleteButton;/**<删除*/
@property (strong, nonatomic) UIButton *skipButton;/**<下一首*/
@end

@implementation LMPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    screenWidth=self.view.frame.size.width;
    screenHeight=self.view.frame.size.height;
    
    [self initSubviews];
    
    NSString* path=[[NSBundle mainBundle]pathForResource:@"Song" ofType:@"plist"];
    
    songs=[[NSArray alloc]initWithContentsOfFile:path];
    index=0;
    [self avPlay:index];
}

-(void)initSubviews
{
    
    
    
    _channelTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth-220, 30, 200, 50)];
    
    _channelTitleLabel.text=@"我的私人";
    
    [self.view addSubview:_channelTitleLabel];
    
    //唱片区
    _albumCoverImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 50, screenWidth-20, screenHeight/2)];
    _albumCoverImage.image=[UIImage imageNamed:@"albumBlock"];
    
    _albumCoverImage.alpha=1.0;
    _albumCoverImage.layer.cornerRadius = self.albumCoverImage.bounds.size.width/2.0;
    _albumCoverImage.layer.masksToBounds = YES;
    
    UIView* albumbgView=[[UIView alloc]initWithFrame:_albumCoverImage.frame];
    
    [albumbgView addSubview:_albumCoverImage];
    
    
    
    //遮罩层
    _albumCoverMaskImage=[[UIImageView alloc]initWithFrame:_albumCoverImage.frame];
    
    _albumCoverMaskImage.image=[UIImage imageNamed:@"albumBlock2"];
    _albumCoverMaskImage.alpha=0.0;
    [albumbgView addSubview:_albumCoverMaskImage];
    
    [self.view insertSubview:albumbgView belowSubview:_channelTitleLabel];
    
    //进度条
    _timerBar=[[UIProgressView alloc]init];
    _timerBar.frame=CGRectMake(5, albumbgView.frame.origin.y+albumbgView.frame.size.height+80, albumbgView.frame.size.width, 10);
    
    _timerBar.trackTintColor=[UIColor colorWithRed:0.110 green:0.180 blue:0.975 alpha:1.000];
    
    _timerBar.tintColor=[UIColor orangeColor];
    [self.view insertSubview:_timerBar belowSubview:albumbgView];
    
    //总时长
    _timerLabel=[[UILabel alloc]initWithFrame:CGRectMake(_timerBar.frame.size.width/2, _timerBar.frame.origin.y+_timerBar.frame.size.height+10, 100, 50)];
    
    _timerLabel.text=[NSString stringWithFormat:@"/%@",
                      [self coveTimeToString:_audio.duration]];
    //NSLog(@"%@",_timerLabel.text);
    
    [self.view insertSubview:_timerLabel belowSubview:_timerBar];
    currentTimer=[[UILabel alloc]initWithFrame:CGRectMake(_timerLabel.frame.origin.x-35, _timerLabel.frame.origin.y, _timerLabel.frame.size.width, _timerLabel.frame.size.height)];
    currentTimer.text=[self coveTimeToString:_audio.currentTime];
    [self.view addSubview:currentTimer];
    
    _songTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(_timerBar.frame.size.width/2-20, _timerLabel.frame.origin.y+_timerLabel.frame.size.height, 200, 50)];
    
    //_songTitleLabel.text=[songs[index] objectForKey:@"Song"];
    _songTitleLabel.text=@"歌曲";
    _songTitleLabel.textAlignment=0;
    [self.view insertSubview:_songTitleLabel belowSubview:_timerLabel];
    
    _songArtistLabel=[[UILabel alloc]initWithFrame:CGRectMake(_songTitleLabel.frame.origin.x-20, _songTitleLabel.frame.origin.y+_songTitleLabel.frame.size.height, _songTitleLabel.frame.size.width, _songTitleLabel.frame.size.height)];
    
    //_songArtistLabel.text=[songs[index] objectForKey:@"Artist"];
    _songArtistLabel.text=@"歌手";
    _songArtistLabel.textAlignment=0;
    [self.view insertSubview:_songArtistLabel belowSubview:_songTitleLabel];
    //暂停按钮
    _pauseButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 615, self.view.frame.size.width/4-25, 50)];
    [_pauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    // [_pauseButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
    [_pauseButton addTarget:self action:@selector(pasuseSong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pauseButton];
    //收藏按钮
    _likeButton=[[UIButton alloc]initWithFrame:CGRectMake(_pauseButton.frame.origin.x+ _pauseButton.frame.size.width+25, 615, self.view.frame.size.width/4-25, 50)];
    [_likeButton setImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateHighlighted];
    [_likeButton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_likeButton];
    //删除按钮
    _deleteButton=[[UIButton alloc]initWithFrame:CGRectMake(_likeButton.frame.origin.x+ _likeButton.frame.size.width+25, 615, self.view.frame.size.width/4-25, 50)];
    [_deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [_deleteButton  addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteButton ];
    //下一首
    _skipButton=[[UIButton alloc]initWithFrame:CGRectMake(_deleteButton.frame.origin.x+ _deleteButton.frame.size.width+25, 615, self.view.frame.size.width/4-25, 50)];
    [_skipButton setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [_skipButton  addTarget:self action:@selector(nextPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_skipButton ];
    // _toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 630, self.view.frame.size.width, 50)];
    
    //填充按钮
    //UIBarButtonItem* flexibleSpace=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    //flexibleSpace.width=25.f;
    
    //NSMutableArray* barButtonItems=[[NSMutableArray alloc]initWithObjects:flexibleSpace, nil];
    //小图片
    // NSArray* iconName=@[@"pause",@"heart1",@"delete",@"next"];
    //对应的四个方法
    //NSArray* action=@[@"suspend",@"like",@"delete",@"nextPlay"];
    //点击后
    //NSArray* selectIcon=@[@"pause",@"heart2",@"",@""];
    
    //for (int i=0; i<iconName.count; i++)
    //    {
    //        UIBarButtonItem* button=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:iconName[i]] style:UIBarButtonItemStylePlain target:self action:NSSelectorFromString(action[i])];
    //        [barButtonItems addObject:button];
    //        if (i<3)
    //        {
    //            [barButtonItems addObject:flexibleSpace];
    //        }
    //    }
    //    [barButtonItems addObject:flexibleSpace];
    //
    //    [_toolbar setItems:barButtonItems];
    //
    //    [_toolbar setBackgroundColor:[UIColor colorWithRed:0.705 green:1.000 blue:0.970 alpha:1.000]];
    //
    //
    //    UIView* bottomBorder=[UIView new];
    //
    //    bottomBorder.backgroundColor=[UIColor colorWithRed:0.705 green:1.000 blue:0.970 alpha:1.000];
    //
    //    //是否自适应
    //    bottomBorder.translatesAutoresizingMaskIntoConstraints=NO;
    //
    //    [_toolbar addSubview:bottomBorder];
    //
    //    //约束border
    //    //NSDictionaryOfVariableBindings 绑定后方便进行约束
    //    NSDictionary* views=NSDictionaryOfVariableBindings(bottomBorder);
    //    //添加约束
    //    [_toolbar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bottomBorder]|" options:0 metrics:nil views:views]];
    //
    //    [_toolbar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomBorder(0.5)]" options:0 metrics:nil views:views]];
    //    
    //    [self.view addSubview:_toolbar];
    //    
    // NSLog(@"%d",isPlaying);
    
}
#pragma mark -- 方法
-(void)pasuseSong
{
    //添加动画
    _albumCoverImage.layer.contents=(id)[UIImage imageNamed:[[songs objectAtIndex:index] objectForKey:@"Image"]].CGImage;
    animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    CGFloat radians=2*M_PI;
    animation.toValue=[NSNumber numberWithFloat:radians];
    animation.duration=_audio.duration;
    
    _albumCoverImage.layer.autoreverses=NO;
    [_albumCoverImage.layer addAnimation:animation forKey:@"xuanzhuan"];
    
    if (isPlaying)
    {
        [_pauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [_audio stop];
        NSLog(@"已经暂停");
        isPlaying=NO;
        _timerBar.progress=_audio.currentTime/_audio.duration;
        //currentTimer.text=[self coveTimeToString:_audio.currentTime];
        //currentTimer.text=[self coveTimeToString:_audio.currentTime];
        // NSLog(@"%@",currentTimer.text);
        // NSLog(@"%@",[self coveTimeToString:_audio.currentTime]);
        
        _timerLabel.text=[NSString stringWithFormat:@"/0%d:%d",(int)_audio.duration/60,(int)_audio.duration%60];
        
        _albumCoverMaskImage.alpha=1.0;
        _albumCoverImage.alpha=0.5;
        //暂停动画
        [self pauseLayer:_albumCoverImage.layer];
        //CFTimeInterval pausedTime = [_albumCoverImage.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        //_albumCoverImage.layer.speed = 0.0;
        //_albumCoverImage.layer.timeOffset = pausedTime;
        //animation.removedOnCompletion=YES;
        //_albumCoverImage.layer.speed=0.0;
        //[_albumCoverImage.layer removeAnimationForKey:@"xuanzhuan"];
        // animation.toValue=0;
        //timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(changeValue:) userInfo:nil repeats:YES];
        //[self avPlay:index AndPlay:isPlaying];
        //[_toolbar.items[0] setImage:[UIImage imageNamed:@"play"]];
        //[_audio play];
        
        
    }else
    {
        //[self avPlay:index AndPlay:isPlaying];
        //[_toolbar.items[0] setImage:[UIImage imageNamed:@"pause"]];
        //isPlaying=NO;
        _albumCoverMaskImage.alpha=0.0;
        _albumCoverImage.alpha=1.0;
        //[_albumCoverImage setImage:[UIImage imageNamed:[[songs objectAtIndex:index] objectForKey:@"Image"]]];
        //添加动画内容
        //if (!isAnimation)
        //{
        _albumCoverImage.layer.speed=1.0;
        
        //isAnimation=YES;
        // }else
        //{
        //[self resumeLayer:_albumCoverImage.layer];
        
        //}
        
        
        
        
        //       CFTimeInterval pausedTime = [_albumCoverImage.layer timeOffset];
        //        _albumCoverImage.layer.speed = 1.0;
        //        CFTimeInterval timeSincePause = [_albumCoverImage.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        //       _albumCoverImage.layer.beginTime = timeSincePause;
        //播放
        [_audio play];
        _songTitleLabel.text=[songs[index] objectForKey:@"Song"];
        _songArtistLabel.text=[songs[index] objectForKey:@"Artist"];
        NSLog(@"正在播放");
        timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(changeValue) userInfo:nil repeats:YES];
        //_timerLabel.text=[self coveTimeToString:_audio.duration];
        //j=0;
        [_pauseButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        isPlaying=YES;
        
    }
    //isPlaying=-isPlaying;
    
    
}

-(void)like
{
    
}
-(void)delete
{
    
}
-(void)nextPlay
{
    //    index+=1;
    //    [self avPlay:index];
    //    if (index>songs.count)
    //    {
    //        index=0;
    //    }
}
-(void)avPlay:(int)inde
{
    
    NSString* path=[[NSBundle mainBundle]pathForResource:[[songs objectAtIndex:inde]objectForKey:@"Song"] ofType:@"mp3"];
    //NSLog(@"%@",path);
    //NSString* path2=[[NSBundle mainBundle]pathForResource:@"青春万岁" ofType:@"mp3"];
    //NSLog(@"*****%@",path2);
    
    _audio=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
    
    //_audio.delegate=self;
    
    [_audio prepareToPlay];
    
    
    
}
-(void)changeValue
{
    //j++;
    for (int i=0; i<_audio.duration+1; i++)
    {
        // _timerLabel.text=[self coveTimeToString:_audio.duration];
        _timerLabel.text=[NSString stringWithFormat:@"/0%d:%d",(int)_audio.duration/60,(int)_audio.duration%60];
        currentTimer.text=[self coveTimeToString:_audio.currentTime];
        //j++;
        _timerBar.progress=_audio.currentTime/_audio.duration;
        
        
    }
    panduan.text=[self coveTimeToString:_audio.duration];
    if ([currentTimer.text isEqualToString:panduan.text])
    {
        NSLog(@"播放完成");
        [timer invalidate];
        isPlaying=NO;
        [_pauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    
    
    
    
}
-(NSString*)coveTimeToString:(NSTimeInterval)time
{
    NSString* string;
    int Second=(int)time/60;
    int minute=(int)time%60;
    if (minute<10)
    {
        string=[NSString stringWithFormat:@"%0d:0%d",Second,minute];
    }else
    {
        string=[NSString stringWithFormat:@"%0d:%d",Second,minute];
    }
    return string;
    
}
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] -    pausedTime;
    layer.beginTime = timeSincePause;
}


@end
