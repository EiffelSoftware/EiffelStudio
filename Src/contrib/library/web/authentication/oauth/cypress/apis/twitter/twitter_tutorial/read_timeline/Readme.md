# How to read a User Timeline

Here we will show you how to read a user timeline calling the statuses/user_timeline endpoint, which returns a collection of the most recent Tweets posted by 
the user indicated by the screen_name or user_id parameters. The timeline returned is the equivalent of the one seen as a user’s profile on twitter.com.

## Resource URL
	https://dev.twitter.com/rest/reference/get/statuses/user_timeline

Check the documentation to learn more: https://dev.twitter.com/rest/reference/get/statuses/show/id

## Example

In this example we will also parse JSON response and we will create a new object `list_tweets` instance of `LIST[TWITTER_TWEETS]` class.
First we will check that the Status code is 200, so we know everything is Ok and we have a response body, in other case we show the response status code.

The following snippet code, shows how we do that after we got the Twitter's response, the `l_body` have the JSON response from twitter.
Finally we print out the user timeline.


```
		 -- Now we will parse the response body.
		 -- and display the user timeline details.
		if l_response.status = 200 and then attached l_response.body as l_body then
			if attached {LIST[TWITTER_TWEETS]} (create {TWITTER_JSON}).user_timeline (l_body) as l_tweets then
				across l_tweets as t  loop print (t.item.full_out) io.put_new_line end
			end
		else
			print ("%NResponse: STATUS:" + l_response.status.out)
		end

```

If the feature `{TWITTER_JSON}).show_tweet (l_body) ` can't parse the body, it will raise an error. 



