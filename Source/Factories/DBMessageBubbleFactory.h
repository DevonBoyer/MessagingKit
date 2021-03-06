//
//  DBMessageBubbleFactory.h
//
//
//  GitHub
//  https://github.com/DevonBoyer/DBMessagingKit
//
//
//  Created by Devon Boyer on 2014-09-01.
//  Copyright (c) 2014 Devon Boyer. All rights reserved.
//
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

/**
 *  A 'DBMessageBubbleFactory' contains class methods for creating configured 'message bubbles'.
 */
@interface DBMessageBubbleFactory : NSObject

/**
 *  Creates an returns an image view object with the specified color for outgoing messages.
 *  The 'image' property of the image view is configured with a flat bubble image, masked to the given color.
 *  The 'highlightedImage' property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be 'nil'.
 *
 *  @return An initialized image view object if created successfully, 'nil' otherwise.
 */
+ (UIImageView *)outgoingMessageBubbleImageWithColor:(UIColor *)color template:(UIImage *)bubbleTemplate;

/**
 *  Creates an returns an image view object with the specified color for incoming messages.
 *  The 'image' property of the image view is configured with a flat bubble image, masked to the given color.
 *  The 'highlightedImage' property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be 'nil'.
 *
 *  @return An initialized image view object if created successfully, 'nil' otherwise.
 */
+ (UIImageView *)incomingMessageBubbleImageWithColor:(UIColor *)color template:(UIImage *)bubbleTemplate;

@end
