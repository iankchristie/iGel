//
//  GelObject.h
//  iGel1
//
//  Created by Ian Christie on 7/21/12.
//  Copyright (c) 2012 Carnegie Vanguard High School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GelObject : NSObject <NSCoding> {
    NSDate *date;
    NSString *dateString;
    NSString *name;
    NSString *description;
    UIImage *original;
    UIImage *ladder;
    NSMutableArray *pictures;
}

@property(nonatomic,retain) NSDate *date;
@property(copy) NSString *dateString;
@property(copy) NSString *name;
@property(copy) NSString *description;
@property(nonatomic,retain) UIImage *original;
@property(nonatomic,retain) UIImage *ladder;
@property(nonatomic,retain)NSMutableArray *pictures;

-(id)initWithImage:(UIImage *)_original;

-(id)initWithName:(NSString *)_name
                andDate:(NSDate *)_date
          andDateString:(NSString *)_dateString
         andDescription:(NSString *)_description
               andImage:(UIImage *)
    _original andLadder:(UIImage *)_ladder
               andArray:(NSArray *)_pictures;
@end
