//
//  ViewController.m
//
//
//  GitHub
//  https://github.com/DevonBoyer/DBMessagingKit
//
//
//  Created by Devon Boyer on 2014-12-04.
//  Copyright (c) 2014 Devon Boyer. All rights reserved.
//
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "ViewController.h"
#import "Message.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, DBMessagingPhotoPickerControllerDelegate> {
    
    NSDictionary *_boldAttributes;
    NSDictionary *_normalAttributes;
    NSDictionary *_timestampAttributes;
    NSMutableArray *_messages;
    DBMessageBubbleController *_messageBubbleController;
}

@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * DEMO
     */
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePickerController.delegate = self;
    
    _messages = [[NSMutableArray alloc] init];
    
    [_messages addObject:[[Message alloc] initWithValue:@"Welcome to DBMessagingKit. A messaging, UI framework for iOS."
                                                   mime:[DBMessagingTextCell mimeType]
                                           sentByUserID:@"Outgoing"
                                                 sentAt:[NSDate date]]];
    
    [_messages addObject:[[Message alloc] initWithValue:@"It is simple to use and very customizable."
                                                   mime:[DBMessagingTextCell mimeType]
                                           sentByUserID:@"Incoming"
                                                 sentAt:[NSDate date]]];
    
    [_messages addObject:[[Message alloc] initWithValue:@"You can send text, images, GIFs, movies, or even your location."
                                                   mime:[DBMessagingTextCell mimeType]
                                           sentByUserID:@"Outgoing"
                                                 sentAt:[NSDate date]]];
    
    [_messages addObject:[[Message alloc] initWithValue:@"You can add as many buttons to the input toolbar as you want."
                                                   mime:[DBMessagingTextCell mimeType]
                                           sentByUserID:@"Outgoing"
                                                 sentAt:[NSDate date]]];
    
    [_messages addObject:[[Message alloc] initWithValue:@"Also supports all data detectors like phone numbers 123-456-7890 and websites https://github.com/DevonBoyer/DBMessagingKit."
                                                   mime:[DBMessagingTextCell mimeType]
                                           sentByUserID:@"Incoming"
                                                 sentAt:[NSDate date]]];
    
    _boldAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0],
                        NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    
    _normalAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                          NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    
    _timestampAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                             NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    
    [[DBMessagingTimestampFormatter sharedFormatter] setDateTextAttributes:_boldAttributes];
    [[DBMessagingTimestampFormatter sharedFormatter] setTimeTextAttributes:_normalAttributes];
    
    
    /*
     * Message Bubbles (Optional, Recommended)
     */
    _messageBubbleController = [[DBMessageBubbleController alloc] initWithCollectionView:self.collectionView outgoingBubbleColor:[UIColor iMessageBlueColor] incomingBubbleColor:[UIColor iMessageGrayColor]];
    [_messageBubbleController setTopTemplateForConsecutiveGroup:[UIImage imageNamed:@"MessageBubbleTop"]];
    [_messageBubbleController setMiddleTemplateForConsecutiveGroup:[UIImage imageNamed:@"MessageBubbleMid"]];
    [_messageBubbleController setBottomTemplateForConsecutiveGroup:[UIImage imageNamed:@"MessageBubbleBottom"]];
    [_messageBubbleController setDefaultTemplate:[UIImage imageNamed:@"MessageBubbleDefault"]];
    
    
    /*
     * Layout Attributes (Optional)
     *
     * @warning The 'timestampStyle' must be set before customizing layout attributes.
     */
    
    self.timestampStyle = DBMessagingTimestampStyleSliding;
    
    self.collectionView.collectionViewLayout.messageBubbleFont = [UIFont systemFontOfSize:18.0];
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeMake(34.0, 34.0);
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeMake(0.0, 0.0);
    
    /*
     * Input Toolbar (Optional)
     *
     * @warning The input toolbar's buttons are totally up to you. It is recommended that you add a 'send' button and 
     * set it as the toolbar's send button property. You are in charge of handling each button's 'action'.
     */
    UIBarButtonItem *locationBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"location_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(locationButtonTapped:)];
    locationBarButtonItem.tintColor = [UIColor iMessageBlueColor];
    
    UIBarButtonItem *cameraBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera_button"] style:UIBarButtonItemStylePlain target:self action:@selector(cameraButtonTapped:)];
    
    UIBarButtonItem *sendBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendButtonTapped:)];
    sendBarButtonItem.tintColor = [UIColor iMessageBlueColor];

    [self.messageInputToolbar addItem:cameraBarButtonItem position:DBMessagingInputToolbarItemPositionLeft animated:false];
    [self.messageInputToolbar addItem:locationBarButtonItem position:DBMessagingInputToolbarItemPositionRight animated:false];
    [self.messageInputToolbar addItem:sendBarButtonItem position:DBMessagingInputToolbarItemPositionRight animated:false];
    
    self.messageInputToolbar.textView.placeholderText = @"Text Message";
    
    // Specify which bar button will be the send button
    self.messageInputToolbar.sendBarButtonItem = sendBarButtonItem;
    
    /*
     * Mime Types (Optional)
     *
     * You can choose the 'mime' type that should correspond to each cell. The 'mime' type is used to decide which
     * type of view should be used to display the value for a given message. The mime type can be accessed at any 
     * time by calling [DBMessagingTextCell mimeType].
     *
     * The default 'mime' types are as follows:
     *      DBMessagingTextCell - 'text/plain'
     *      DBMessagingImageMediaCell - 'image/jpeg'
     *      DBMessagingVideoMediaCell - 'video/mp4'
     *      DBMessagingLocationMediaCell - 'geo'
     *
     * Examples of possible mime types and associated values (again these are totally up to your app's schema):
     *     mime -> 'image/url'    value -> The URL for the remote image or video.
     *     mime -> 'image/plain'  value -> A base64 encoded string representing an image or video sent from a web socket.
     *     mime -> 'geo/json'     value -> A JSON string representing a geolocation.
     *     mime -> 'image/jpeg',  value -> An image retrieved from disk.
     *
     * You are given the chance to perform any long-running tasks that may be required in your implementation of 
     * 'collectionView:wantsMediaForMediaCell:atIndexPath:'
     *
     * Note: This approach may seem fairly cumbersome but this allows for the library to work with your app's schema
     * instead of the other way around.
     */
    [DBMessagingTextCell setMimeType:@"text/plain"];
    [DBMessagingImageMediaCell setMimeType:@"image/jpeg"];
    [DBMessagingVideoMediaCell setMimeType:@"video/mp4"];
    [DBMessagingLocationMediaCell setMimeType:@"geo"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)locationButtonTapped:(id)sender {
    
    [self.locationManager startUpdatingLocation];

    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
        
//    [_messages addObject:[[Message alloc] initWithValue:self.currentLocation
//                                                   mime:[DBMessagingLocationMediaCell mimeType]
//                                           sentByUserID:[self senderUserID]
//                                                 sentAt:[NSDate date]]];
//    [self finishSendingMessage];
    
    NSLog(@"current Location %@", self.currentLocation);
}

