# Twitter API Authentication 

There are two forms of authentication, both leveraging OAuth 1.0A
* User authentication
* Application-only authentication

To learn more read : https://dev.twitter.com/oauth


## Verifying Credentials
Every request sent to Twitter's API must be authorized. To learn more about how to authorize a request read: https://dev.twitter.com/oauth/overview/authorizing-requests. 
So we will need first to get an `OAuth access token` on behalf of a Twitter user (or, you could issue Application-only authenticated requests, when user context is not required). There are different options to get such token and it will depend on your use case. Here we will use `Just want to access the API from your own account...`	

### Example 

We will need to `register a new application` with Twitter, obtain a `consumer key` (identifies your app) and an `access token` (identifies a user of your app), and check to make sure that you are sending the values correctly.

Visit https://dev.twitter.com/apps and register a new application.

Check the following page https://dev.twitter.com/oauth/overview/application-owner-access-tokens
to create your Consumer Keys and your Access Token.

```
feature {NONE} -- Consumers Key

	api_key: STRING = $CONSUMER_KEY
			-- Consumer key
			--| The consumer key identifies the application making the request.

	api_secret: STRING = $CONSUMER_SECRET_KEY
			-- Consumer secret

feature {NONE} -- 	Access Key

	access_key: STRING = "ACCESS_KEY"
			-- The access token identifies the user making the request.

	access_secret: STRING = "ACCESS_SECRECT_KEY"
			-- Secret token
```

The goal of this example is to show you how to use `Cypress API` to verify your credentials with `Twitter API`.
Execute the example, and if the setup was done correctly, you will get a Response Status: 200 Ok.
You will see in the console something like this.
```
===Twitter OAuth Workflow using OAuth access token for the owner of the application ===

Get the request token

Got the Access Token!

Now we're going to verify our credentials...

Ok, let see what we get from response status...
Response: STATUS:200
Press Return to finish the execution...
```

