note
	description: "Summary description for {TEST_TWITTER_ENTITIES_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TWITTER_ENTITIES_SET

inherit

	TEST_TWITTER_COMMON

feature -- Test

	test_entities
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (entities_json) as l_entities_json then
				if attached {TWITTER_ENTITIES} twitter_json.twitter_entities (void, l_entities_json) as l_entities then
					if attached l_entities.hashtags as l_hashtags then
						assert ("Count", l_hashtags.count = 1)
						if attached {TWITTER_HASHTAGS_ENTITY}  l_hashtags.at (1) as l_hashtags_entity then
							assert ("text = lol", attached l_hashtags_entity.text as l_text and then l_text.same_string ("lol"))
							assert ("Expec indices", attached l_hashtags_entity.indices as l_indices and then l_indices ~ [32,36])
						end
					end
					if attached l_entities.media as l_media then
						assert ("Count", l_media.count = 1)
						if attached {TWITTER_MEDIA_ENTITY}  l_media.at (1) as l_media_entity then
----							"type": "photo",
--								"sizes": {
--									"thumb": {
--										"h": 150,
--										"resize": "crop",
--										"w": 150
--									},
--									"large": {
--										"h": 238,
--										"resize": "fit",
--										"w": 226
--									},
--									"medium": {
--										"h": 238,
--										"resize": "fit",
--										"w": 226
--									},
--									"small": {
--										"h": 238,
--										"resize": "fit",
--										"w": 226
--									}
--								},
--								"indices": [15, 35],
--								"url": "http:\/\/t.co\/rJC5Pxsu",
--								"media_url": "http:\/\/p.twimg.com\/AZVLmp-CIAAbkyy.jpg",
--								"display_url": "pic.twitter.com\/rJC5Pxsu",
--								"id": 114080493040967680,
--								"id_str": "114080493040967680",
--								"expanded_url": "http:\/\/twitter.com\/yunorno\/status\/114080493036773378\/photo\/1",
--								"media_url_https": "https:\/\/p.twimg.com\/AZVLmp-CIAAbkyy.jpg"

							assert ("type", attached l_media_entity.type as l_type and then l_type.same_string ("photo"))
						end
					end
					if attached l_entities.symbols as l_symbols then
						assert ("Count", l_symbols.count = 2)
						if attached {TWITTER_SYMBOLS_ENTITY}  l_symbols.at (1) as l_symbol_variant then
							assert ("text = PEP", attached l_symbol_variant.text as l_text and then l_text.same_string ("PEP"))
							assert ("Expec indices", attached l_symbol_variant.indices as l_indices and then l_indices ~ [0,4])
						end
						if attached {TWITTER_SYMBOLS_ENTITY}  l_symbols.at (2) as l_symbol_variant then
							assert ("text = COKE", attached l_symbol_variant.text as l_text and then l_text.same_string ("COKE"))
							assert ("Expec indices", attached l_symbol_variant.indices as l_indices and then l_indices ~ [8,13])
						end
					end
					if attached l_entities.urls as l_urls then
						assert ("Url", l_urls.count = 1)
						if attached {TWITTER_URLS_ENTITY} l_urls.at (1) as l_url_entity then
							assert ("Expec url", attached l_url_entity.url as l_url and then l_url.same_string ("http:\/\/t.co\/IOwBrTZR"))
							assert ("Expec expanded_url", attached l_url_entity.expanded_url as l_expanded_url and then l_expanded_url.same_string ("http:\/\/www.youtube.com\/watch?v=oHg5SJYRHA0"))
							assert ("Expec display_url", attached l_url_entity.display_url as l_display_url and then l_display_url.same_string ("youtube.com\/watch?v=oHg5SJ\u2026"))
							assert ("Expec indices", attached l_url_entity.indices as l_indices and then l_indices ~ [32,52])
						end
					end
					if attached l_entities.user_mentions as l_user_mentions then
						assert ("Url", l_user_mentions.count = 1)
						if attached {TWITTER_USER_MENTIONS_ENTITY}  l_user_mentions.at (1) as l_user_mentions_entity then
							assert ("Expec id = 6253282", l_user_mentions_entity.id = 6253282 )
							assert ("Expec id_str = 6253282", attached l_user_mentions_entity.id_str as l_id_str and then l_id_str.same_string ("6253282") )
							assert ("Expec indices", attached l_user_mentions_entity.indices as l_indices and then l_indices ~ [4,15])
							assert ("Expec name = Twitter API", attached l_user_mentions_entity.name as l_name and then l_name.same_string ("Twitter API"))
							assert ("Expec screen_name = twitterapi", attached l_user_mentions_entity.screen_name as l_screen_name and then l_screen_name.same_string ("twitterapi"))
						end
					end
				end
			else
				assert ("Check implementation", False)
			end
		end


feature -- JSON

	entities_json: STRING ="[

{
	"hashtags": [{
		"indices": [32, 36],
		"text": "lol"
	}],
	"symbols": [{
			"text": "PEP",
			"indices": [
				0,
				4
			]
		},
		{
			"text": "COKE",
			"indices": [
				8,
				13
			]
		}
	],
	"urls": [{
		"indices": [32, 52],
		"url": "http:\/\/t.co\/IOwBrTZR",
		"display_url": "youtube.com\/watch?v=oHg5SJ\u2026",
		"expanded_url": "http:\/\/www.youtube.com\/watch?v=oHg5SJYRHA0"
	}],
	"user_mentions": [{
		"name": "Twitter API",
		"indices": [4, 15],
		"screen_name": "twitterapi",
		"id": 6253282,
		"id_str": "6253282"
	}],
	"media": [{
		"type": "photo",
		"sizes": {
			"thumb": {
				"h": 150,
				"resize": "crop",
				"w": 150
			},
			"large": {
				"h": 238,
				"resize": "fit",
				"w": 226
			},
			"medium": {
				"h": 238,
				"resize": "fit",
				"w": 226
			},
			"small": {
				"h": 238,
				"resize": "fit",
				"w": 226
			}
		},
		"indices": [15, 35],
		"url": "http:\/\/t.co\/rJC5Pxsu",
		"media_url": "http:\/\/p.twimg.com\/AZVLmp-CIAAbkyy.jpg",
		"display_url": "pic.twitter.com\/rJC5Pxsu",
		"id": 114080493040967680,
		"id_str": "114080493040967680",
		"expanded_url": "http:\/\/twitter.com\/yunorno\/status\/114080493036773378\/photo\/1",
		"media_url_https": "https:\/\/p.twimg.com\/AZVLmp-CIAAbkyy.jpg"
	}]
}



	]"
end
