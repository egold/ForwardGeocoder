//
//  NSString+GeocodeAddress.m
//  ForwardGeocoding
//
//  Created by Eric Goldberg on 6/4/12.
//  Copyright (c) 2012 Eric Goldberg. All rights reserved.
//

//  Most code in here taken directly from kwylez: https://gist.github.com/1952410
//  Main difference is returning more data in a dictionary instead of just lat/lon coordinate

#import "NSString+GeocodeAddress.h"
#import "JSONKit.h"

@implementation NSString (GeocodeAddress)

-(NSDictionary *)newGeocodeAddress
{
    __block NSMutableDictionary *locationDict = [NSMutableDictionary dictionary];
    
    NSString *gUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false", self];
    
    gUrl = [gUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *infoData = [[[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:gUrl]
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil] autorelease];
    
    if ((infoData == nil) || ([infoData isEqualToString:@"[]"])) {
        
        return locationDict;
        
    } else {
        
        NSDictionary *jsonObject = [infoData objectFromJSONString]; 
        
        if (jsonObject == nil) {
            return nil;
        }
        
        NSArray *result = [jsonObject objectForKey:@"results"];
        
        [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

            NSArray *addressFields = [obj objectForKey:@"address_components"];
            for (NSDictionary* field in addressFields) 
            {
                NSArray* types = [field objectForKey:@"types"];
                for (NSString* typeName in types) 
                {
                    [locationDict setObject:[field objectForKey:@"long_name"] forKey:typeName];
                }
            }
            
            NSDictionary *locationFields = [[obj objectForKey:@"geometry"] valueForKey:@"location"];
            
            CLLocation* location = [[CLLocation alloc] initWithLatitude:[[locationFields valueForKey:@"lat"] doubleValue]
                                                              longitude:[[locationFields valueForKey:@"lng"] doubleValue]];
            
            [locationDict setObject:location forKey:@"location"];
            
            *stop = YES;
        }];  
    }   
    
    return locationDict;
}

@end