- (void)cameraButtonTapped:(id)sender {
    
    /**
     *  The 'DBMessagingPhotoPickerController' is only available in iOS8.
     */
    if ([DBMessagingPhotoPickerController class]) {
        DBMessagingPhotoPickerController *photoPickerController = [[DBMessagingPhotoPickerController alloc] init];
        photoPickerController.delegate = self;
        [self presentViewController:photoPickerController animated:YES completion:nil];
        
    } else {

        [self presentViewController:_imagePickerController animated:true completion:nil];
    }
}

- (void)sendButtonTapped:(id)sender {
    
    /**
     *  Get the message parts and send the message however you wish to the socket.
     *
     *  Message Part: [NSString : id] -> [mime : value]
     *  Example:      ["text/plain" : "This is a text message."]
     *                ["image/jpeg" : <UIImage>]
     */
    
    NSArray *messageParts = self.messageInputToolbar.textView.messageParts;
    
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Get the message parts from the input text view
     *  1. Play sound (optional)
     *  2. Add new model objects to your data source
     *  3. Call 'finishSendingMessage'
     */
    [self sendMessageWithParts:messageParts];
    
}

- (void)sendMessageWithParts:(NSArray *)parts {
    
    /**
     *  DEMO implementation for sending the message parts.
     */
    for (NSDictionary *part in parts) {
        NSString *mime = part[DBMessagePartMIMEKey];
        id value = part[DBMessagePartValueKey];
        
        [_messages addObject:[[Message alloc] initWithValue:value
                                                       mime:mime
                                               sentByUserID:[self senderUserID]
                                                     sentAt:[NSDate date]]];
    }
    [self finishSendingMessage];
}

