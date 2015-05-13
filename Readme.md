# A small utility for checking some corporation stats

I'm looking for a small gang PVP corporation and after finding a potential corp, there are three things I usually do:

* Check their Monthly History on zkillboard to get a sense of their recent activity. Example: https://zkillboard.com/corporation/1018389948/stats/ _(I hear dreddit is recruiting)_.
* Ask about their timezone activity. (I'm looking for US Eastern between 0:00-3:00 EVE).
* Ask about their typical fleets. (I'm looking for a mix of micro gang, 2-4, and small gang, up to 10),

However, I have found that with the last two questions, people have a way of exaggerating. Or it might be they really don't know so they're just guessing.

With zkillboard's public API, the last two questions are fairly easy to guestimate based on their killboard activity. Now obviously this isn't the only criteria for choosing a corp, but this does help to quickly get a feel for their PVP activity.

Finally, I'm not above begging. So if you find any of this useful, feel free to send donations to "Resin Neublem" in game. If some wealthy benefactor finds this extremely useful, I may make this into a small webapp.

# :warning: WARNING. THIS IS NOT ROBUST. WARNING :warning:

This is just a few scripts slapped together and shared. None of this is robust and they all likely contain bugs.

Do not hammer the zkillboard API. Don't re-download the data unless you have to.

# How to setup the environment to run these scripts

First make sure both Ruby 2.x and R are installed. Then make sure you bundle the dependencies:

    bundle install

# How to run the script to find information about a corporation

1) Find the corporation ID by looking at the URL on zkillboard or eve-kill.net. For example, the dreddit ID above is 1018389948.

2) Run `./last_1000_kills.sh <corporation_id>`. That will download the last 1000 kills from the zkillboard API and then turn it into a csv.

3) Start R by running `R` and inside the prompt run these commands:

    source("killboard.R")         # this only needs to run the first time to load the R functions
    report(1018389948, "dreddit") # just finds the csv for that corporation and generates a couple reports

That will create a pdf in the folder "reports".

Some examples of PVP corporations that are recruiting in the [EVE Forums](https://forums.eveonline.com/default.aspx?g=topics&f=265) are available in the [examples folder](https://github.com/resinneublem/corpstats-scripts/tree/master/examples).
