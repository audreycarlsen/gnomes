Gnome Sweet Gnome
=================

Audrey and Galina were recently contacted by a lawyer whose client, a rich recluse, recently passed away, but apparently was so impressed with Ada Developers Academy that they wrote us into their will! We have received a $15,000,000 gift, with only one string attached - we have to help turn a large empty lot in the neighborhood into a community garden!

## Goals
- Successful pair programming experience
- Develop personal project management skills
- APIs
    + Calendering
    + Weather
    + Twitter?
- Revisit
    + Resque
    + ActionMailer
    + Scheduler
- Time-based events

## Guidelines

+ Students will work in pairs, working in branches and submitting all code to Github via pull requests for code review
+ Practice TDD (rspec) to lead the development process of Models and Controllers
+ Create a new PivotalTracker project and keep the stories up-to-date
+ Create an attractive visual presentation
+ Can send email notifications via ActionMailer and Resque

## Expectations

Your task is to create a web application that will help organize the garden, by keeping a central calendar for events, classes, and different planting seasons, keep track of shared resources (hand tools and compost, mostly!), send reminders of recurring events, and act as a community portal for the latest gardening news and information. You will have access to a representative of the law firm (Miller, Smuin, and Worthy) who will accept or reject each portion of the project.

### Technical Requirements
These are the minimum requirements for us to get the $15,000,000

+ Allows Users to sign-up and login with Twitter
+ Allows Users who are admins of the system to create blog posts for a "News" section
+ Sends Users email updates when new News articles are posted
+ Allows Users to add comments to a News post (Disqus?)
+ On the home page, displays the latest weather conditions and forecast (if available)
+ A "Calendar" section that community members can submit new events to
+ A "Tool Library" for Users to "checking out" and "check in" shared tools - rakes, shovels, wheelbarrows, etc
+ Aesthetically pleasing look and feel that displays properly on an iPhone and iPad

### Extra Credit
Each of these will increase the size of the endowment by $2,000,000 when completed.. but only if the technical requirements are complete!

+ Allow Users to reserve a Tool, and receive an SMS when it becomes available
+ Allow Users to RSVP for calendar events
+ Uses AJAX in two places to improve the User Experience (UX)


## Evaluation
+ Learning Goals
    * Demonstrate comprehension of Rails
    * Comfort with Pivotal Tracker (and any other project tools used)
    * Working as a pair
    * Accepting challenges by working on parts of the project outside your individual comfort zone

+ Client Satisfaction
    * Visually appealing and polished
    * No major bugs
        - Minor bugs noted in Pivotal Tracker or as a Github issue 

+ Code Quality
    * Metrics
        - Flog: no Controller method > 25, no Model method > 15
        - Rubocop: no more than 15 code style issues
        - Brakeman: no major security issues
        - Code Coverage for all Controller routes, Model validations, and Model methods