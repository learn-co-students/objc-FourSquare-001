

# CocoaPods and Blocks


## Goals 

- Utilize CocoaPods to manage third-party frameworks 
- Preliminary intro to using blocks to handle network tasks 
- Introduction to API's and network communications 

##Project Overview - Basic version

Create an app that displays the Foursquare venue name and checkinsCount.

## CocoaPods  

CocoPods are awesome! They allow us to add third-party frameworks to our projects with minimal effort while managing versions and dependencies.  

1. Verify that the current version of the Foursquare-API-v2 is included in the project.
    * In the root project directory, use Sublime to open the Podfile and confirm that the pod is added to the project target:

    ``` 
    pod 'Foursquare-API-v2', '~> 1.4.8'
    ```
    * Run `pod install` in your terminal to verify that the correct version is installed.

2. Since you'll be using CocoaPods, you'll need to work in the xcworkspace from now on so that the pods are visible to your project.

## Foursquare API Configuration

- Client ID: `4CYIWCSVTU40F1RGDRXIYS1ATQ4TQ2GGXWTRMNW5M3VYPCDW`
- Client Secret: `ZYS0F3CJEFAQVXUWOYW5Y4VZYAT3IR0XLM5QZSW4NRZKVRQ4`
- callbackURL: `testapp123://foursquare`
- Add the following method to your App Delegate. 

Or, feel free to create your own Foursquare account (if you don't already have one) and register your application for on the Foursquare developer website. The callbackURL does not matter (it can really be anything for now), but you will need to get a clientID and clientSecret.

```objc 
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [Foursquare2 handleURL:url];
}
``` 

and the following code to your didFinishLaunchingWithOptions: method

```objc
// AppDelegate.m

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	{ ... }
	// Override point for customization after application launch.
    [Foursquare2 setupFoursquareWithClientId:YOUR_KEY
                      secret:YOUR_SECRET
                 callbackURL:YOUR_CALLBACK_URL]; // You can make this up for now. Use this string @"com.flatironschool"
    return YES;
}
``` 

At this point, our App is configured to make authenticated API calls to the Foursquare API.  There is a ton of magic going on under the hood to allow us to set up communications with the API in just a couple lines of code, but that is the wonderment of CocoaPods; CocoaPods allow complex concepts to be abstracted into simple wrapper classes.  From here on out, we can simply import Foursquare2.h into our classes and use the Foursquare2 cocoapods' methods to make requests from the API.


```objc 

+ (void)venueSearchNearByLatitude:(NSNumber *)latitude
                                 longitude:(NSNumber *)longitude
                                     query:(NSString *)query
                                     limit:(NSNumber *)limit
                                    intent:(FoursquareIntentType)intent
                                    radius:(NSNumber *)radius
                                categoryId:(NSString *)categoryId
                                  callback:(Foursquare2Callback)callback;

```

The Foursquare v2 CocoaPod uses class methods with block callbacks.  Here is an example usage of the previous method.  

```objc

[Foursquare2 venueSearchNearByLatitude:@40.7050 // The user tells us they are at Bowling Green 
                                 longitude:@-74.0136
                                     query:@"Mexican" // User tells us they want mexican 
                                     limit:@100 // We'll allow 100 results 
                                    intent:intentBrowse 
                                    radius:@1500 //We'll search a 1500 m radius 
                                categoryId:nil 
                                  callback:^(BOOL success, id result) {
                                      NSLog(@"%@", result); // This log message prints a dictionary of data returned from the API 
                                  }];

```

If the request is successful, we'll land inside of the callback block with access to a few variables.  
Success is a BOOL which tells us if the request was successful or not and result is a big intimidating dictionary.  

But it's not that bad. We only need to drill down two levels in our dictionary before we start getting valuable data.  ``result[@"response"][@"venues"]`` will give us an array of dictionaries that we can then grab specific information from. 

## Instructions

  * Make a UITableViewController
  * on viewDidLoad, download venues nearby and display the venue name and checkins count in the detailTextLabel.

##Project Overview - Advanced Version

Update the app to ask the user some questions and modify the basic version of the app to return a list of search results that the user can click on for further information. Use NSObject subclasses to store the data from our API instead of doing all of the work in the view controller.


##Git 
Before you get started on solving this challenge, first, some git practice!

You will find an updated storyboard and view controllers for this lab in a branch called `advancedStarterCode.` You're going to want to merge this branch into your project so you don't have to build out the new storyboard and view controllers yourself. Let's recall the best way to merge a storyboard:

1) Compare the two storyboards to see if they are different. Before you even open them up, you can compare them in terminal using the following command:

```
git diff --name-status master..advancedStarterCode
```

If you do not see the storyboard file in the list, you know these files are in fact, the same. In this example, you should see the storyboard file, among many others.

2) Now look at the storyboards, so that you know what to expect. Switch branches to `advancedStarterCode` to take a look at the storyboard you are about to merge into master. 

3) Based on what you see, make a call - which storyboard would you rather move forward with? The one in your branch (`--ours`) or the one in `advancedStarterCode` you are about to merge (`--theirs`)? 

