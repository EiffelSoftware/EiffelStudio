note
	description: "Summary description for {TWITTER_JSON}."
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_JSON

inherit

	TWITTER_I
		redefine
			default_create
		select
			default_create
		end

	REFACTORING_HELPER
		rename
			default_create as  default_rh
		end

create
	default_create,
	make,
	make_with_source


feature {NONE} -- Initialization

	default_create
		do
			create twitter_api.make (create {TWITTER_CONSUMER_TOKEN}.make (Void, Void), create {TWITTER_ACCESS_TOKEN}.make (Void, Void))
		end

	make (a_consumer_key: TWITTER_CONSUMER_TOKEN; a_access_key: TWITTER_ACCESS_TOKEN)
		do
			create twitter_api.make (a_consumer_key, a_access_key)
		end

	make_with_source (a_consumer_key: TWITTER_CONSUMER_TOKEN; a_access_key: TWITTER_ACCESS_TOKEN; a_source: STRING)
		do
			make (a_consumer_key,a_access_key)
			twitter_api.set_appication_source (a_source)
		end

feature -- Status Report

	last_status_code: INTEGER
			-- <Precuror>
		do
			if attached twitter_api.last_response as l_response then
				Result := l_response.status
			end
		end

feature -- Twitter: GET- Account Methods

	home_timeline (a_params: detachable TWITTER_HOME_TIMELINE_PARAMS): detachable LIST [TWITTER_TWEETS]
			-- <Precursor>.
		local
			i: INTEGER
		do
			if attached twitter_api.home_timeline (a_params) as s then
				if attached parsed_json (s) as j then
					if attached {JSON_ARRAY} j as l_array then
						from
							create {ARRAYED_LIST [TWITTER_TWEETS]} Result.make (l_array.count)
							i := 1
						until
							i > l_array.count
						loop
							Result.force (twitter_tweets (Void, l_array.i_th (i)))
							i := i + 1
						end
					end
				end
			end
		end

	user_timeline (a_params: detachable TWITTER_USER_TIMELINE_PARAMS): detachable LIST [TWITTER_TWEETS]
			-- <Precursor>
		local
			i: INTEGER
		do
			if attached twitter_api.user_timeline (a_params) as s then
				if attached parsed_json (s) as j then
					if attached {JSON_ARRAY} j as l_array then
						from
							create {ARRAYED_LIST [TWITTER_TWEETS]} Result.make (l_array.count)
							i := 1
						until
							i > l_array.count
						loop
							Result.force (twitter_tweets (Void, l_array.i_th (i)))
							i := i + 1
						end
					end
				end
			end
		end

	mentions_timeline (a_params: detachable TWITTER_MENTIONS_TIMELINE_PARAMS): detachable LIST [TWITTER_TWEETS]
			-- <Precursor>.
		local
			i: INTEGER
		do
			if attached twitter_api.mentions_timeline (a_params) as s then
				if attached parsed_json (s) as j then
					if attached {JSON_ARRAY} j as l_array then
						from
							create {ARRAYED_LIST [TWITTER_TWEETS]} Result.make (l_array.count)
							i := 1
						until
							i > l_array.count
						loop
							Result.force (twitter_tweets (Void, l_array.i_th (i)))
							i := i + 1
						end
					end
				end
			end
		end

	show_tweet (a_params: TWITTER_STATUS_SHOW_PARAMS): detachable TWITTER_TWEETS
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached twitter_api.show_tweet (a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := twitter_tweets (Void, j)
					end
				end
			end
		end

	retweets_of_me (a_params: detachable TWITTER_RETWEET_OF_ME_PARAMS): detachable LIST [TWITTER_TWEETS]
			-- <Precursor>.
		local
			i: INTEGER
		do
			if attached twitter_api.retweets_of_me (a_params) as s then
				if attached parsed_json (s) as j then
					if attached {JSON_ARRAY} j as l_array then
						from
							create {ARRAYED_LIST [TWITTER_TWEETS]} Result.make (l_array.count)
							i := 1
						until
							i > l_array.count
						loop
							Result.force (twitter_tweets (Void, l_array.i_th (i)))
							i := i + 1
						end
					end
				end
			end
		end

	retweeters (a_params: detachable TWITTER_RETWEETERS_PARAMS): detachable LIST [STRING]
			-- <Precursor>
		do
			to_implement ("Check if we need a LIST [TWEETER_ID]")
				-- A object TWEETER_ID will have the id
				-- represented as INTEGER AND STRING.
		end

feature -- POST - Account Methods

	tweet (a_params: TWITTER_STATUS_UPDATE_PARAMS): detachable TWITTER_TWEETS
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached twitter_api.tweet (a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := twitter_tweets (Void, j)
					end
				end
			end
		end


feature -- Twitter: Account Methods

	verify_credentials (a_params: detachable TWITTER_VERIFY_CREDENTIALS_PARAMS): detachable TWITTER_USER
			-- Returns anrepresentation of the requesting user if authentication was successful
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached twitter_api.verify_credentials (a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := twitter_user (Void, j)
					end
				else
					print (s)
				end
			end
		end


feature -- Twitter Application

	rate_limit_status (a_params: detachable TWITTER_RATE_LIMIT_PARAMS): detachable TWITTER_RATE_LIMIT_CONTEXT
			-- <Precursor>
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached twitter_api.rate_limit_status (a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := twitter_rate_limit (j)
					end
				else
					print (s)
				end
			end
		end

feature -- Twitter Direct Message

	direct_messages (a_params: detachable TWITTER_DIRECT_MESSAGE_PARAMS ): detachable LIST [TWITTER_TWEETS]
			-- <Precursor>
		local
			i: INTEGER
		do
			if attached twitter_api.direct_messages (a_params) as s then
				if attached parsed_json (s) as j then
					if attached {JSON_ARRAY} j as l_array then
						from
							create {ARRAYED_LIST [TWITTER_TWEETS]} Result.make (l_array.count)
							i := 1
						until
							i > l_array.count
						loop
							Result.force (twitter_tweets (Void, l_array.i_th (i)))
							i := i + 1
						end
					end
				end
			end
		end


feature -- Implementation Factory: Twitter Objects


	twitter_tweets (a_tweet: detachable like twitter_tweets; a_json: JSON_VALUE): TWITTER_TWEETS
			-- Fill `a_tweet' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
			l_countries: LIST [STRING]
		do
			if a_tweet /= Void then
				Result := a_tweet
			else
				create Result
			end
			Result.set_created_at (string_value_from_json (a_json, "created_at"))
			Result.set_text (string_value_from_json (a_json, "text"))
			if attached {JSON_OBJECT} json_value (a_json, "user") as l_user then
				Result.set_user (twitter_user (Void, l_user))
			end
			if attached {JSON_OBJECT} json_value (a_json, "coordinates") as l_coordinates then
				Result.set_coordinates (twitter_coordinates (Void, l_coordinates))
			end

			if attached {JSON_OBJECT} json_value (a_json, "entities") as l_entities then
				Result.set_entities (twitter_entities (Void, l_entities))
			end

			Result.set_favorite_count (integer_value_from_json (a_json, "favorite_count"))
			Result.set_favorited (boolean_value_from_json (a_json, "favorited"))
			Result.set_filter_level (string_value_from_json (a_json, "filter_level"))
			Result.set_id (integer_64_value_from_json (a_json, "id"))
			Result.set_id_str (string_value_from_json (a_json, "id_str"))
			Result.set_in_reply_to_screen_name (string_value_from_json (a_json, "in_reply_to_screen_name"))
			Result.set_in_reply_to_status_id (integer_64_value_from_json (a_json, "in_reply_to_status_id"))
			Result.set_in_reply_to_status_id_str (string_value_from_json (a_json, "in_reply_to_status_id_str"))
			Result.set_in_reply_to_user_id (integer_64_value_from_json (a_json, "in_reply_to_user_id"))
			Result.set_in_reply_to_user_id_str (string_value_from_json (a_json, "in_reply_to_user_id_str"))
			Result.set_lang (string_value_from_json (a_json, "lang"))

			if attached {JSON_OBJECT} json_value (a_json, "place") as l_place then
				Result.set_place (twitter_places (Void, l_place))
			end

			Result.set_possibly_sensitive (boolean_value_from_json (a_json, "possibly_sensitive"))
			Result.set_quoted_status_id (integer_64_value_from_json (a_json, "quoted_status_id"))
			Result.set_quoted_status_id_str (string_value_from_json (a_json, "quoted_status_id_str"))

			if attached {JSON_OBJECT} json_value (a_json, "quoted_status") as l_quoted_status then
				Result.set_quoted_status (twitter_tweets (Void, l_quoted_status))
			end

			Result.set_retweet_count (integer_value_from_json (a_json, "retweet_count"))
			Result.set_retweeted (boolean_value_from_json (a_json, "retweeted"))

			if attached {JSON_OBJECT} json_value (a_json, "retweeted_status") as l_retweeted_status then
				Result.set_retweeted_status (twitter_tweets (Void, l_retweeted_status))
			end

			Result.set_source (string_value_from_json (a_json, "source"))
			Result.set_truncated (boolean_value_from_json (a_json, "truncated"))
			Result.set_withheld_copyright (boolean_value_from_json (a_json, "withheld_copyright"))
			if attached {JSON_ARRAY} json_value (a_json, "withheld_in_countries") as l_withheld_in_countries then
				create {ARRAYED_LIST [STRING]} l_countries.make (2)
				across l_withheld_in_countries.array_representation as ic loop
					if attached {JSON_STRING} ic.item as l_value then
						l_countries.force (l_value.item)
					end
				end
				Result.set_withheld_in_countries (l_countries)
			end

			Result.set_withheld_scope (string_value_from_json (a_json, "withheld_scope"))

		end


	twitter_user (a_user: detachable like twitter_user; a_json: JSON_VALUE): TWITTER_USER
			-- Fill `a_user' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_user /= Void then
				Result := a_user
			else
				create Result
			end
			Result.set_id (integer_64_value_from_json (a_json, "id"))
			Result.set_created_at (string_value_from_json (a_json, "created_at"))
			Result.set_name (string_value_from_json (a_json, "name"))
			Result.set_screen_name (string_value_from_json (a_json, "screen_name"))
			if attached string_value_from_json (a_json, "location") as s then
				Result.set_location (stripslashes (s))
			else
				Result.set_location (Void)
			end
			Result.set_description (string32_value_from_json (a_json, "description"))
			Result.set_profile_image_url (string_value_from_json (a_json, "profile_image_url"))
			Result.set_url (string_value_from_json (a_json, "url"))
			Result.set_protected (boolean_value_from_json (a_json, "protected"))
			Result.set_followers_count (integer_value_from_json (a_json, "followers_count"))

			if attached {JSON_OBJECT} json_value (a_json, "status") as l_status then
				Result.set_status (twitter_tweets (Void, l_status))
			end

			Result.set_contributors_enabled (boolean_value_from_json (a_json, "contributors_enabled"))
			Result.set_default_profile (boolean_value_from_json (a_json, "default_profile"))
			Result.set_default_profile_image (boolean_value_from_json (a_json, "default_profile_image"))

			if attached {JSON_OBJECT} json_value (a_json, "entities") as l_entities then
				Result.set_entities (twitter_entities (Void, l_entities))
			end

			Result.set_friends_count (integer_value_from_json (a_json, "friends_count"))
			Result.set_geo_enabled (boolean_value_from_json (a_json, "geo_enabled"))
			Result.set_id_str (string_value_from_json (a_json, "id_str"))
			Result.set_is_translator (boolean_value_from_json (a_json, "is_translator"))
			Result.set_lang (string_value_from_json (a_json, "lang"))
			Result.set_listed_count (integer_value_from_json (a_json, "listed_count"))
			Result.set_profile_background_color (string_value_from_json (a_json, "profile_background_color"))
			Result.set_profile_background_image_url (string_value_from_json (a_json, "profile_background_image_url"))
			Result.set_profile_background_image_url_https (string_value_from_json (a_json, "profile_background_image_url_https"))
			Result.set_profile_background_tile (boolean_value_from_json (a_json, "profile_background_tile"))
			Result.set_profile_banner_url (string_value_from_json (a_json, "profile_banner_url"))
			Result.set_profile_image_url_https (string_value_from_json (a_json, "profile_image_url_https"))
			Result.set_profile_link_color (string_value_from_json (a_json, "profile_link_color"))
			Result.set_profile_sidebar_border_color (string_value_from_json (a_json, "profile_sidebar_border_color"))
			Result.set_profile_sidebar_fill_color (string_value_from_json (a_json, "profile_sidebar_fill_color"))
			Result.set_profile_text_color (string_value_from_json (a_json, "profile_text_color"))
			Result.set_profile_use_background_image (boolean_value_from_json (a_json, "profile_use_background_image"))
			Result.set_statuses_count (integer_value_from_json (a_json, "statuses_count"))
			Result.set_time_zone (string_value_from_json (a_json, "time_zone"))
			Result.set_utc_offset (integer_value_from_json (a_json, "utc_offset"))
			Result.set_verified (boolean_value_from_json (a_json, "verified"))
			Result.set_withheld_in_countries (string_value_from_json (a_json, "withheld_in_countries"))
			Result.set_withheld_scope (string_value_from_json (a_json, "withheld_scope"))
		end


	twitter_places (a_place: detachable like twitter_places; a_json: JSON_VALUE): TWITTER_PLACES
			-- Fill `a_place' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_place /= Void then
				Result := a_place
			else
				create Result
			end
			Result.set_url (string_value_from_json (a_json, "url"))
			Result.set_place_type (string_value_from_json (a_json, "place_type"))
			Result.set_name (string_value_from_json (a_json, "name"))
			Result.set_id (string_value_from_json (a_json, "id"))
			Result.set_full_name (string_value_from_json (a_json, "full_name"))
			Result.set_country_code (string_value_from_json (a_json, "country_code"))
			Result.set_country (string_value_from_json (a_json, "country"))

			if attached {JSON_OBJECT} json_value (a_json, "bounding_box") as l_bounding_box then
				Result.set_bounding_box (twitter_bounding_box (Void, l_bounding_box))
			end
			if attached {JSON_OBJECT} json_value (a_json, "attributes") as l_attributes then
				Result.set_attributes (twitter_place_attributes (Void, l_attributes))
			end
		end

	twitter_place_attributes (a_place_attributes: detachable like twitter_place_attributes; a_json: JSON_VALUE): TWITTER_PLACE_ATTRIBUTES
			-- Fill `a_place_attributes' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_place_attributes /= Void then
				Result := a_place_attributes
			else
				create Result.make (1)
			end
			if attached {JSON_OBJECT} json_value (a_json, "attributes") as l_coordinates_json then
				across l_coordinates_json as ic
				loop
					if
						attached {JSON_STRING} ic.item as l_item and then
						attached {JSON_STRING} ic.key as l_key
					then
						Result.force (l_item.item, l_key.item)
					end
				end
			end
		end

	twitter_entities (a_entities: detachable like twitter_entities; a_json: JSON_VALUE): TWITTER_ENTITIES
			-- Fill `a_place_attributes' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
			l_symbols: LIST [TWITTER_SYMBOLS_ENTITY]
			l_hashtags: LIST [TWITTER_HASHTAGS_ENTITY]
			l_media: LIST [TWITTER_MEDIA_ENTITY]
			l_urls: LIST [TWITTER_URLS_ENTITY]
			l_user_mentions: LIST [TWITTER_USER_MENTIONS_ENTITY]
		do
			if a_entities /= Void then
				Result := a_entities
			else
				create Result
			end
			if attached {JSON_ARRAY} json_value (a_json, "symbols") as ll_symbols then
				create {ARRAYED_LIST[TWITTER_SYMBOLS_ENTITY]}l_symbols.make (1)
				across ll_symbols as ic loop
					l_symbols.force (twitter_symbols_entities (Void, ic.item))
				end
				Result.set_symbols (l_symbols)
			end
			if attached {JSON_ARRAY} json_value (a_json, "hashtags") as ll_hashtags then
				create {ARRAYED_LIST[TWITTER_HASHTAGS_ENTITY]}l_hashtags.make (1)
				across ll_hashtags as ic loop
					l_hashtags.force (twitter_hashtags_entities (Void, ic.item))
				end
				Result.set_hashtags (l_hashtags)
			end
			if attached {JSON_ARRAY} json_value (a_json, "media") as ll_media then
				create {ARRAYED_LIST[TWITTER_MEDIA_ENTITY]}l_media.make (1)
				across ll_media as ic loop
					l_media.force (twitter_media_entities (Void, ic.item))
				end
				Result.set_media (l_media)
			end
			if attached {JSON_ARRAY} json_value (a_json, "urls") as ll_urls then
				create {ARRAYED_LIST[TWITTER_URLS_ENTITY]}l_urls.make (1)
				across ll_urls as ic loop
					l_urls.force (twitter_url_entities (Void, ic.item))
				end
				Result.set_urls (l_urls)
			end
			if attached {JSON_ARRAY} json_value (a_json, "user_mentions") as ll_user_mentions then
				create {ARRAYED_LIST[TWITTER_USER_MENTIONS_ENTITY]}l_user_mentions.make (1)
				across ll_user_mentions as ic loop
					l_user_mentions.force (twitter_user_mentions_entities (Void, ic.item))
				end
				Result.set_user_mentions (l_user_mentions)
			end

		end

	twitter_coordinates (a_coordinates: detachable like twitter_coordinates; a_json: JSON_VALUE): TWITTER_COORDINATES
			-- Fill `a_coordinates' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
			l_array: LIST [REAL]
		do
			if a_coordinates /= Void then
				Result := a_coordinates
			else
				create Result
			end
			Result.set_type (string_value_from_json (a_json, "type"))
			if attached {JSON_ARRAY} json_value (a_json, "coordinates") as l_coordinates then
				create {ARRAYED_LIST [REAL]} l_array.make (0)
				across l_coordinates as ic  loop  -- array 1
					if
						attached {JSON_NUMBER} ic.item as v and then
						v.numeric_type = v.real_type
					then
						l_array.force (v.item.to_real)
					end
				end
				Result.set_coordinates (l_array)
			end

		end

	twitter_bounding_box (a_bounding_box: detachable like twitter_bounding_box; a_json: JSON_VALUE): TWITTER_BOUNDING_BOX
			-- Fill `a_bounding_box' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
			l_array: LIST [LIST [LIST [REAL]]]
			l_array_1: LIST [LIST [REAL]]
			l_array_2: LIST [REAL]
		do
			if a_bounding_box /= Void then
				Result := a_bounding_box
			else
				create Result
			end
			Result.set_type (string_value_from_json (a_json, "type"))
			if attached {JSON_ARRAY} json_value (a_json, "coordinates") as l_sizes then
				create {ARRAYED_LIST [ARRAYED_LIST [ARRAYED_LIST [REAL]]]} l_array.make (0)
				across l_sizes as ic  loop  -- array 1
					create {ARRAYED_LIST [ARRAYED_LIST [REAL]]} l_array_1.make (0)
					if attached {JSON_ARRAY} ic.item  as ll_array_1 then
						across ll_array_1 as  ic2 loop   -- array 2
							create {ARRAYED_LIST [REAL]} l_array_2.make (2)
							if attached {JSON_ARRAY} ic2.item as ll_array_2 then
								across ll_array_2 as ic3 loop   -- array 3
  									if attached {JSON_NUMBER} ic3.item as v and then
										v.numeric_type = v.real_type then
										l_array_2.force (v.item.to_real)
									end
								end
							end
							l_array_1.force (l_array_2)
						end
					end
					l_array.force (l_array_1)
				end
				Result.set_coordinates (l_array)
			end
		end

feature -- Implementation Factory: Twittter Rate Limit

	twitter_rate_limit (a_json: JSON_VALUE): TWITTER_RATE_LIMIT_CONTEXT
			-- Fill rate limit object fron `json'.
		local
			l_resources: STRING_TABLE [ LIST [STRING_TABLE [TUPLE [limit: INTEGER; remaining: INTEGER; reset: INTEGER ]]]]
			l_list: ARRAYED_LIST [STRING_TABLE [TUPLE [limit: INTEGER; remaining: INTEGER; reset: INTEGER ]]]
			l_table: STRING_TABLE [TUPLE [limit: INTEGER; remaining: INTEGER; reset: INTEGER ]]
			l_tuple: TUPLE [limit: INTEGER; remaining: INTEGER; reset: INTEGER ]
		do
			create Result
			if attached {JSON_OBJECT} json_value (a_json, "rate_limit_context") as l_rate_limit_context then
				Result.set_access_token (string_value_from_json (l_rate_limit_context, "access_token"))
			end

			if attached {JSON_OBJECT} json_value (a_json, "resources") as j_resources then
				create l_resources.make (1)
				across j_resources as ic loop
					create l_list.make (1)
					if
						attached {JSON_STRING} ic.key as l_key_1 and then
						attached {JSON_OBJECT} json_value (j_resources, l_key_1.item) as j_item
					then
						create l_table.make (1)
						across j_item as ic2 loop
							if
								attached {JSON_STRING} ic2.key as l_key_2 and then
								attached {JSON_OBJECT} json_value (j_item, l_key_2.item) as j_item_2
									-- TODO fix issues with keys like "\/lists\/list"
							then
								if
									attached integer_value_from_json (j_item_2, "limit") as l_limit and then
									attached integer_value_from_json (j_item_2, "remaining") as l_remaining and then
									attached integer_value_from_json (j_item_2, "reset") as l_reset
								then
									l_tuple := [l_limit, l_remaining, l_reset]
									l_table.force (l_tuple, l_key_2.item)
								end
							end
						end
						l_list.force (l_table)
						l_resources.force (l_list, l_key_1.item)
					end
				end
				Result.set_resources (l_resources)
			end
		end

feature -- Implementation Factory: Twitter: Entities

	twitter_extended_entities (a_extended_entities: detachable like twitter_extended_entities; a_json: JSON_VALUE): TWITTER_EXTENDED_ENTITIES
			-- Fill `a_extended_entities' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_extended_entities /= Void then
				Result := a_extended_entities
			else
				create Result
			end
			Result.set_display_url (string_value_from_json (a_json, "display_url"))
			Result.set_expanded_url (string_value_from_json (a_json, "expanded_url"))
			Result.set_id (integer_64_value_from_json (a_json, "id"))
			Result.set_id_str (string_value_from_json (a_json, "id_str"))
			Result.set_indices (integer_tuple_value_from_json (a_json, "indices"))
			Result.set_media_url (string_value_from_json (a_json, "media_url"))
			Result.set_media_url_https (string_value_from_json (a_json, "media_url_https"))
			if attached {JSON_OBJECT} json_value (a_json, "sizes") as l_sizes then
				Result.set_sizes (twitter_sizes_entities (Void, l_sizes))
			end
			Result.set_type (string_value_from_json (a_json, "type"))
			Result.set_url (string_value_from_json (a_json, "url"))
			if attached {JSON_OBJECT} json_value (a_json, "video_info") as l_video_info then
				Result.set_video_info (twitter_video_info_entities (Void, l_video_info))
			end
		end

	twitter_hashtags_entities (a_hashtags_entities: detachable like twitter_hashtags_entities; a_json: JSON_VALUE): TWITTER_HASHTAGS_ENTITY
			-- Fill `a_hashtags_entities' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_hashtags_entities /= Void then
				Result := a_hashtags_entities
			else
				create Result
			end
			Result.set_indices (integer_tuple_value_from_json (a_json, "indices"))
			Result.set_text (string_value_from_json (a_json, "text"))
		end

	twitter_media_entities (a_media_entities: detachable like twitter_media_entities; a_json: JSON_VALUE): TWITTER_MEDIA_ENTITY
			-- Fill `a_media_entities' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_media_entities /= Void then
				Result := a_media_entities
			else
				create Result
			end
			Result.set_display_url (string_value_from_json (a_json, "display_url"))
			Result.set_expanded_url (string_value_from_json (a_json, "expanded_url"))
			Result.set_id (integer_64_value_from_json (a_json, "id"))
			Result.set_id_str (string_value_from_json (a_json, "id_str"))
			Result.set_indices (integer_tuple_value_from_json (a_json, "indices"))
			Result.set_media_url (string_value_from_json (a_json, "media_url"))
			Result.set_media_url_https (string_value_from_json (a_json, "media_url_https"))
			if attached {JSON_OBJECT} json_value (a_json, "sizes") as l_sizes then
				Result.set_sizes (twitter_sizes_entities (Void, l_sizes))
			end
			Result.set_type (string_value_from_json (a_json, "type"))
			Result.set_url (string_value_from_json (a_json, "url"))

		end

	twitter_sizes_entities (a_sizes_entities: detachable like twitter_sizes_entities; a_json: JSON_VALUE): TWITTER_SIZES_ENTITY
			-- Fill `a_sizes_entities' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_sizes_entities /= Void then
				Result := a_sizes_entities
			else
				create Result
			end
			if attached {JSON_OBJECT} json_value (a_json, "medium") as l_medium then
				Result.set_medium (twitter_size_entities (Void, l_medium))
			end
			if attached {JSON_OBJECT} json_value (a_json, "large") as l_large then
				Result.set_large (twitter_size_entities (Void, l_large))
			end
			if attached {JSON_OBJECT} json_value (a_json, "thumb") as l_thumb then
				Result.set_thumb (twitter_size_entities (Void, l_thumb))
			end
			if attached {JSON_OBJECT} json_value (a_json, "small") as l_small then
				Result.set_small (twitter_size_entities (Void, l_small))
			end
		end

	twitter_size_entities (a_size_entities: detachable like twitter_size_entities; a_json: JSON_VALUE): TWITTER_SIZE_ENTITY
			-- Fill `a_size_entities' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_size_entities /= Void then
				Result := a_size_entities
			else
				create Result
			end
			Result.set_height (integer_value_from_json (a_json, "h"))
			Result.set_resize (string_value_from_json (a_json, "resize"))
			Result.set_width (integer_value_from_json (a_json, "w"))
		end

	twitter_symbols_entities (a_symbol_entities: detachable like twitter_symbols_entities; a_json: JSON_VALUE): TWITTER_SYMBOLS_ENTITY
			-- Fill `a_size_entities' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_symbol_entities /= Void then
				Result := a_symbol_entities
			else
				create Result
			end
			Result.set_indices (integer_tuple_value_from_json (a_json, "indices"))
			Result.set_text (string_value_from_json (a_json, "text"))
		end

	twitter_url_entities (a_url_entities: detachable like twitter_url_entities; a_json: JSON_VALUE): TWITTER_URLS_ENTITY
			-- Fill `a_size_entities' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_url_entities /= Void then
				Result := a_url_entities
			else
				create Result
			end
			Result.set_display_url (string_value_from_json (a_json, "display_url"))
			Result.set_expanded_url (string_value_from_json (a_json, "expanded_url"))
			Result.set_indices (integer_tuple_value_from_json (a_json, "indices"))
			Result.set_url (string_value_from_json (a_json, "url"))
		end

	twitter_user_mentions_entities (a_user_mentions_entities: detachable like twitter_user_mentions_entities; a_json: JSON_VALUE): TWITTER_USER_MENTIONS_ENTITY
			-- Fill `a_size_entities' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_user_mentions_entities /= Void then
				Result := a_user_mentions_entities
			else
				create Result
			end
			Result.set_id (integer_64_value_from_json (a_json, "id"))
			Result.set_id_str (string_value_from_json (a_json, "id_str"))
			Result.set_indices (integer_tuple_value_from_json (a_json, "indices"))
			Result.set_name (string_value_from_json (a_json, "name"))
			Result.set_screen_name (string_value_from_json (a_json, "screen_name"))
		end

	twitter_video_info_entities (a_video_entity: detachable like twitter_video_info_entities; a_json: JSON_VALUE): TWITTER_VIDEO_ENTITY
			-- Fill `a_video_variant' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
			l_variants: LIST [TWITTER_VIDEO_VARIANTS]
		do
			if a_video_entity /= Void then
				Result := a_video_entity
			else
				create Result
			end
			Result.set_duration_millis(integer_value_from_json (a_json, "duration_millis"))
			Result.set_video_info (integer_tuple_value_from_json (a_json, "aspect_ratio"))
			if attached {JSON_ARRAY} json_value (a_json, "variants") as l_variants_json then
				create {ARRAYED_LIST[TWITTER_VIDEO_VARIANTS]} l_variants.make (4)
				across l_variants_json as ic loop
					l_variants.force (twitter_video_variants (Void, ic.item))
				end
			end
		end

	twitter_video_variants (a_video_variant: detachable like twitter_video_variants; a_json: JSON_VALUE): TWITTER_VIDEO_VARIANTS
			-- Fill `a_video_variant' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_video_variant /= Void then
				Result := a_video_variant
			else
				create Result
			end
			Result.set_bitrate (integer_value_from_json (a_json, "bitrate"))
			Result.set_content_type (string_value_from_json (a_json, "content_type"))
			Result.set_url (string_value_from_json (a_json, "url"))
		end

feature --{NONE}

	stripslashes (s: STRING): STRING
		do
			Result := s.string
			Result.replace_substring_all ("\%"", "%"")
			Result.replace_substring_all ("\'", "'")
			Result.replace_substring_all ("\/", "/")
			Result.replace_substring_all ("\\", "\")
		end

feature -- Implementation

	print_last_json_data
			-- Print `last_json' data
		do
			internal_print_json_data (last_json, "  ")
		end

feature {NONE} -- Implementation

	twitter_api: TWITTER_API
			-- Twitter API object.

	last_json: detachable JSON_VALUE

	parsed_json (a_json_text: STRING): detachable JSON_VALUE
		local
			j: JSON_PARSER
		do
			create j.make_with_string (a_json_text)
			j.parse_content
			Result := j.parsed_json_value
			last_json := Result
		end

	json_value (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable JSON_VALUE
		local
			l_id: JSON_STRING
			l_ids: LIST [STRING]
		do
			Result := a_json_data
			if Result /= Void then
				if a_id /= Void and then not a_id.is_empty then
					from
						l_ids := a_id.split ('.')
						l_ids.start
					until
						l_ids.after or Result = Void
					loop
						-- create l_id.make_from_string (l_ids.item)
						--| Workaround to work with escaped json strings.
						create l_id.make_from_escaped_json_string (l_ids.item)
						if attached {JSON_OBJECT} Result as v_data then
							if v_data.has_key (l_id) then
								Result := v_data.item (l_id)
							else
								Result := Void
							end
						else
							Result := Void
						end
						l_ids.forth
					end
				end
			end
		end

	internal_print_json_data (a_json_data: detachable JSON_VALUE; a_offset: STRING)
		local
			obj: HASH_TABLE [JSON_VALUE, JSON_STRING]
		do
			if attached {JSON_OBJECT} a_json_data as v_data then
				obj	:= v_data.map_representation
				from
					obj.start
				until
					obj.after
				loop
					print (a_offset)
					print (obj.key_for_iteration.item)
					if attached {JSON_STRING} obj.item_for_iteration as j_s then
						print (": " + j_s.item)
					elseif attached {JSON_NUMBER} obj.item_for_iteration as j_n then
						print (": " + j_n.item)
					elseif attached {JSON_BOOLEAN} obj.item_for_iteration as j_b then
						print (": " + j_b.item.out)
					elseif attached {JSON_NULL} obj.item_for_iteration as j_null then
						print (": NULL")
					elseif attached {JSON_ARRAY} obj.item_for_iteration as j_a then
						print (": {%N")
						internal_print_json_data (j_a, a_offset + "  ")
						print (a_offset + "}")
					elseif attached {JSON_OBJECT} obj.item_for_iteration as j_o then
						print (": {%N")
						internal_print_json_data (j_o, a_offset + "  ")
						print (a_offset + "}")
					end
					print ("%N")
					obj.forth
				end
			end
		end

	integer_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): INTEGER
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.numeric_type = v.integer_type
			then
				Result := v.item.to_integer
			end
		end

	integer_64_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): INTEGER_64
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.is_number
			then
				Result := v.integer_64_item
			end
		end

	boolean_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): BOOLEAN
		do
			if attached {JSON_BOOLEAN} json_value (a_json_data, a_id) as v then
				Result := v.item
			end
		end

	string_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.item
			end
		end

	string32_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING_32
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.unescaped_string_32
			end
		end

	integer_tuple_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable TUPLE [INTEGER, INTEGER]
		do
			if
				attached {JSON_ARRAY} json_value (a_json_data, a_id) as v and then
				v.count = 2 and then attached {JSON_NUMBER} v.i_th (1) as l_index_1 and then
				attached {JSON_NUMBER} v.i_th (2) as l_index_2 and then
				l_index_1.numeric_type = l_index_1.integer_type and then
				l_index_2.numeric_type = l_index_2.integer_type
			then
				Result := [l_index_1.item.to_integer, l_index_2.item.to_integer]
			end
		end

note
	copyright: "Copyright (c) 2003-2010, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
