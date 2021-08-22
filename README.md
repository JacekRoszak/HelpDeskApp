HelpDeskApp is a bussiness app for managing service requests. Basiclly it gives users a way to request a service from a technicians. They make a request that technicians see in a list. Technicians can take this request, change its status and write a raport. One request can be processed by many technicians. Any of them can edit the raport and add something to it. Technician see only those requests that are sent to his department. User will be informed about every action happening in his request by email. 
User can enable the 2FA in a Profile page. It uses Google Authenticaton.

Tech stock:
Ruby 3.0.0 and Rails 6.1.4.
Rspec with capybara and guard for BDD.
Jquery and jquery-ui for animations.
Bootstrap for styling.
Admin panel made with ActiveAdmin on ArcticAdmin theme - only for admin users.
Cancancan for managing authorizations.
Devise with two factor for Users.
Hotwire and stimulus for broadcasting requests.
Redis and Sidekiq for background jobs.
I used Sengrid and Slim.

There is a seed in db that will provide you with some sample data.

