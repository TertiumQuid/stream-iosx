//
//  StreamClient.h
//  stream-iosx
//
//  Created by Travis Dunn on 06/08/15.
//  Copyright (c) 2015 Bellwether. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "StreamClientDelegate.h"

@class StreamFeed;

@interface StreamClient : AFHTTPSessionManager <StreamClientDelegate>

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *apiSecret;
@property (strong, nonatomic) NSString *apiVersion;
@property (strong, nonatomic) NSString *apiLocation;

+ (instancetype) sharedClient;
+ (instancetype) initWithApiKey:(NSString *)apiKey andApiSecret:(NSString *)apiSecret;

- (StreamFeed *) getFeedForUserId:(NSString *)userId andSlug:(NSString *)slug;


@end
