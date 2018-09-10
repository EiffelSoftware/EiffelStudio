note
	description: "test application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
--			test_fb_user_minimal
--			test_fb_user_with_all_basic_fields
--			test_fb_user_with_some_basic_fields
--			test_fb_user_friends
--			test_fb_user_friends_with_limits
--			test_fb_user_feed
--			test_fb_user_feed_and_delete
--			test_extended_token
--			test_user_time_line
--			test_fb_user_feed_with_link
--			test_fb_user_upload_photo
--			test_fb_user_upload_photo_with_params
--			test_fb_user_upload_video
--			test_fb_user_likes
--			test_fb_user_likes_with_params
			test_fb_user_groups
		end

feature -- Get FB User Details.

	test_fb_user_minimal
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			l_user := l_fb_api.user ("me", Void)
			if attached l_user then
				print (l_user.basic_out)
			end
		end

	test_fb_user_with_all_basic_fields
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params: FB_USER_PARAMETER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params
			l_params.include_all_basic
			l_user := l_fb_api.user ("me", l_params)
			if attached l_user then
				print (l_user.basic_out)
			end
		end

	test_fb_user_with_some_basic_fields
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params: FB_USER_PARAMETER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params
			l_params.include_birthday
			l_params.include_email
			l_user := l_fb_api.user ("me", l_params)
			if attached l_user then
				print (l_user.basic_out)
			end
		end


feature -- Test User Friends

	test_fb_user_friends
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params: FB_USER_PARAMETER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
		end

	test_fb_user_friends_with_limits
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params: FB_USER_PARAMETER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
		end

feature -- Test User Feed.

	test_fb_user_feed
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params:FB_USER_FEED_PUBLISHING
			l_id: STRING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params.make (1)
			l_params.include_message ("Test form EiffelFB API")
			l_id := l_fb_api.publish_status_on_user_feed ("me", l_params)
			if attached l_id then
				print ("fb.com/"+l_id)
			end
		end

	test_fb_user_feed_with_link
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params:FB_USER_FEED_PUBLISHING
			l_id: STRING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params.make (1)
			l_params.include_message ("Eiffel community site.")
			l_params.include_link ("https://www.eiffel.org")
			l_id := l_fb_api.publish_status_on_user_feed ("me", l_params)
			if attached l_id then
				print ("fb.com/"+l_id)
			end
		end

	test_fb_user_upload_photo
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_file: PATH
			l_id: STRING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_file.make_from_string ("ewf.jpg")
			l_id :=  l_fb_api.publish_photo_on_user_feed ("me", l_file, Void)
			if attached l_id then
				print ("fb.com/"+l_id)
			end
		end

	test_fb_user_upload_video
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_file: PATH
			l_id: STRING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_file.make_from_string ("video.mp4")
			l_id :=  l_fb_api.publish_video_on_user_feed ("me", l_file, Void)
			if attached l_id then
				print ("fb.com/"+l_id)
			end
		end

	test_fb_user_upload_photo_with_params
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_file: PATH
			l_id: STRING
			l_params: FB_USER_FEED_PUBLISHING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params.make (2)
			l_params.include_message ("EiffelWeb logo from Eiffel Facebook API")
			create l_file.make_from_string ("ewf.jpg")
			l_id :=  l_fb_api.publish_photo_on_user_feed ("me", l_file, l_params)
			if attached l_id then
				print ("fb.com/"+l_id)
			end
		end


	test_fb_user_feed_and_delete
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params:FB_USER_FEED_PUBLISHING
			l_id: STRING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params.make (1)
			l_params.include_message ("Test form EiffelFB API and then delete")
			l_id := l_fb_api.publish_status_on_user_feed ("me", l_params)
			if attached l_id then
				print (l_id)
				print (l_fb_api.delete_feed (l_id).out)
			end
		end

feature -- Test Extended Token

	test_extended_token
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params:FB_USER_FEED_PUBLISHING
			l_id: STRING
			l_access_token: FB_ACCESS_TOKEN
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			l_access_token := l_fb_api.extended_access_token (app_id, app_secret, access_token)
		end


feature -- Test User TimeLine

	test_user_time_line
		local
			l_fb_api: FACEBOOK_I
			l_post: FB_EDGES [FB_POST]
			l_page: INTEGER
			l_posts: INTEGER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			l_post := l_fb_api.user_feed ("me", Void)
			if attached l_post then
				if l_post.after then
					across l_post.data as ic loop
						print (ic.item.basic_out)
						l_posts := l_posts + 1
					end
				else
					from
						l_page := 1
						l_posts :=1
					until
						l_post.after
					loop
						across l_post.data as ic loop
							print (ic.item.basic_out)
							l_posts := l_posts + 1
						end
						l_post.forth
						l_page := l_page + 1
					end
					print ("%NNumber of Pages: " + l_page.out)
					print ("%NNumber of Posts: " + l_posts.out)
				end
			end
	end



	test_fb_user_likes
		local
			l_fb_api: FACEBOOK_I
			l_post: FB_EDGES [FB_PAGE]
			l_page: INTEGER
			l_posts: INTEGER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			l_post := l_fb_api.user_likes ("me", Void)
			if attached l_post then
				from
					l_page := 1
					l_posts :=1
				until
					l_post.after
				loop
					across l_post.data as ic loop
						print (ic.item.debug_output)
						l_posts := l_posts + 1
					end
					l_post.forth
					l_page := l_page + 1
				end
				print ("%NNumber of Pages: " + l_page.out)
				print ("%NNumber of Likes: " + l_posts.out)
			end
		end

	test_fb_user_likes_with_params
		local
			l_fb_api: FACEBOOK_I
			l_post: FB_EDGES [FB_PAGE]
			l_page: INTEGER
			l_posts: INTEGER
			l_params: FB_PAGE_PARAMETER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params
			l_params.include_about
			l_post := l_fb_api.user_likes ("me", l_params)
			if attached l_post then
				from
					l_page := 1
					l_posts :=1
				until
					l_post.after
				loop
					across l_post.data as ic loop
						print (ic.item.debug_output)
						l_posts := l_posts + 1
					end
					l_post.forth
					l_page := l_page + 1
				end
				print ("%NNumber of Pages: " + l_page.out)
				print ("%NNumber of Likes: " + l_posts.out)
			end
		end


	test_fb_user_groups
		local
			l_fb_api: FACEBOOK_I
			l_post: FB_EDGES [FB_GROUP]
			l_page: INTEGER
			l_posts: INTEGER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			l_post := l_fb_api.user_groups ("me", Void)
			if attached l_post then
				if l_post.after then
					across l_post.data as ic loop
						print (ic.item.debug_output)
						l_posts := l_posts + 1
					end
				else
					from
						l_page := 1
						l_posts :=1
					until
						l_post.after
					loop
						across l_post.data as ic loop
							print (ic.item.debug_output)
							l_posts := l_posts + 1
						end
						l_post.forth
						l_page := l_page + 1
					end
					print ("%NNumber of Pages: " + l_page.out)
					print ("%NNumber of Groups: " + l_posts.out)
				end
			end
		end


feature -- Implementation

	access_token: STRING = "YOUR_ACCESS_TOKEN"
			-- Facebook access user token.
			-- Get your access token from the FB Explorer: https://developers.facebook.com/docs/facebook-login/access-tokens/expiration-and-extension

	app_id: STRING = ""
			-- Facebook app client id token.

	app_secret: STRING = ""
			-- Facebook app client secret token.
			-- Get your API's id and secret token from: https://developers.facebook.com/apps/



end
