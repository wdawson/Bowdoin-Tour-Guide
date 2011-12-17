//
//  WebConstants.h
//  Bowdoin Tour Guide
//
//  Created by William Dawson on 12/11/11.
//  Copyright (c) 2011 Bowdoin College. All rights reserved.
//
//  These constants define certain keys in the html code located at
//  http://www.bowdoin.edu/about/campus/tour/
//  This is a dependency. It would be a good idea to come up with
//  some sort of standard for these pages, possibly with special
//  flags for this purpose only (i.e. some comment that indicates
//  where we should stop and end, or what should be removed in the
//  body of the text). Currently (12/12/2011), these settings work
//  for all the pages that I know of.


#ifndef Bowdoin_Tour_Guide_WebConstants_h
#define Bowdoin_Tour_Guide_WebConstants_h

#define WEB_SEGUE_ID @"loadWeb"

// url constants
#define BASE_URL @"http://www.bowdoin.edu"
#define TOUR_URL @"/about/campus/tour"
#define MEDIA_URL @"/custom"
#define WEB_PAGE_SUFFIX @"/index.shtml"
#define THUMBNAIL_NAME @"bowdoin-building.jpg"

// html parsing constants
#define NOTE_START @"<div class=\"notebody\">"
#define DIV_FLAG @"</div>"
#define BR_FLAG @"<br/>"
#define BR_REPLACE @"<p></p>"
#define HR_FLAG @"<hr/>"
#define TEXT_END @"<p id=\"backForth\">"
#define TEXT_END_ALT @"\n\n"
#define ILLEGAL_LINK @"<a href=\"/about/campus/tour/"
#define IMAGE_START @"<img"
#define END_LINK @"</a>"
#define MY_PREFIX @"<html><body style=\"font-family:verdana;font-size:100%;color:#505050\"><strong>Fun Fact</strong>"
#define MY_SUFFIX @"</body></html>"

#endif
