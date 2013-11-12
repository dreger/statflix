# Statflix.rb
A small Ruby script to aggregate your Netflix Recently Watched (RW) history.

### How to use
Just put your Netflix email and password into the appropriate fields and then run `ruby statflix.rb`. The script will print out everything that you've watched today and add together the sum of the time spent watching.

### JSON data
If you want some data to test locally, log in to you Netflix account in any browser and navigate to [https://api-global.netflix.com/desktop/account/viewinghistory](https://api-global.netflix.com/desktop/account/viewinghistory). This will return a JSON file of your RW history.