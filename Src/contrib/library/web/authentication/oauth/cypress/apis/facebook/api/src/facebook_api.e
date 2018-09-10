note
	description: "[
				Facebook API Interface: specify how to read and write Facebook data.
				]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Facebook Graph API", "src=http://developers.facebook.com/docs/api", "protocol=uri"

class
	FACEBOOK_API

create
	make

feature {NONE} -- Initialization

	make (a_access_token: READABLE_STRING_32)
		do
				-- Using access token access mode.
			access_token := a_access_token
		end

feature -- Reset

	reset
		do
			create access_token.make_empty
		end

feature -- Access

	access_token: STRING_32
			-- Twitter access token.

	http_status: INTEGER
		-- Contains the last HTTP status code returned.

	last_api_call: detachable STRING
		-- Contains the last API call.

	last_response: detachable OAUTH_RESPONSE
		-- Cointains the last API response.

feature -- Facebook: Extended Access Token

	extended_access_token (a_app_id: STRING; a_app_secret: STRING; a_short_token: STRING): detachable STRING
		local
			l_fb_api: OAUTH_20_FACEBOOK_API
			l_params: STRING_TABLE [STRING]
		do
			create l_fb_api
			create l_params.make (4)
			l_params.force ("fb_exchange_token", "grant_type")
			l_params.force (a_app_id, "client_id")
			l_params.force (a_app_secret, "client_secret")
			l_params.force (a_short_token, "fb_exchange_token")
			api_get_call (l_fb_api.access_token_endpoint, l_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Facebook: Get User

	show_user (a_user: READABLE_STRING_32; a_params: detachable FB_USER_PARAMETER): detachable STRING
		do
			if
				attached a_params and then
				attached a_params.parameters as l_parameters
			then
				api_get_call (facebook_url (a_user, l_parameters ), Void)
			else
				api_get_call (facebook_url (a_user, Void ), Void)
			end
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	user_friends (a_path: STRING; a_params: detachable FB_USER_PARAMETER): detachable STRING
		do
			if
				attached a_params and then
				attached a_params.parameters as l_parameters
			then
				api_get_call (facebook_url (a_path, l_parameters ), Void)
			else
				if a_path.starts_with ("https") then
					api_get_call (a_path, Void)
				else
					api_get_call (facebook_url (a_path, Void ), Void)
				end
			end
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	user_timeline_posts (a_path: STRING; a_params: detachable FB_POST_PARAMETER): detachable STRING
		do
			if
				attached a_params and then
				attached a_params.parameters as l_parameters
			then
				api_get_call (facebook_url (a_path, l_parameters ), Void)
			else
				if a_path.starts_with ("https") then
					api_get_call (a_path, Void)
				else
					api_get_call (facebook_url (a_path, Void ), Void)
				end
			end
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	user_likes (a_path: STRING; a_params: detachable FB_PAGE_PARAMETER): detachable STRING
		do
			if
				a_params /= Void and then
				attached a_params.parameters as l_parameters
			then
				api_get_call (facebook_url (a_path, l_parameters ), Void)
			else
				if a_path.starts_with ("https") then
					api_get_call (a_path, Void)
				else
					api_get_call (facebook_url (a_path, Void ), Void)
				end
			end
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	user_groups (a_path: STRING; a_params: detachable FB_GROUP_PARAMETER): detachable STRING
		do
			if
				attached a_params and then
				attached a_params.parameters as l_parameters
			then
				api_get_call (facebook_url (a_path, l_parameters ), Void)
			else
				if a_path.starts_with ("https") then
					api_get_call (a_path, Void)
				else
					api_get_call (facebook_url (a_path, Void ), Void)
				end
			end
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Feeds: publish, delete, update

	publish_on_user_feed (a_user_id: STRING; a_params: detachable FB_USER_FEED_PUBLISHING): detachable STRING
		do
			api_post_call (facebook_url (a_user_id, Void ), a_params, Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	delete_feed (a_post_id: STRING): detachable STRING
		do
			api_delete_call (facebook_url (a_post_id, Void ), Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	publish_photo_on_user_feed (a_user_id: STRING; a_photo: PATH; a_params: detachable FB_USER_FEED_PUBLISHING ): detachable STRING
		do
			api_post_call (facebook_url (a_user_id, Void ), a_params, [a_photo, "multipart/form-data"])

			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end


	publish_video_on_user_feed (a_user_id: STRING; a_video: PATH; a_params: detachable FB_VIDEO_PUBLISHING ): detachable STRING
		do
			api_post_call (facebook_video_url (a_user_id, Void ), a_params, [a_video, "multipart/form-data"])

			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Posts

	show_post (a_post_id: READABLE_STRING_32; a_params: detachable FB_POST_PARAMETER): detachable STRING
		do
			if
				attached a_params and then
				attached a_params.parameters as l_parameters
			then
				api_get_call (facebook_url (a_post_id, l_parameters ), Void)
			else
				api_get_call (facebook_url (a_post_id, Void ), Void)
			end
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Parameters Factory

	parameters (a_params: detachable STRING_TABLE [STRING] ): detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
		local
			l_result: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
			l_tuple : detachable TUPLE [name: STRING; value: STRING]
			i: INTEGER
		do
			if attached a_params then
				i := 1
				create l_result.make_filled (Void, 1, a_params.count)
				across a_params as ic
				loop
					create l_tuple.default_create
					l_tuple.put (ic.key, 1)
					l_tuple.put (ic.item, 2)
					l_result.force (l_tuple, i)
					i := i + 1
				end
				Result := l_result
			end
		end

feature -- Error Report

	has_error: BOOLEAN
			-- Last api call raise an error?
		do
			if attached last_response as l_response then
				Result := l_response.status /= 200
			else
				Result := False
			end
		end

	error_message: STRING
			-- Last api call error message.
		require
			has_error: has_error
		do
			if
				attached last_response as l_response
			then
				if
					attached l_response.error_message as l_error_message
				then
					Result := l_error_message
				else
					Result := l_response.status.out
				end
			else
				Result := "Unknown Error"
			end
		end

feature {NONE} -- Implementation

	api_post_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING]; a_upload_data: detachable TUPLE[data:PATH; content_type: STRING])
			-- POST REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "POST", a_params, a_upload_data)
		end

	api_delete_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING])
			-- DELETE REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "DELETE", a_params, Void)
		end

	api_get_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING])
			-- GET REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "GET", a_params, Void)
		end

	internal_api_call (a_api_url: STRING; a_method: STRING; a_params: detachable STRING_TABLE [STRING]; a_upload_data: detachable TUPLE[filename:PATH; content_type: STRING])
			-- Note at the moment we are using `user token` access mode.
		note
			EIS:"name=access token", "src=https://developers.facebook.com/docs/facebook-login/access-tokens", "protocol=uri"
		local
			request: OAUTH_REQUEST
			l_access_token: detachable OAUTH_TOKEN
			api_service: OAUTH_20_SERVICE
		do
				-- Initialization

			create api_service.make (create {OAUTH_20_FACEBOOK_API}, create {OAUTH_CONFIG}.make_default ("", ""))
				--| TODO improve cypress service creation procedure to make configuration optional.

			print ("%N===Facebook OAuth Workflow using OAuth access token for the owner of the application ===%N")
				--| TODO rewrite prints as logs

				-- Create the access token that will identifies the user making the request.
			create l_access_token.make_token_secret (access_token, "NOT_NEEDED")
				--| Todo improve access_token to create a token without a secret.

			if attached l_access_token as ll_access_token then
				print ("%NGot the Access Token!%N");

					--Now let's go and check if the request is signed correcty
				print ("%NNow we're going to verify our credentials...%N");
					-- Build the request and authorize it with OAuth.
				create request.make (a_method, a_api_url)
				upload_data (a_method, request, a_upload_data)
				add_parameters (a_method, request, a_params)
				api_service.sign_request (ll_access_token, request)
				if attached {OAUTH_RESPONSE} request.execute as l_response then
					last_response := l_response
				end
			end
			last_api_call := a_api_url.string
		end

	facebook_url (a_query: STRING; a_params: detachable STRING): STRING
			-- Facebook url for `a_query' and `a_parameters'
		require
			a_query_attached: a_query /= Void
		do
			Result := "https://graph.facebook.com/v2.9/" + a_query
			if attached a_params then
				Result.append_character ('?')
				Result.append (a_params)
			end
		ensure
			Result_attached: Result /= Void
		end

	facebook_video_url (a_query: STRING; a_params: detachable STRING): STRING
			-- Facebook url for `a_query' and `a_parameters'
		require
			a_query_attached: a_query /= Void
		do
			Result := "https://graph-video.facebook.com/v2.9/" + a_query
			if attached a_params then
				Result.append_character ('?')
				Result.append (a_params)
			end
		ensure
			Result_attached: Result /= Void
		end

	url (a_base_url: STRING; a_parameters: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]): STRING
			-- url for `a_base_url' and `a_parameters'
		require
			a_base_url_attached: a_base_url /= Void
		do
			create Result.make_from_string (a_base_url)
			append_parameters_to_url (Result, a_parameters)
		end

	append_parameters_to_url (a_url: STRING; a_parameters: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]])
			-- Append parameters `a_parameters' to `a_url'
		require
			a_url_attached: a_url /= Void
		local
			i: INTEGER
			l_first_param: BOOLEAN
		do
			if a_parameters /= Void and then a_parameters.count > 0 then
				if a_url.index_of ('?', 1) > 0 then
					l_first_param := False
				elseif a_url.index_of ('&', 1) > 0 then
					l_first_param := False
				else
					l_first_param := True
				end
				from
					i := a_parameters.lower
				until
					i > a_parameters.upper
				loop
					if attached a_parameters[i] as a_param then
						if l_first_param then
							a_url.append_character ('?')
						else
							a_url.append_character ('&')
						end
						a_url.append_string (a_param.name)
						a_url.append_character ('=')
						a_url.append_string (a_param.value)
						l_first_param := False
					end
					i := i + 1
				end
			end
		end

	add_parameters (a_method: STRING; request:OAUTH_REQUEST; a_params: detachable STRING_TABLE [STRING])
			-- add parameters 'a_params' (with key, value) to the oauth request 'request'.
			--| at the moment all params are added to the query_string.
		do
			add_query_parameters (request, a_params)
		end

	add_query_parameters (request:OAUTH_REQUEST; a_params: detachable STRING_TABLE [STRING])
		do
			if attached a_params then
				across a_params as ic
				loop
					request.add_query_string_parameter (ic.key.as_string_8, ic.item)
				end
			end
		end

	add_body_parameters (request:OAUTH_REQUEST; a_params: detachable STRING_TABLE [STRING])
		do
			if attached a_params then
				across a_params as ic
				loop
					request.add_body_parameter (ic.key.as_string_8, ic.item)
				end
			end
		end

	upload_data (a_method: STRING; request:OAUTH_REQUEST; a_upload_data: detachable TUPLE[file_name:PATH; content_type: STRING])
		local
			l_raw_file: RAW_FILE
		do
			if a_method.is_case_insensitive_equal_general ("POST") and then attached a_upload_data as l_upload_data then

				create l_raw_file.make_open_read (l_upload_data.file_name.absolute_path.name)
				if l_raw_file.exists then
					request.add_header ("Content-Type", l_upload_data.content_type)
					request.set_upload_filename (l_upload_data.file_name.absolute_path.name)
					request.add_form_parameter("source", l_upload_data.file_name.name.as_string_32)
				end
			end
		end

end

