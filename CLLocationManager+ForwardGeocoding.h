//
//  CLLocationManager+ForwardGeocoding.h
//  ForwardGeocoding
//
//  Created by Eric Goldberg on 6/4/12.
//  Copyright (c) 2012 Eric Goldberg. All rights reserved.
//


//  Started with this gist: https://gist.github.com/1952410
//  but cleaned up to return more useful data than simply lat/lon
//  locationInfoDict contains a CLLocation object from which this 
//  data can still be extracted.

#import <CoreLocation/CoreLocation.h>

typedef void (^ForwardGeoCompletionBlock)(NSDictionary* locationInfoDict);

@interface CLLocationManager (ForwardGeocoding)

- (void)fetchForwardGeocodeAddress:(NSString *)address 
             withCompletionHandler:(ForwardGeoCompletionBlock)completion;

@end
