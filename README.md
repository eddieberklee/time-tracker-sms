
time-tracker-sms
================

TODO
====
http://www.elabs.se/blog/57-handle-secret-credentials-in-ruby-on-rails

IMPORTANT
=========
I need to figure out a better way but for now, `rake assets:precompile` has to be run before pushing to Heroku or Heroku won't reflect any changes to static assets.
  - is this because of haml/sass

To Push to Heroku
=================
  1. rake assets:precompile; git add .; git ci -am "commit message"; git push; git push heroku master

Description
===========

It's quick and easy to send a text of what you're about to do.

It's just as if you're telling a friend you're off to do something:
    "studying"
    "going shopping"
    "going for a run"

When you're done, don't even worry about telling the app you're done.
The point is to track everything that you do in a day.
So just tell the app the next thing you're doing.

For example:
Say I've woken up, studied a bit, changed, went for a run, got back and relaxed, got something to drink,
    checked Facebook, went through some emails, and read through some articles.

What you'd text the app:
    "studying"
    "going for a run"
    "relaxing" <-- the app will imply that this means you're done with your run
    "facebook"
    "email"
    "article reading"

Now for some of the things like "facebook" and "email" they could be very short 5 minute activities,
    but you'd be surprised how many of those supposedly quick activities turn out to be lengthy
    30 minute sessions.
This app is precisely for you to self-realize where your time is going. It does that by tracking and
    later showing you how your day as a whole was spent, but equally importantly, it helps you self-realize
    where your time is being spent by _forcing you to verbalize_ what you're doing. It makes you stop
    and think about what exactly you're doing.

More Plans
----------------

* text app --> app processes start and end times automatically --> sorts into cool timeline and pie chart
* day-to-day analytics are possible to see trends and streaks


Future Features
---------------

* reminders: "you haven't studied in 3 days...wink wink"
             "you're being lazy Eddie, go to the gym since you haven't gone since last week"
    * Along this same train of thought, either sample a period of time for the app to "understand"
      how often something should be done. Another way would be to just have the user input a goal but
      that's not as interesting. Gives the user control, but also adds something else that this app is
      requiring from the user. I kind of like how the user doesn't really need to do anything except
      log every single thing he does. And because that's a habit easier said/envisioned than done,
      maybe reminders should be automatic. Make the app spartan simple - only input everything you're doing.
      Nothing else, we won't even allow you to do anything else.




