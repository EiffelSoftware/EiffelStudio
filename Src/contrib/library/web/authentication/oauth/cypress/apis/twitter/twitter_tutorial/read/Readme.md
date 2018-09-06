# How to read a Tweet

Here we will show you how to read a tweet calling the /1.1/statuses/show.json endpoint, which returns data for a Tweet, given its ID number.
Returns a single Tweet, specified by the id parameter. The Tweet’s author will also be embedded within the Tweet.

## Resource URL
	https://api.twitter.com/1.1/statuses/show.json

Check the documentation to learn more: https://dev.twitter.com/rest/reference/get/statuses/show/id

## Example

In this example we will also parse JSON response and we will create a new object `tweets` instance of `TWITTER_TWEETS` class.
First we will check that the Status code is 200, so we know everything is Ok and we have a response body, in other case we show the response status code.

The following snippet code, shows how we do that after we got the Twitter's response, the `l_body` have the JSON response from twitter.
Finally we print out the tweeter details.


```
	if l_response.status = 200 and then attached l_response.body as l_body then
		if attached {TWITTER_TWEETS} (create {TWITTER_JSON}).show_tweet (l_body) as l_tweet then
			print (l_tweet.full_out)
		end
	else
		print ("%NResponse: STATUS:" + l_response.status.out)
	end

```

If the feature `{TWITTER_JSON}).show_tweet (l_body) ` can't parse the body, it will raise an error. 



