# Stream IOSX

The stream-iosx is an AFNetworking-based iOS/OS X client for Stream (getstream.io) https://getstream.io.

## Setup 

Use CocoaPods to manage the library by adding it to a project's `Podfile` and running:

    pod install

Sign up for a free account at the Stream website, then create a new app from your account's "APPS * FEEDS" page. Get the app's (1) key, and (2) secret which are required to initialize the iOS client.

## Usage ##

Using the API requires the initialization of a `StreamClient` singleton with your app's `key` and `secret`.

    StreamClient *client = [StreamClient initWithApiKey:myApiKey andApiSecret:myApiSecret];

