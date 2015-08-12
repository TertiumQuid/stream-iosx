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

NSInteger const DefaultTimeoutIntervalInSeconds = 3;

@interface StreamClient()

- (instancetype) initWithApiKey:(NSString *)apiKey andApiSecret:(NSString *)apiSecret;
- (void) initRequestHeaders;
- (void) initSerialization;
- (NSString *) versionBuild;

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

    [self initSerialization];
    [self initRequestHeaders];
    
    self.requestSerializer.timeoutInterval = DefaultTimeoutIntervalInSeconds;
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return self;
}

- (void) initSerialization {
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                           @"text/json",
                                                                           @"text/javascript",
                                                                           @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
}

- (void) initRequestHeaders {
    NSString *clientHeader = [NSString stringWithFormat: @"stream-iosx-%@", [self versionBuild]];
    [self.requestSerializer setValue:clientHeader forHTTPHeaderField:@"X-Stream-Client"];
    
    NSString *authHeader = @"??????????";
    [self.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
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

- (NSString *) versionBuild {
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    
    NSString *versionBuild = version;
    if (![version isEqualToString: build]) {
        versionBuild = build;
    }
    return versionBuild;
}

@end
