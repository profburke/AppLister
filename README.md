## README

This iOS app displays information on all the apps installed on the device upon
which it is being run. This app makes use of so-called private API and, as such,
will be rejected if submitted to Apple's App Store.

The source code for this app is being provided to enable and encourage developers
to explore iOS in more detail. If tinkering with this app suggests a feature, etc
that you think would be of benefit to all, don't hesitate to file a radar (insert URL here)
to encourage Apple to consider providing the feature (or changing the relevent API
from private to public; and, no, I don't want to get into a debate over the effectiveness
of filling radars).


## Future Development

There will most likely be little or no future development of this project, although I will
attempt to promptly address bug reports, pull requests, etc. I am particularly interested
in hearing suggestions on how I can improve my Swift coding.

Note that the little bit of Objective-C that exists in this project is there because I couldn't
figure out a Swift way of doing it---particularly a work-around for `performSelector`. Also,
the `AppInfo` class is almost entirely because I kept getting segfaults when trying to use
`LSApplicationProxy` more directly.

