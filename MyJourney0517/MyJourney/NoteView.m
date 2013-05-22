//
//  NoteView.m
//  MyJourney
//
//  Created by Aaron on 13-5-15.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init{
    self = [self initWithFrame:CGRectMake(50, 50, 220, 100)];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        imageView.backgroundColor = [UIColor greenColor];
        [self addSubview:imageView];
        [imageView release];
        
        textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, 200, 80)];
        textView.font = [UIFont systemFontOfSize:15];
        [self addSubview:textView];
        [textView release];
        [textView becomeFirstResponder];
//        textView.inputAccessoryView =
        
        UIView *accessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        textView.inputAccessoryView = accessoryView;
        [accessoryView release];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(20, 10, 80, 30);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [accessoryView addSubview:cancelButton];
        [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *drawButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        drawButton.frame = CGRectMake(20, 10, 80, 30);
        [drawButton setTitle:@"收起" forState:UIControlStateNormal];
        [accessoryView addSubview:drawButton];
        [drawButton addTarget:self action:@selector(drawBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        exitButton.frame = CGRectMake(190, 0, 30, 30);
        exitButton.backgroundColor = [UIColor yellowColor];
        [self addSubview:exitButton];
        [exitButton addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)cancel
{
    textView.text = @"";
}

-(void)exit:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    self.hidden = YES;
    [UIView commitAnimations];
}

-(void)drawBack
{
    [textView resignFirstResponder];
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
