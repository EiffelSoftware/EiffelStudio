# How to send/post a Tweet

Here we will show you how to post tweet calling the /1.1/statuses/update.json endpoint, updates the authenticating user’s current status, also known as Tweeting.


Until now, we have been using the default 'read only' premission. Twitter applications have different access levels. To learn more read the followind doc https://dev.twitter.com/oauth/overview/application-permission-model.
So if we want to send a tweet, we need to update our application to "read and write" premission.

## Update your Application
Update your app to "read and write permissions". (the tweet will be send from the account which owns the app.)

* Go to https://dev.twitter.com/apps and select the app you created in the first step of this tutorial . 
	* Click the 'Permission' tab and change your application type to "read and write" and "Update Settings".
    * Click back to the 'details' tab and then regenerate your access token and secret. (It's required because the old ones were generated with a read only access level.)

## Resource URL
	https://api.twitter.com/1.1/statuses/update.json

Check the documentation to learn more: https://dev.twitter.com/rest/reference/post/statuses/update

## Example

Here we will post a tweet and finally we check the status code is 200 ok. In the snippet code we show how we do that.

```
		-- Build the request and authorize it with OAuth.
	create request.make ("POST", protected_resource_url)
		-- add the `status` parameters and the tweet message.
	request.add_body_parameter ("status","Tweeting from EiffelWeb API, using Cypress Library")
	api_service.sign_request (l_access_token, request)
	if attached {OAUTH_RESPONSE} request.execute as l_response then
		print ("%NOk, let see what we get from response status...%N")
		io.put_new_line
		 -- Now we will parse the response body.
		if l_response.status = 200 and then attached l_response.body as l_body then
			print (l_body)
		else
			print ("%NResponse: STATUS:" + l_response.status.out)
		end
	end
```


