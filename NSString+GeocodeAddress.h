//
//  NSString+GeocodeAddress.h
//  ForwardGeocoding
//
//  Created by Eric Goldberg on 6/4/12.
//  Copyright (c) 2012 Eric Goldberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSString (GeocodeAddress)

- (NSDictionary *)newGeocodeAddress;

@end
