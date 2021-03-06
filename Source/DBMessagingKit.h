//
//  DBMessagingKit.h
//
//
//  GitHub
//  https://github.com/DevonBoyer/DBMessagingKit
//
//
//  Created by Devon Boyer on 2014-10-12.
//  Copyright (c) 2014 Devon Boyer. All rights reserved.
//
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

//! Project version number for DBMessagingKit.
FOUNDATION_EXPORT double DBMessagingKitVersionNumber;

//! Project version string for DBMessagingKit.
FOUNDATION_EXPORT const unsigned char DBMessagingKitVersionString[];

#ifndef DBMessagingKit_DBMessagingKit_h
#define DBMessagingKit_DBMessagingKit_h

#import "DBMessagingKitConstants.h"

// Protocols
#import "DBMessagingCollectionViewDataSource.h"
#import "DBMessagingCollectionViewDelegate.h"
#import "DBMessagingCollectionViewDelegateFlowLayout.h"

// Factories
#import "DBMessageBubbleFactory.h"
#import "DBMessagingTimestampFormatter.h"

// Controllers
#import "DBMessagingViewController.h"
#import "DBMessageBubbleController.h"
#import "DBInteractiveKeyboardController.h"
#import "DBSystemSoundPlayer.h"

// Layout
#import "DBMessagingCollectionViewBaseFlowLayout.h"
#import "DBMessagingCollectionViewHiddenTimestampFlowLayout.h"
#import "DBMessagingCollectionViewSlidingTimestampFlowLayout.h"
#import "DBMessagingCollectionViewFlowLayoutInvalidationContext.h"
#import "DBMessagingCollectionViewLayoutAttributes.h"

// Views
#import "DBMessagingInputToolbar.h"
#import "DBMessagingCollectionView.h"
#import "DBMessagingTextCell.h"
#import "DBMessagingMediaCell.h"
#import "DBMessagingImageMediaCell.h"
#import "DBMessagingVideoMediaCell.h"
#import "DBMessagingLocationMediaCell.h"
#import "DBMessagingInputTextView.h"
#import "DBMessagingCellTextView.h"
#import "DBMessagingTimestampSupplementaryView.h"
#import "DBMessagingLoadEarlierMessagesHeaderView.h"
#import "DBMessagingTypingIndicatorFooterView.h"

// Categories
#import "NSAttributedString+Messaging.h"
#import "NSMutableAttributedString+Messaging.h"
#import "UIColor+Messaging.h"
#import "UIImage+Messaging.h"
#import "UIImage+AnimatedGIF.h"

// Components
#import "DBMessagingPhotoPickerController.h"

#endif
