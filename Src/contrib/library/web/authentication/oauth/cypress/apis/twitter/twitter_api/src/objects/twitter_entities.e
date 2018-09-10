note
	description: "[
				Entities provide metadata and additional contextual information about content posted on Twitter. 
				Entities are never divorced from the content they describe. Entities are returned wherever Tweets are found in the API. 
				Entities are instrumental in resolving URLs.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Object Entities", "src=https://dev.twitter.com/overview/api/entities", "protocol=uri"
class
	TWITTER_ENTITIES


feature -- Access

	symbols: detachable LIST [TWITTER_SYMBOLS_ENTITY]
			-- An array of financial symbols starting with the dollar sign extracted from the Tweet text.
			-- Similar to hashtags, an entity comes with the following attributes:

	hashtags: detachable LIST [TWITTER_HASHTAGS_ENTITY]
		-- Represents hashtags which have been parsed out of the Tweet text.
		-- Example:
		-- "hashtags":[{"indices":[32,36],"text":"lol"}]


	media: detachable LIST [TWITTER_MEDIA_ENTITY]
		-- Represents media elements uploaded with the Tweet. Example:
		-- "media":[{"type":"photo", "sizes":{"thumb":{"h":150, "resize":"crop", "w":150}, "large":{"h":238, "resize":"fit", "w":226},
		-- "medium":{"h":238, "resize":"fit", "w":226}, "small":{"h":238, "resize":"fit", "w":226}}, "indices":[15,35],
		-- "url":"http:\/\/t.co\/rJC5Pxsu", "media_url":"http:\/\/p.twimg.com\/AZVLmp-CIAAbkyy.jpg",
		-- "display_url":"pic.twitter.com\/rJC5Pxsu","id":114080493040967680, "id_str":"114080493040967680", "expanded_url":
		-- "http:\/\/twitter.com\/yunorno\/status\/114080493036773378\/photo\/1",
		-- "media_url_https":"https:\/\/p.twimg.com\/AZVLmp-CIAAbkyy.jpg"}]	


	urls: detachable LIST [TWITTER_URLS_ENTITY]
		-- Represents URLs included in the text of a Tweet or within textual fields of a user object . Tweet Example:
		-- "urls":[{"indices":[32,52], "url":"http:\/\/t.co\/IOwBrTZR", "display_url":"youtube.com\/watch?v=oHg5SJ\u2026",
		-- "expanded_url":"http:\/\/www.youtube.com\/watch?v=oHg5SJYRHA0"}]
		-- User Example:
		-- "urls":[{"indices":[32,52], "url":"http:\/\/t.co\/IOwBrTZR", "display_url":"youtube.com\/watch?v=oHg5SJ\u2026", "expanded_url"
		--:"http:\/\/www.youtube.com\/watch?v=oHg5SJYRHA0"}]


	user_mentions: detachable LIST [TWITTER_USER_MENTIONS_ENTITY]
		--	Represents other Twitter users mentioned in the text of the Tweet. Example:
		-- "user_mentions":[{"name":"Twitter API", "indices":[4,15], "screen_name":"twitterapi", "id":6253282, "id_str":"6253282"}]


feature -- Element change

	set_symbols (a_symbols: like symbols)
			-- Assign `symbols' with `a_symbols'.
		do
			symbols := a_symbols
		ensure
			symbols_assigned: symbols = a_symbols
		end

feature -- Element Change

	set_hashtags (a_hashtags: like hashtags)
			-- Set 'hashtags' with 'a_hashtags'.
		do
			hashtags := a_hashtags
		end

	set_media (a_media: like media)
			-- Set 'media' with `a_media`.
		do
			media := a_media
		end

	set_urls (a_urls: like urls)
			-- Set 'urls' with 'a_urls'.
		do
			urls := a_urls
		end

	set_user_mentions (a_user_mentions: like user_mentions)
			-- Set 'user_mentions' with 'a_user_mentions'.
		do
			user_mentions := a_user_mentions
		end

end
