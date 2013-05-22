//
//  RecordView.m
//  MyJourney
//
//  Created by Aaron on 13-5-15.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import "RecordView.h"


@implementation RecordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init{
    self = [self initWithFrame:CGRectMake(50, 200, 220, 100)];
    if (self) {
        isRecording = NO;
        hasRecorded = NO;
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        audioPath = [path stringByAppendingPathComponent:@"audio"];
        if (![fm fileExistsAtPath:audioPath]) {
            [fm createDirectoryAtPath:audioPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        imageView.backgroundColor = [UIColor greenColor];
        [self addSubview:imageView];
        [imageView release];
        
        
        
        UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        exitButton.frame = CGRectMake(190, 0, 30, 30);
        exitButton.backgroundColor = [UIColor yellowColor];
        [self addSubview:exitButton];
        [exitButton addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
        
        //录音功能按钮
        recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        recordButton.frame = CGRectMake(10, 10, 50, 30);
        [recordButton setTitle:@"Rec" forState:UIControlStateNormal];
        [self addSubview:recordButton];
        [recordButton addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
        
        playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        playButton.frame = CGRectMake(10, 10, 50, 30);
        [playButton setTitle:@"Play" forState:UIControlStateNormal];
        [self addSubview:playButton];
        [playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        
        saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        saveButton.frame = CGRectMake(10, 10, 50, 30);
        [saveButton setTitle:@"Rec" forState:UIControlStateNormal];
        [self addSubview:saveButton];
        [saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(10, 10, 50, 30);
        [cancelButton setTitle:@"Rec" forState:UIControlStateNormal];
        [self addSubview:cancelButton];
        [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)record:(UIButton *)sender
{
    if (isRecording == NO && hasRecorded == NO) {
        
        
        
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        playButton.frame = CGRectMake(60, 10, 50, 30);
        saveButton.frame = CGRectMake(120, 10, 50, 30);
        cancelButton.frame = CGRectMake(180, 10, 50, 30);
        [UIView commitAnimations];
        
        audioSession= [AVAudioSession sharedInstance];
        NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
                                [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                                [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                                [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                                [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                                nil];

        
        NSURL *pathURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/demo.wav", audioPath]];
        audioRecorder = [[AVAudioRecorder alloc] initWithURL:pathURL settings:settings error:nil];
        audioRecorder.delegate = self;
        
        [audioSession setActive:YES error:nil];
        [audioRecorder prepareToRecord];
        audioRecorder.meteringEnabled = YES;
        [audioRecorder peakPowerForChannel:0];
        //levelTimer=[NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(levelTimerCallback:) userInfo:nil repeats:YES];
        [audioRecorder record];
        isRecording = YES;
        hasRecorded = YES;
    }
    else if (isRecording == YES && hasRecorded == YES) {
        [audioRecorder pause];
        isRecording = NO;
        hasRecorded = YES;
        [sender setTitle:@"Continue" forState:UIControlStateNormal];
    }
    
}

-(void)play:(UIButton *)sender
{
    
}

-(void)save
{
    
}

-(void)cancel:(UIButton *)sender
{
    
}


-(void)exit:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    self.hidden = YES;
    [UIView commitAnimations];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
