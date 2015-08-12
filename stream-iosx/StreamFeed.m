//
//  StreamFeed.m
//  stream-iosx
//
//  Created by Travis Dunn on 12/08/15.
//  Copyright (c) 2015 Bellwether. All rights reserved.
//

#import "StreamFeed.h"

@implementation StreamFeed

- (instancetype) initWithUserId:(NSString *)feedUserId andSlug:(NSString *)feedSlug andToken:(NSString *)feedToken {
    self = [super init];
    if(self)
    {
        self.userId = feedUserId;
        self.slug = feedSlug;
        self.token = feedToken;
    }
    return self;
}

- (NSURL *) feedUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", self.slug, self.userId]];
}

- (NSURLSessionDataTask *)get:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return nil;
}

- (NSURLSessionDataTask *)destroy:(NSString *)URLString
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return nil;
}

@end
