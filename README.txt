Calculator README
=================


GENERAL INFORMATION
* Program Name : Bowdoin Tour Guide
* Version      : v1.0
* Institution  : Bowdoin College
* Developers   : Wils Dawson
                 EJ Googins
                 Enrique Naudon
* Date Created : 10/17/11
* Last Updated : 12/17/11

DESCRIPTION
     This is an Objective-C tour guide app written for iOS 5.  This app allows
the user, presumably a prospective Bowdoin student (or prospy in the
vernacular), to take a tour of the Bowdoin campus in the absence of a "real"
tour guide.  Currently, upon execution, Bowdoin Tour Guide presents the prospy
with a map of the Bowdoin campus, with pins over major landmarks.  The prospy
can get media and information about any of the annotated buildings by tapping
on any of the pins, and then tapping on the resultant pop-up's left callout
button.

FEATURES
- Annotated map of the Bowdoin campus
- Detailed (albeit archaic) media and information about campus landmarks
- Map manipulation through custom gestures (see bellow)
- iPhone and iPad support

GESTURES
- Pinch in to zoom to current region
- Double-tap to zoom in to a region
- Pan to move to adjacent regions
- Pinch out to zoom out

KNOWN BUGS/ISSUES
- Media is currently hosted on the end user device
- Building slide shows can't be paused
- No support for a guided tour, custom or otherwise
- Building info/media is old

VERSION HISTORY
v0.10 - Bowdoin Tour Guide is essentially a crappy version of Google Maps that
        only shows you Bowdoin.  And doesn't allow zooming.  Or rotating.
v0.20 - Added map type controls (satelite, hybrid, map) and rotation.  Now its a
        slightly less crappy version of Goggle Maps.
v0.30 - Added "rotate depending on which way you're facing" functionality.
v0.40 - Created MVC framework for buildings.  Also included a building info text
        file.  (Creating it involved much tedium.)
v0.41 - Added Bowdoin specific annotations (pins) to the map.  Tapping them
        pops up a pop-up (makes a pop-up appear), with some building info (name
        and departments), along with a thumbnail.
v0.42 - Built a media view for detailed building info (slideshow, text, audio).
        Tapping the left callout of building pop-ups pushes this view.
v0.50 - Renamed the building images to facilitate pulling from the web.
v0.60 - Gesture support added.
v0.70 - HTML parsing back-end added.  Text is displayed in a WebView rather
        than a TextView as before.
v0.71 - Separate WebView for following in-text links added.  Pushed when links
        are pressed (duh).
v0.72 - WebView zoom functionality implemented.
v0.73 - Basic internet functions (refresh, stop, back, forward) added to
        WebView.
v0.80 - Slideshow functionality in media view added.
v0.90 - Buildings handle their own images (yay MVC).

v1.00 - Clean-up.  Readme added.


ACKNOWLEDGEMENTS
     Thanks, of course, to Professor Chown, our ever so helpful, patient and
generally awesome teacher.  Thanks are also due to David Israel for providing
us with the media used in the app, and for hosting renamed photos for us to
pull from the web.

README's README
* Author  : Enrique S. Naudon
* Created : 12/18/11
* Updated : 12/18/11