4) Once you git merge (don't forget this step or read to quickly or you will definitely miss it), you will choose to `git checkout --theirs` or `--ours` depending on your answer! Don't forget to add the filename to the command in terminal. So in total, that is:

```
git checkout --theirs objc-FourSquare/Main.storyboard
```

5) Now go into the project and if you need to, manually update the storyboard to reflect anything from your version. (In this case, there isn't any manual storyboard updating necessary.)


##Getting started
First we will ask the user some questions in the initial view controller:

- What are you looking for? // search query string 
- How far are you willing to travel? // in meters  
- Where are you? // latitude and longitude  

Then we will show them search results based on their answers in a second view controller that is pushed on top of the initial view controller.

Keep in mind that this time, we are going to use custom objects instead of NSDictionary. 

Here are the properties and methods for your `Venue` class.

```objc

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *venueId;
@property (nonatomic,strong)Location *location;

- (instancetype)initWithName:(NSString *)name 
                     venueId:(NSString *)venueId 
                    location:(Location *)location; 

/* These Methods are not Required, but are convenience methods that make your life much easier.   Essentially, they allow you to pass in a dictionary or array of dictionaries and return a Venue or array of Venues.  

+ (NSArray *)venuesWithVenues:(NSArray *)venues; // takes an Array of venue dictionaries and returns an array of Venue objects 
+ (instancetype)venueWithVenueDictionary:(NSDictionary *)venueDictionary;  // takes a dictionary and returns a venue.            
*/ 

```

Here are the properties and methods for your `Location` class.

```objc

@property (nonatomic, strong) NSNumber *lat; 
@property (nonatomic, strong) NSNumber *lng;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *crossStreet;


- (instancetype)initWithlat:(NSNumber *)lat 
                        lng:(NSNumber *)lng 
                    address:(NSString *)address
                       city:(NSString *)city
                      state:(NSString *)state
                 postalCode:(NSString *)postalCode
                    country:(NSString *)country
                crossStreet:(NSString *)crossStreet; 

/* These Methods are not Required, but are convenience methods that make your life much easier.   Essentially, they allow you to pass in a dictionary or array of dictionaries and return a Location or array of Locations.  

+ (NSArray *)locationsWithLocations:(NSArray *)locations; // takes an Array of Location dictionaries and returns an array of Location objects
+ (instancetype)locationWithLocationDictionary:(NSDictionary *)locationDictionary;  // takes a dictionary and returns a Location.            
*/ 

```

Taking another look at our Foursquare method from before, let's consider how we'll go about constructing Foursquare objects from our API Call. 

```objc

[Foursquare2 venueSearchNearByLatitude:@40.7050
                                 longitude:@-74.0136
                                     query:@"Mexican"
                                     limit:@100
                                    intent:intentBrowse
                                    radius:@1500
                                categoryId:nil
                                  callback:^(BOOL success, id result) 
{
                                      
	NSArray *venues = result[@"response"][@"venues"];
    NSMutableArray *mutableVenues = [NSMutableArray new];
    for (NSDictionary *venueDict in venues)
    {
    	NSDictionary *locationDictionary = venueDict[@"location"];
        Location *location = [[Location alloc] initWithlat:locationDictionary[@"lat"]
                                                       lng:locationDictionary[@"lng"]
                                                   address:locationDictionary[@"address"]
                                                      city:locationDictionary[@"city"]
                                                     state:locationDictionary[@"state"]
                                                postalCode:locationDictionary[@"postalCode"]
                                                   country:locationDictionary[@"country"]
                                               crossStreet:locationDictionary[@"crossStreet"]];
        
        Venue *venue = [[Venue alloc] initWithName:venueDict[@"name"]
                                           venueId:venueDict[@"id"]
                                          location:location];
        [mutableVenues addObject:venue];
    }
    NSLog(@"%@", mutableVenues); 
    }];

```

This code uses our Location and Venue Designated initializers to create Location and Venue objects for each object in the Venue array.  At this point, you guys should be back in familiar territory. 

## View Controllers 

You'll have three View Controllers. 

###SearchQueryViewController
Contains the questions form. The submit action on this form calls the foursquare API with the parameters the user specifies, creates an array of Venue objects, and passes those venues to the destination view controller in prepareForSegueWithIdentifier. 

###VenuesTableViewController
A tableView that displays the venues (array) passed in from the search results. Should send the selected venue to it's destination ViewController in prepareForSegueWithIdentifier:  

###VenueDetailViewController
Displays the tapped Venue's details.   

## Extra Credit
* Attempt to build in the additional methods below to further streamline your view controller and pass the baton along to the Venue and Location objects.

* Check out SVProgressHUD.  Optimally, you'll show an SVProgressHUD as soon as your API call begins and dismiss the HUD after the call completes.  You can install SVProgressHUD via CocoaPods.  

* Check out `CLLocation` and [check this StackOverflow out to see how to implement current location in iOS8](http://stackoverflow.com/questions/26134641/how-to-get-current-location-lat-long-in-ios-8)! Get the user's current location instead of asking them for one. This is outside of the scope of our regular lessons, but it may come in handy someday!

###Location 
```objc
+ (NSArray *)locationsWithLocations:(NSArray *)locations; // takes an Array of Location dictionaries and returns an array of Location objects 
```

###Venue 
```objc
+ (NSArray *)venuesWithVenues:(NSArray *)venues; // takes an Array of venue dictionaries and returns an array of Venue objects 
+ (instancetype)venueWithVenueDictionary:(NSDictionary *)venueDictionary;  // takes a dictionary and returns a venue.
```

## Links 
 
  - [CocoaPods getting started](http://guides.cocoapods.org/using/getting-started.html#getting-started)
  - [CocoaPods Podfile configuration](http://guides.cocoapods.org/using/the-podfile.html)
  - [Foursquare CocoaPod Github page](https://github.com/Constantine-Fry/Foursquare-API-v2)
  - [Foursquare API Search Documentation](https://developer.foursquare.com/docs/venues/search)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/objc-FourSquare'>(optional) Foursquare</a> on Learn.co and start learning to code for free.</p>
