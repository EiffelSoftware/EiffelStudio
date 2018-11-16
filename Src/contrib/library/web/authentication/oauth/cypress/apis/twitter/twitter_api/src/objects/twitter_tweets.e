note
	description: "[
			Tweets are the basic atomic building block of all things Twitter. Tweets are also known as status updates. 
			Tweets can be embedded, replied to, liked, unliked and deleted.
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Tweets", "src=https://dev.twitter.com/overview/api/tweets", "protocol=uri"

class
	TWITTER_TWEETS

feature -- Access

	withheld_scope: detachable STRING
			-- When present, indicates whether the content being withheld is the “status” or a “user.”
			-- Example:
			-- "withheld_scope": "status"

	withheld_in_countries: detachable LIST [STRING]
			-- When present, indicates a list of uppercase two-letter country codes this content is withheld from.
			-- Twitter supports the following non-country values for this field:
			-- XX - Content is withheld in all countries XY - Content is withheld due to a DMCA request.
			-- Example:
			-- "withheld_in_countries": ["GR", "HK", "MY"]

	withheld_copyright: BOOLEAN
			-- When present and set to true, it indicates that this piece of content has been withheld due to a DMCA complaint .
			-- Example:
			-- "withheld_copyright": true

	truncated: BOOLEAN
			-- Indicates whether the value of the text parameter was truncated, for example, as a result of a retweet exceeding the 140 character Tweet length.
			-- Truncated text will end in ellipsis, like this ... Since Twitter now rejects long Tweets vs truncating them, the large majority of Tweets will have this set to false .
			-- Note that while native retweets may have their toplevel text property shortened, the original text will be available under the retweeted_status object and the truncated
			-- parameter will be set to the value of the original status (in most cases, false ). Example:
			-- "truncated":true

	source: detachable STRING
			-- Utility used to post the Tweet, as an HTML-formatted string. Tweets from the Twitter website have a source value of web.
			-- Example:
			-- "source":"\u003Ca href=\"http:\/\/itunes.apple.com\/us\/app\/twitter\/id409789998?mt=12\" \u003ETwitter for Mac\u003C\/a\u003E"

	retweeted_status: detachable TWITTER_TWEETS
			-- Users can amplify the broadcast of Tweets authored by other users by retweeting .
			-- Retweets can be distinguished from typical Tweets by the existence of a retweeted_status attribute.
			-- This attribute contains a representation of the original Tweet that was retweeted.
			-- Note that retweets of retweets do not show representations of the intermediary retweet, but only the original Tweet.
			-- (Users can also unretweet a retweet they created by deleting their retweet.)

	retweeted: BOOLEAN
			-- Indicates whether this Tweet has been retweeted by the authenticating user.
			-- Example:
			-- "retweeted":false

	retweet_count: INTEGER
			-- Number of times this Tweet has been retweeted.
			-- Example:
			--"retweet_count":1585

	scopes:detachable STRING_TABLE [ANY]
			-- TODO
			--A set of key-value pairs indicating the intended contextual delivery of the containing Tweet. Currently used by Twitters Promoted Products. Example:
			--"scopes":{"followers":false}


	quoted_status: detachable TWITTER_TWEETS
			-- This field only surfaces when the Tweet is a quote Tweet. This attribute contains the Tweet object of the original Tweet that was quoted.	

	quoted_status_id_str: detachable STRING
			-- This field only surfaces when the Tweet is a quote Tweet. This is the string representation Tweet ID of the quoted Tweet.
			-- Example:
			-- "quoted_status_id_str":"114749583439036416"

	quoted_status_id: INTEGER_64
			-- This field only surfaces when the Tweet is a quote Tweet. This field contains the integer value Tweet ID of the quoted Tweet.
			-- Example:
			-- "quoted_status_id":114749583439036416

	possibly_sensitive: BOOLEAN
			-- This field only surfaces when a Tweet contains a link. The meaning of the field doesnt pertain to the Tweet content itself,
			-- but instead it is an indicator that the URL contained in the Tweet may contain content or media identified as sensitive content.
			-- Example:
			-- "possibly_sensitive":true		

	place: detachable TWITTER_PLACES
			--	When present, indicates that the tweet is associated (but not necessarily originating from) a Place .

	lang: detachable STRING
			--	When present, indicates a BCP 47 language identifier corresponding to the machine-detected language of the Tweet text, or und if no language could be detected.
			-- Example:
			-- "lang": "en"

	in_reply_to_user_id_str: detachable STRING
			-- If the represented Tweet is a reply, this field will contain the string representation of the original Tweets author ID.
			-- This will not necessarily always be the user directly mentioned in the Tweet.
			-- Example:
			-- "in_reply_to_user_id_str":"819797"


	in_reply_to_user_id: INTEGER_64
			--	If the represented Tweet is a reply, this field will contain the integer representation of the original Tweets author ID.
			-- This will not necessarily always be the user directly mentioned in the Tweet.
			-- Example:
			-- "in_reply_to_user_id":819797

	in_reply_to_status_id_str: detachable STRING
			-- If the represented Tweet is a reply, this field will contain the string representation of the original Tweets ID.
			-- Example:
			-- "in_reply_to_status_id_str":"114749583439036416"

	in_reply_to_status_id: INTEGER_64
			-- If the represented Tweet is a reply, this field will contain the integer representation of the original Tweets ID.
			-- Example:
			-- "in_reply_to_status_id":114749583439036416	

	in_reply_to_screen_name: detachable STRING
			--	If the represented Tweet is a reply, this field will contain the screen name of the original Tweets author.
			-- Example:
			-- "in_reply_to_screen_name":"twitterapi"

	id_str: detachable STRING
			-- The string representation of the unique identifier for this Tweet.
			-- Implementations should use this rather than the large integer in id.
			-- Example:
			-- "id_str":"114749583439036416"

	id: INTEGER_64
			-- The integer representation of the unique identifier for this Tweet.
			-- This number is greater than 53 bits and some programming languages may have difficulty/silent defects in interpreting it.
			-- Using a signed 64 bit integer for storing this identifier is safe.
			-- Use id_str for fetching the identifier to stay on the safe side. See Twitter IDs, JSON and Snowflake .
			-- Example:
			--"id":114749583439036416
		note
			EIS: "name=Twitter IDs, JSON and Snowflake", "src=https://dev.twitter.com/overview/api/twitter-ids-json-and-snowflake", "protcol=uri"
		attribute
		end

	filter_level: detachable STRING
			-- Indicates the maximum value of the filter_level parameter which may be used and still stream this Tweet.
			-- So a value of medium will be streamed on 'none', 'low', and 'medium' streams.
			--Example:
			--"filter_level": "medium"

	favorited: BOOLEAN
			-- Indicates whether this Tweet has been liked by the authenticating user.
			-- Example:
			-- "favorited":true

	favorite_count: INTEGER
			-- Indicates approximately how many times this Tweet has been liked by Twitter users.
			-- Example:
			-- "favorite_count":1138

	entities: detachable TWITTER_ENTITIES
			-- Entities which have been parsed out of the text of the Tweet.

	coordinates: detachable TWITTER_COORDINATES
			-- Represents the geographic location of this Tweet as reported by the user or client application.
			-- The inner coordinates array is formatted as geoJSON (longitude first, then latitude).

	text: detachable STRING
			-- The actual UTF-8 text of the status update.

	user: detachable TWITTER_USER
			-- The user who posted this Tweet.

	created_at: detachable STRING
			-- UTC time when this Tweet was created
			--| Example:
			--| "created_at":"Wed Aug 27 13:08:45 +0000 2008"



