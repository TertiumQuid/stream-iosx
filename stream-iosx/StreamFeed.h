//
//  StreamFeed.h
//  stream-iosx
//
//  Created by Travis Dunn on 12/08/15.
//  Copyright (c) 2015 Bellwether. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StreamClientDelegate.h"

@interface StreamFeed : NSObject

- (instancetype) initWithUserId:(NSString *)feedUserId andSlug:(NSString *)feedSlug andToken:(NSString *)feedToken;
- (NSURL *) feedUrl;

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) NSString *token;

@property (assign, nonatomic) id<StreamClientDelegate> client;

- (NSURLSessionDataTask *)get:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)destroy:(NSString *)URLString
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