#pragma mark - DBMessagingPhotoPickerControllerDelegate

- (void)photoPickerController:(DBMessagingPhotoPickerController *)picker didFinishPickingPhotos:(NSArray *)photos action:(DBMessagingPhotoPickerControllerAction)action {
    
    switch (action) {
        case DBMessagingPhotoPickerControllerActionSend: {
            NSMutableArray *parts = [[NSMutableArray alloc] init];
            for (UIImage *photo in photos) {
                [parts addObject:@{DBMessagePartMIMEKey : [DBMessagingImageMediaCell mimeType],
                                   DBMessagePartValueKey : photo}];
            }
            [self sendMessageWithParts:parts];
            break;
        }
        case DBMessagingPhotoPickerControllerActionComment:
            for (UIImage *photo in photos) {
                [self.messageInputToolbar.textView addImageAttatchment:photo];
            }
            break;
        default:
            break;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoPickerController:(DBMessagingPhotoPickerController *)picker didDismissWithOption:(DBMessagingPhotoPickerControllerOption)option {
    
    switch (option) {
        case DBMessagingPhotoPickerControllerOptionPhotoLibrary:
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_imagePickerController animated:true completion:nil];
            break;
        case DBMessagingPhotoPickerControllerOptionTakePhoto:
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_imagePickerController animated:true completion:nil];
            break;
        case DBMessagingPhotoPickerControllerOptionCancel:
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    [self.messageInputToolbar.textView addImageAttatchment:chosenImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DBMessagingCollectionViewDataSource

- (NSString *)senderUserID {
    return @"Outgoing";
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _messages.count;
}

- (NSString *)collectionView:(UICollectionView *)collectionView sentByUserIDForMessageAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = [_messages objectAtIndex:indexPath.row];
    return message.sentByUserID;
}

- (NSString *)collectionView:(UICollectionView *)collectionView mimeForMessageAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = [_messages objectAtIndex:indexPath.row];
    return message.mime;
}

- (id)collectionView:(UICollectionView *)collectionView valueForMessageAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = [_messages objectAtIndex:indexPath.row];
    return message.value;
}