--current_user_retweet	Object	
--Perspectival Only surfaces on methods supporting the include_my_retweet parameter, when set to true.
--Details the Tweet ID of the users own retweet (if existent) of this Tweet. Example:

--"current_user_retweet": {
--  "id": 26815871309,
--  "id_str": "26815871309"
--}



feature -- Out

	full_out: STRING
			-- <Precursor>
		local
			l_offset: STRING
		do
			l_offset := "  "

			create Result.make_from_string ("")
			Result.append_string ("%N")

			if attached text as l_text then
				Result.append_string (l_offset)
				Result.append_string ("text=")
				Result.append_string (l_text)
				Result.append_string ("%N")
			end
			if attached created_at as l_created_at then
				Result.append_string (l_offset)
				Result.append_string ("created_at=")
				Result.append_string (l_created_at)
				Result.append_string ("%N")
			end

			if attached user as l_user then
				Result.append_string (l_offset)
				Result.append_string ("user=[")
				Result.append_string (l_user.short_out)
				Result.append_string ("]%N")
			end
		end



feature -- Element change

	set_withheld_scope (a_withheld_scope: like withheld_scope)
			-- Assign `withheld_scope' with `a_withheld_scope'.
		do
			withheld_scope := a_withheld_scope
		ensure
			withheld_scope_assigned: withheld_scope = a_withheld_scope
		end

	set_withheld_in_countries (a_withheld_in_countries: like withheld_in_countries)
			-- Assign `withheld_in_countries' with `a_withheld_in_countries'.
		do
			withheld_in_countries := a_withheld_in_countries
		ensure
			withheld_in_countries_assigned: withheld_in_countries = a_withheld_in_countries
		end

	set_withheld_copyright (a_withheld_copyright: like withheld_copyright)
			-- Assign `withheld_copyright' with `a_withheld_copyright'.
		do
			withheld_copyright := a_withheld_copyright
		ensure
			withheld_copyright_assigned: withheld_copyright = a_withheld_copyright
		end

	set_truncated (a_truncated: like truncated)
			-- Assign `truncated' with `a_truncated'.
		do
			truncated := a_truncated
		ensure
			truncated_assigned: truncated = a_truncated
		end

	set_source (a_source: like source)
			-- Assign `source' with `a_source'.
		do
			source := a_source
		ensure
			source_assigned: source = a_source
		end

	set_retweeted_status (a_retweeted_status: like retweeted_status)
			-- Assign `retweeted_status' with `a_retweeted_status'.
		do
			retweeted_status := a_retweeted_status
		ensure
			retweeted_status_assigned: retweeted_status = a_retweeted_status
		end

	set_retweeted (a_retweeted: like retweeted)
			-- Assign `retweeted' with `a_retweeted'.
		do
			retweeted := a_retweeted
		ensure
			retweeted_assigned: retweeted = a_retweeted
		end

	set_retweet_count (a_retweet_count: like retweet_count)
			-- Assign `retweet_count' with `a_retweet_count'.
		do
			retweet_count := a_retweet_count
		ensure
			retweet_count_assigned: retweet_count = a_retweet_count
		end

	set_quoted_status (a_quoted_status: like quoted_status)
			-- Assign `quoted_status' with `a_quoted_status'.
		do
			quoted_status := a_quoted_status
		ensure
			quoted_status_assigned: quoted_status = a_quoted_status
		end

	set_quoted_status_id_str (a_quoted_status_id_str: like quoted_status_id_str)
			-- Assign `quoted_status_id_str' with `a_quoted_status_id_str'.
		do
			quoted_status_id_str := a_quoted_status_id_str
		ensure
			quoted_status_id_str_assigned: quoted_status_id_str = a_quoted_status_id_str
		end

	set_quoted_status_id (a_quoted_status_id: like quoted_status_id)
			-- Assign `quoted_status_id' with `a_quoted_status_id'.
		do
			quoted_status_id := a_quoted_status_id
		ensure
			quoted_status_id_assigned: quoted_status_id = a_quoted_status_id
		end

	set_possibly_sensitive (a_possibly_sensitive: like possibly_sensitive)
			-- Assign `possibly_sensitive' with `a_possibly_sensitive'.
		do
			possibly_sensitive := a_possibly_sensitive
		ensure
			possibly_sensitive_assigned: possibly_sensitive = a_possibly_sensitive
		end

	set_place (a_place: like place)
			-- Assign `place' with `a_place'.
		do
			place := a_place
		ensure
			place_assigned: place = a_place
		end

	set_lang (a_lang: like lang)
			-- Assign `lang' with `a_lang'.
		do
			lang := a_lang
		ensure
			lang_assigned: lang = a_lang
		end

	set_in_reply_to_user_id_str (an_in_reply_to_user_id_str: like in_reply_to_user_id_str)
			-- Assign `in_reply_to_user_id_str' with `an_in_reply_to_user_id_str'.
		do
			in_reply_to_user_id_str := an_in_reply_to_user_id_str
		ensure
			in_reply_to_user_id_str_assigned: in_reply_to_user_id_str = an_in_reply_to_user_id_str
		end

	set_in_reply_to_user_id (an_in_reply_to_user_id: like in_reply_to_user_id)
			-- Assign `in_reply_to_user_id' with `an_in_reply_to_user_id'.
		do
			in_reply_to_user_id := an_in_reply_to_user_id
		ensure
			in_reply_to_user_id_assigned: in_reply_to_user_id = an_in_reply_to_user_id
		end

	set_in_reply_to_status_id_str (an_in_reply_to_status_id_str: like in_reply_to_status_id_str)
			-- Assign `in_reply_to_status_id_str' with `an_in_reply_to_status_id_str'.
		do
			in_reply_to_status_id_str := an_in_reply_to_status_id_str
		ensure
			in_reply_to_status_id_str_assigned: in_reply_to_status_id_str = an_in_reply_to_status_id_str
		end

	set_in_reply_to_status_id (an_in_reply_to_status_id: like in_reply_to_status_id)
			-- Assign `in_reply_to_status_id' with `an_in_reply_to_status_id'.
		do
			in_reply_to_status_id := an_in_reply_to_status_id
		ensure
			in_reply_to_status_id_assigned: in_reply_to_status_id = an_in_reply_to_status_id
		end

	set_in_reply_to_screen_name (an_in_reply_to_screen_name: like in_reply_to_screen_name)
			-- Assign `in_reply_to_screen_name' with `an_in_reply_to_screen_name'.
		do
			in_reply_to_screen_name := an_in_reply_to_screen_name
		ensure
			in_reply_to_screen_name_assigned: in_reply_to_screen_name = an_in_reply_to_screen_name
		end

	set_id_str (an_id_str: like id_str)
			-- Assign `id_str' with `an_id_str'.
		do
			id_str := an_id_str
		ensure
			id_str_assigned: id_str = an_id_str
		end

	set_id (an_id: like id)
			-- Assign `id' with `an_id'.
		do
			id := an_id
		ensure
			id_assigned: id = an_id
		end

	set_filter_level (a_filter_level: like filter_level)
			-- Assign `filter_level' with `a_filter_level'.
		do
			filter_level := a_filter_level
		ensure
			filter_level_assigned: filter_level = a_filter_level
		end

	set_favorited (a_favorited: like favorited)
			-- Assign `favorited' with `a_favorited'.
		do
			favorited := a_favorited
		ensure
			favorited_assigned: favorited = a_favorited
		end

	set_favorite_count (a_favorite_count: like favorite_count)
			-- Assign `favorite_count' with `a_favorite_count'.
		do
			favorite_count := a_favorite_count
		ensure
			favorite_count_assigned: favorite_count = a_favorite_count
		end

	set_entities (an_entities: like entities)
			-- Assign `entities' with `an_entities'.
		do
			entities := an_entities
		ensure
			entities_assigned: entities = an_entities
		end

	set_coordinates (a_coordinates: like coordinates)
			-- Assign `coordinates' with `a_coordinates'.
		do
			coordinates := a_coordinates
		ensure
			coordinates_assigned: coordinates = a_coordinates
		end

	set_text (a_text: like text)
			-- Assign `text' with `a_text'.
		do
			text := a_text
		ensure
			text_assigned: text = a_text
		end

	set_user (an_user: like user)
			-- Assign `user' with `an_user'.
		do
			user := an_user
		ensure
			user_assigned: user = an_user
		end

	set_created_at (a_created_at: like created_at)
			-- Assign `created_at' with `a_created_at'.
		do
			created_at := a_created_at
		ensure
			created_at_assigned: created_at = a_created_at
		end

end
