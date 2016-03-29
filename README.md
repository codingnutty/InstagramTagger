# InstagramTagger

## Setup

Clone the project and run the following commands in the project directory:

* `bundle install`
* 'rake db:create'
* `rake db:migrate`
* `rails s`
* go to localhost:3000 in your browser


## Summary

This app allows ones to search tags for instagram photos that belong to the #hashtag within a date rage using a tag start-date and end-date. It uses the httparty gem to make the API call. When the user performs a search, the search criteria (tag name, start date, and end date) is stored in the database. Then, the photos are fetched by calling Instagram API's tag endpoint. This is the first version of the InstaPix app that can be found at https://github.com/codingnutty/instapix

Right now, it renders the index which means the pictures of a certain collection go piling up and eventually may cause the app the hang. Aslo, it currently works synchronously with the back which may cause the system to hang if there is an overload of photos. An attempt to address this has been done in the instapix app.

