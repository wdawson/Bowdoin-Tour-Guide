 //
//  Building.m
//  Bowdoin Tour Guide
//
//  Created by Enrique Naudon on 11/21/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//

#import "Building.h"

@implementation Building

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize coordinate = _coordinate;

@synthesize dir = _dir;
@synthesize thumbnail = _thumbnail;
@synthesize images = _images;

- (id) init
{
    [NSException raise:@"Wrong building initializer"
                format:@"Use initWithTitle:AndSubtitle:AndCoordinate:"];
    return nil;
}

- (id) initWithTitle:(NSString *)title
         AndSubtitle:(NSString *)subtitle
       AndCoordinate:(CLLocationCoordinate2D)coordinate
              AndDir:(NSString *)dir
{
    if ([super init])
    {
        _title = [title copy];
        _subtitle = [subtitle copy];
        _coordinate = coordinate;
        _dir = [dir copy];
    }
    return self;
}

#pragma mark - NSObject Protocol

- (BOOL)isEqual:(id)object
{
    return ([object isKindOfClass:[Building class]] &&
            [object respondsToSelector:@selector(title)] &&
            [[object title] isEqual:self.title]);
}

- (NSUInteger)hash
{
    return [self.title hash];
}

- (NSString *)description
{
  //this is ugly, but \t (tab) isn't getting handled properly.  also, we don't
  //want to use multiple lines if we can avoid it.
  return [NSString stringWithFormat:@"%@ (%g, %g)",
          self.title, self.coordinate.latitude, self.coordinate.longitude];
}

#pragma mark - Utility Methods

/*Returns the thumbnail for this building object as a UIImage
 *
 *Parameters:
 *  none
 *Returns:
 *  thumbnail as a UIImage
 */
- (UIImage *) thumbnail
{
  if (!_thumbnail && self.dir)
  {
    NSString *path = [NSString stringWithFormat:@"%@%@%@/%@",
                      BASE_URL, TOUR_URL, self.dir, THUMBNAIL_NAME];
    NSLog(@"Path: %@", path);
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
    NSLog(@"Data: %@", imageData);
    _thumbnail = [[UIImage alloc ] initWithData:imageData];
    NSLog(@"Thumnail: %@", _thumbnail);
  }
  return _thumbnail;
}

/*Returns the an array of the images associated with this building.
 *
 *Parameters:
 *  none
 *Returns:
 *  array of images
 */
- (NSArray *) images
{\
  if (!_images && self.dir)
  {
    //determine media directory
    NSString *mediaDir = [NSString stringWithFormat:@"%@%@",
                           [[NSBundle mainBundle] bundlePath], self.dir];
    
    //grab images only
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:mediaDir
                                                                            error:nil];
    NSArray *imgNames = [contents filteredArrayUsingPredicate:
                         [NSPredicate predicateWithFormat:@"self ENDSWITH '.jpg'"]];
    
    //go home, thumbnail.  you're not wanted here
    imgNames = [contents filteredArrayUsingPredicate:
                         [NSPredicate predicateWithFormat:@"self != %@", THUMBNAIL_NAME]];
    
    //populate _images with images...
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[imgNames count]];
    for (NSString *name in imgNames) {
      NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",
                                                    mediaDir, name]];
      UIImage *img = [UIImage imageWithData:data];
      [ret addObject:img];
    } 
    _images = ret;
  }
  return _images;
}

@end
