//
//  CLLocationManager+ForwardGeocoding.m
//  ForwardGeocoding
//
//  Created by Eric Goldberg on 6/4/12.
//  Copyright (c) 2012 Eric Goldberg. All rights reserved.
//

#import "CLLocationManager+ForwardGeocoding.h"
#import "NSString+GeocodeAddress.h"

@implementation CLLocationManager (ForwardGeocoding)

- (void)fetchForwardGeocodeAddress:(NSString *)address withCompletionHandler:(ForwardGeoCompletionBlock)completion {
    
    /**
     * Since the request to grab the geocoded address is using NSString's initWithContentsOfURL 
     * we are going to make use of GCD and grab that async. I didn't put this in the 
     * method itself because there could be an instance where you would want to make a 
     * synchronous call. Better to have flexibility.
     *
     * Possible improvement could be to write another method that does the async 
     * loading for you. However, if you did it that way how would you be notified 
     * when the results returned. Possibly KVO?
     */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(queue, ^{
        
        NSDictionary* locationInfo = [address newGeocodeAddress];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                completion(locationInfo);
            }
        });
    });
}

@end
