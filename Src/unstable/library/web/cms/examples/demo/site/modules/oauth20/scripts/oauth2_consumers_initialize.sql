	-- Change the values TO_COMPLETE based on your API.
	-- API SECTET KEY AND API PUBLIC KEY 
INSERT INTO oauth2_consumers (name, api_secret, api_key, scope, protected_resource_url, callback_name, extractor, authorize_url, endpoint) 
VALUES ('google', 'TO-COMPLETE', 'TO-COMPLETE', 'email', 'https://www.googleapis.com/plus/v1/people/me', 'callback_google', 'json','https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI','https://accounts.google.com/o/oauth2/token');

INSERT INTO oauth2_consumers (name, api_secret, api_key, scope, protected_resource_url, callback_name, extractor, authorize_url, endpoint ) 
VALUES ('facebook', 'TO-COMPLETE', 'TO-COMPLETE', 'email', 'https://graph.facebook.com/me', 'callback_facebook','text','https://www.facebook.com/dialog/oauth?response_type=code&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI','https://graph.facebook.com/oauth/access_token');
