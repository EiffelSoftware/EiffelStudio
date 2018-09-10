note
	description: "[
				Facebook API Interface: specify how to read and write Facebook data.
				]"
	date: "$Date$"
	revision: "$Revision$"
    EIS: "name=Facebook Graph API", "src=http://developers.facebook.com/docs/api", "protocol=uri"

deferred class
	FACEBOOK_I

feature {NONE} -- Initialization

		-- TODO check the different types of
		-- FB access tokens
		-- https://developers.facebook.com/docs/facebook-login/access-tokens
		-- At the moment using https://developers.facebook.com/docs/facebook-login/access-tokens#usertokens
	make (a_access_token: READABLE_STRING_32)
		deferred
		end

feature -- Status Report

	last_status_code: INTEGER
			-- Return the HTTP status code from the last request.
		deferred
		end

feature --Facebook Access Token

	extended_access_token (a_app_id: STRING; a_app_secret: STRING; a_short_token: STRING): detachable FB_ACCESS_TOKEN
			-- https://developers.facebook.com/docs/facebook-login/access-tokens/#usertokens
			-- GET /oauth/access_token?client_id={app-id}&client_secret={app-secret}&grant_type=client_credentials
		deferred
		end

feature --Get - User

	user (a_user_id: STRING; a_params: detachable FB_USER_PARAMETER): detachable FB_USER
			-- Show a single user node `a_user_id', with optional parameters. `a_params'.
			-- GET /{a_user_id}
		note
			EIS: "name=User", "src=https://developers.facebook.com/docs/graph-api/reference/user", "protocol=uri"
		deferred
		end

	user_feed (a_user_id: STRING; a_params: detachable FB_POST_PARAMETER): detachable FB_EDGES [FB_POST]
			-- The feed of posts (including status updates) and links published by this person.
			-- GET /{a_user_id}/feed
		note
			EIS: "name=Feed", "src=https://developers.facebook.com/docs/graph-api/reference/user/feed", "protocol=uri"
		deferred
		end

	user_friends (a_user_id: STRING; a_params: detachable FB_USER_PARAMETER): detachable FB_EDGES [FB_USER]
			-- A person's friends.
			-- GET {user-id}/friends
		note
			EIS: "name=Friends", "src=https://developers.facebook.com/docs/graph-api/reference/user/friends", "protocol=uri"
		deferred
		end

	user_likes (a_user_id: STRING; a_params: detachable FB_PAGE_PARAMETER): detachable FB_EDGES [FB_PAGE]
			-- All the Pages this person has liked
			-- GET /{user_id}/likes	
		note
			EIS: "name=User likes", "src=https://developers.facebook.com/docs/graph-api/reference/user/likes/", "protocol=uri"
		deferred
		end

	user_groups (a_user_id: STRING; a_params: detachable FB_GROUP_PARAMETER): detachable FB_EDGES [FB_GROUP]
			-- The Facebook Groups that the person is an admin of
			-- GET /{user_id}/groups	
		note
			EIS: "name=User Groups", "src=https://developers.facebook.com/docs/graph-api/reference/user/groups/", "protocol=uri"
		deferred
		end

feature	-- Post

	post (a_post_id: READABLE_STRING_32; a_params: detachable FB_POST_PARAMETER): detachable FB_POST
			-- An individual entry in a profile's feed. The profile could be a user, page, app, or group.
			-- GET /{a_post_id}
		note
			EIS:"name=Post", "src=https://developers.facebook.com/docs/graph-api/reference/v2.9/post", "protocol=uri"
		deferred
		end

feature -- Feed: Publish, Delete

	publish_status_on_user_feed (a_user_id: STRING; a_params: detachable FB_USER_FEED_PUBLISHING): detachable STRING
			-- Publish status to timeline using params `a_params'.
			-- POST /{a_user_id}/feed
			--Permissions
			--A user access token with publish_actions permission can be used to publish new posts.
		note
			EIS: "name=Publish", "src=https://developers.facebook.com/docs/graph-api/reference/v2.9/user/feed#publish", "protocol=uri"
		deferred
		end

	publish_photo_on_user_feed (a_user_id: STRING; a_photo: PATH; a_params: detachable FB_USER_FEED_PUBLISHING): detachable STRING
			-- Uploading a photo to the user `a_user_id' timeline.
			-- Attach the photo `a_potho' as multipart/form-data.
			-- POST /{a_user_id}/photo
		note
			EIS: "name=Publish Photo", "src=https://developers.facebook.com/docs/graph-api/reference/user/photos/#Creating", "protocol=uri"
		deferred
		end

	publish_video_on_user_feed (a_user_id: STRING; a_video: PATH; a_params: detachable FB_VIDEO_PUBLISHING): detachable STRING
			-- Uploading a video to the user `a_user_id' timeline.
			-- Attach the video `a_video' as multipart/form-data.
			-- POST /{a_user_id}/videos
		note
			EIS: "name=Publish Video", "src=https://developers.facebook.com/docs/graph-api/reference/user/videos/#Creating", "protocol=uri"
		deferred
		end

	delete_feed (a_post_id: STRING): BOOLEAN
		deferred
		end



end
