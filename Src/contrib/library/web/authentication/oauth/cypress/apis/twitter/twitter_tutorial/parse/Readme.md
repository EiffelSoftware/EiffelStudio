# Parse JSON Response
In the previous tutorial we saw how to verify our credentials, because every request sent to Twitter's API must be authorized.
In this example we will parse the response in JSON format, we will use the JSON library. To learn more check the following link:https://github.com/eiffelhub/json/wiki/User-guide 

## Resource URL
		https://api.twitter.com/1.1/account/verify_credentials.json
Returns an HTTP 200 OK response code and a representation of the requesting user if authentication was successful; returns a 401 status code and an error message if not. 
Use this method to test if supplied user credentials are valid.		

Check documentation for deails here: https://dev.twitter.com/rest/reference/get/account/verify_credentials

## Example

In this example we will parse the JSON response and we will create a new object `user` instance of `TWITTER_USER` class.
First we will check that the Status code is 200, so we know everything is Ok and we have a response body, in other case we show the response status code.

The following snippet code, shows how we do that after we got the Twitter's response, the `l_body` have the JSON response from twitter.
Finally we print out the current user's details and other useful information.


```
	if l_response.status = 200 and then attached l_response.body as l_body then
		if attached {TWITTER_USER} (create {TWITTER_JSON}).verify_credentials (l_body) as l_user then
			print (l_user.full_out)
			if attached l_user.status as l_status then
				print (l_status.full_out)
			end
		else
			print ("%N Reponse: could not parse the response:" + l_body)
		end	
	else
		print ("%NResponse: STATUS:" + l_response.status.out)
	end

```

If the feature `{TWITTER_JSON}).verify_credentials (l_body) ` can't parse the body, it will raise an error. 
The following piece of code show how we parse a string and reutrn a JSON_VALUE.

```
	parsed_json (a_json_text: STRING): detachable JSON_VALUE
			-- Parse 'a_json_text' and rerutn a JSON_VALE or Void.
		local
			j: JSON_PARSER
		do
			create j.make_with_string (a_json_text)
			j.parse_content
			Result := j.parsed_json_value
			last_json := Result
		end
```



