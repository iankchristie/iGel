//
//  GelObject.m
//  iGel1
//
//  Created by Ian Christie on 7/21/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import "GelObject.h"

@implementation GelObject

@synthesize date;
@synthesize dateString;
@synthesize name;
@synthesize description;
@synthesize original;
@synthesize ladder;
@synthesize pictures;

-(id)initWithImage:(UIImage *)_original {
    return [self initWithName:nil andDate:nil andDateString:nil andDescription:nil andImage:_original andLadder:nil andArray:nil];
}

-(id)initWithName:(NSString *)_name
                andDate:(NSDate *)_date
          andDateString:(NSString *)_dateString
         andDescription:(NSString *)_description
               andImage:(UIImage *)
    _original andLadder:(UIImage *)_ladder
               andArray:(NSArray *)_pictures {
    
    self = [super init];
    if(self) {
        name = _name;
        date = _date;
        dateString = _dateString;
        description = _description;
        original = _original;
        ladder = _ladder;
        pictures = [[NSMutableArray alloc]initWithCapacity:50];
        [pictures insertObject:original atIndex:0];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:date forKey:@"date"];
    [aCoder encodeObject:dateString forKey:@"dateString"];
    [aCoder encodeObject:description forKey:@"description"];
    [aCoder encodeObject:original forKey:@"original"];
    [aCoder encodeObject:ladder forKey:@"ladder"];
    [aCoder encodeObject:pictures forKey:@"pictures"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        name = [aDecoder decodeObjectForKey:@"name"];
        date = [aDecoder decodeObjectForKey:@"date"];
        dateString = [aDecoder decodeObjectForKey:@"dateString"];
        description = [aDecoder decodeObjectForKey:@"description"];
        original = [aDecoder decodeObjectForKey:@"original"];
        ladder = [aDecoder decodeObjectForKey:@"ladder"];
        pictures = [aDecoder decodeObjectForKey:@"pictures"];
    }
    return self;
}

@end