- (NSAttributedString *)collectionView:(UICollectionView *)collectionView messageTopLabelAttributedTextForItemAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = [_messages objectAtIndex:indexPath.row];
    
    // Add some logic to displaying sender's name
    
    NSString *sentByUserID = [self collectionView:collectionView sentByUserIDForMessageAtIndexPath:indexPath];
    
    if (sentByUserID == nil ) { return nil; }
    
    if (indexPath.row == 0) {
        return [[NSAttributedString alloc] initWithString:message.sentByUserID attributes:_normalAttributes];
    }
    else {
        NSString *previousSentByUserID = [self collectionView:collectionView sentByUserIDForMessageAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row - 1 inSection:indexPath.section]];
        
        if (![previousSentByUserID isEqualToString:sentByUserID]) {
            return  [[NSAttributedString alloc] initWithString:message.sentByUserID attributes:_normalAttributes];
        }
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(UICollectionView *)collectionView cellTopLabelAttributedTextForItemAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = [_messages objectAtIndex:indexPath.row];

    if (indexPath.row % 3 == 0) {
        return [[DBMessagingTimestampFormatter sharedFormatter] attributedTimestampForDate:message.sentAt];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(UICollectionView *)collectionView cellBottomLabelAttributedTextForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSAttributedString *)collectionView:(UICollectionView *)collectionView timestampAttributedTextForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath {
    
    Message *message = [_messages objectAtIndex:indexPath.row];
    
    switch (self.timestampStyle) {
        case DBMessagingTimestampStyleHidden: {
            NSString *timestamp = [[DBMessagingTimestampFormatter sharedFormatter] verboseTimestampForDate:message.sentAt];
            return [[NSAttributedString alloc] initWithString:timestamp attributes:_timestampAttributes];
        }
        case DBMessagingTimestampStyleSliding: {
            NSString *timestamp = [[DBMessagingTimestampFormatter sharedFormatter] timeForDate:message.sentAt];
            return [[NSAttributedString alloc] initWithString:timestamp attributes:_normalAttributes];
        }
        default:
            return nil;
    }
}

- (UIImageView *)collectionView:(UICollectionView *)collectionView messageBubbleForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_messageBubbleController messageBubbleForIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView wantsAvatarForImageView:(UIImageView *)imageView atIndexPath:(NSIndexPath *)indexPath {
    
    /**
     *  Set the avatar image by retreiving from the network or disk.
     *
     *  Tip: To hide an avatar for a specific indexPath just simply set the imageView.hidden to YES.
     */
}

- (void)collectionView:(UICollectionView *)collectionView wantsMediaForMediaCell:(DBMessagingMediaCell *)mediaCell atIndexPath:(NSIndexPath *)indexPath {
    
    /**
     *  Set the media for the cell.
     *
     *  Example values:
     *      - The URL for the remote image or video
     *      - A base64 encoded string representing an image or video sent from a web socket.
     *      - A JSON string representing a geolocation.
     *      - A UIImage retrieved from disk.
     */
    
    id value = [self collectionView:collectionView valueForMessageAtIndexPath:indexPath];
    
    if ([mediaCell isKindOfClass:[DBMessagingImageMediaCell class]]) {
        UIImage *image = (UIImage *)value;
        ((DBMessagingImageMediaCell *)mediaCell).imageView.image = image;
    }
    
    if ([mediaCell isKindOfClass:[DBMessagingVideoMediaCell class]]) {
        
    }
    
    if ([mediaCell isKindOfClass:[DBMessagingLocationMediaCell class]]) {
        
    }
}

#pragma mark - DBMessagingCollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Avatar Tapped");
}

- (void)collectionView:(UICollectionView *)collectionView didTapMessageBubbleImageView:(UIImageView *)messageBubbleImageView atIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Message Tapped");
}

- (void)collectionView:(UICollectionView *)collectionView didTapMediaView:(DBMessagingMediaView *)mediaView atIndexPath:(NSIndexPath *)indexPath {
    
    Message *message = [_messages objectAtIndex:indexPath.row];
    NSLog(@"%@", message.mime);
}

#pragma mark - DBMessagingCollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(DBMessagingCollectionViewBaseFlowLayout *)collectionViewLayout referenceSizeForMediaViewAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *mime = [self collectionView:collectionView mimeForMessageAtIndexPath:indexPath];
    
    if ([mime isEqualToString:[DBMessagingImageMediaCell mimeType]]) {
        
        return CGSizeMake(200.0, 220.0);
    }
    
    if ([mime isEqualToString:[DBMessagingVideoMediaCell mimeType]]) {
        
    }
    
    if ([mime isEqualToString:[DBMessagingLocationMediaCell mimeType]]) {
        
        return CGSizeMake(200.0, 100.0);
    }
    
    return collectionViewLayout.mediaViewReferenceSize;
}

@end
