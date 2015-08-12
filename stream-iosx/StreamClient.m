//
//  StreamClient.m
//  stream-iosx
//
//  Created by Travis Dunn on 06/08/15.
//  Copyright (c) 2015 Bellwether. All rights reserved.
//

#import "StreamClient.h"
#import "StreamFeed.h"

NSString * const StreamAPILocation = @"api";
NSString * const StreamAPIVersion = @"v1.0";
NSString * const StreamAPIUrl = @"https://%@.getstream.io/api/%@";

@interface StreamClient()

- (instancetype) initWithApiKey:(NSString *)apiKey andApiSecret:(NSString *)apiSecret;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end

@implementation StreamClient

+ (instancetype) sharedClient {
    return [self initWithApiKey:nil andApiSecret:nil];
}

+ (instancetype) initWithApiKey:(NSString *)apiKey andApiSecret:(NSString *)apiSecret {
    static StreamClient *client = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        client = [[StreamClient alloc] initWithApiKey:apiKey andApiSecret:apiSecret];
    });
    return client;
}

- (instancetype) initWithApiKey:(NSString *)apiKey andApiSecret:(NSString *)apiSecret {
    NSString *baseUrl = [NSString stringWithFormat:StreamAPIUrl, StreamAPILocation, StreamAPIVersion];
    
    self = [super initWithBaseURL:[NSURL URLWithString:baseUrl]];
    if (!self) {
        return nil;
    }
    self.apiKey = apiKey;
    self.apiSecret = apiSecret;
    self.apiVersion = StreamAPIVersion;
    self.apiLocation = StreamAPILocation;
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return self;
}

- (StreamFeed *) getFeedForUserId:(NSString *)userId andSlug:(NSString *)slug {
    NSString *token = @""; // TODO: sign token
    
    StreamFeed *feed = [[StreamFeed alloc] initWithUserId:userId andSlug:slug andToken:token];
    feed.client = self;
    
    return feed;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    return [super GET:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    return [super PUT:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    return [super POST:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    return [super DELETE:URLString parameters:parameters success:success failure:failure];
}

@end
