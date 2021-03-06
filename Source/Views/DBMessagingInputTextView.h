//
//  DBMessagingInputTextView.h
//  
//
//  GitHub
//  https://github.com/DevonBoyer/DBMessagingKit
//
//
//  Created by Devon Boyer on 2014-09-18.
//  Copyright (c) 2014 Devon Boyer. All rights reserved.
//
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

@protocol DBMessagingInputTextViewDelegate <UITextViewDelegate>

@optional
- (void)textViewDidChangeFrame:(UITextView *)textView delta:(CGFloat)delta;

@end

@interface DBMessagingInputTextView : UITextView <UIAppearance>

@property (weak, nonatomic) id <DBMessagingInputTextViewDelegate> delegate;

@property (assign, nonatomic) CGFloat maximumHeight;
@property (assign, nonatomic) NSInteger borderWidth UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) NSInteger cornerRadius UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) NSString *placeholderText UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, readonly) NSMutableArray *attatchmentRanges;
@property (strong, nonatomic, readonly) NSArray *messageParts;

// Attatchments
- (void)addImageAttatchment:(UIImage *)image;
- (void)addLocationAttatchment:(CLLocation *)location;
- (void)removeAttatchmentAtRange:(NSRange)range;

- (NSString *)currentlyComposedTextMessagePart;
- (void)clear;

@end
