//
//  RecordView.h
//  MyJourney
//
//  Created by Aaron on 13-5-15.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface RecordView : UIView<AVAudioRecorderDelegate, AVAudioPlayerDelegate, AVAudioSessionDelegate>
{
    AVAudioSession *audioSession;
    AVAudioRecorder *audioRecorder;
    
    BOOL isRecording;//是否正在录音
    BOOL hasRecorded;//是否曾经录音
    
    UIButton *recordButton;
    UIButton *playButton;
    UIButton *saveButton;
    UIButton *cancelButton;
    
    NSString *audioPath;//存放录音路径
    
}
@end
