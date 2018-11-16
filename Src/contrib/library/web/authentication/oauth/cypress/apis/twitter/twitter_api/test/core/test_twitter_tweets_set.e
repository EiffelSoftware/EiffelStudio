note
	description: "Summary description for {TEST_TWITTER_TWEETS_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TWITTER_TWEETS_SET

inherit

	TEST_TWITTER_COMMON


feature	-- Test

	test_tweets
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (tweets_json) as l_tweets_json then
				if attached {TWITTER_TWEETS} twitter_json.twitter_tweets (void, l_tweets_json) as l_tweets then
					assert ("coordinates", l_tweets.coordinates = Void )
					assert ("created_at", attached l_tweets.created_at as l_created_at and then l_created_at.same_string ("Wed Jun 06 20:07:10 +0000 2012"))
					assert ("id_str", attached l_tweets.id_str as l_id_str and then l_id_str.same_string ("210462857140252672"))
					assert ("text", attached l_tweets.text as l_text and then l_text.same_string ("Along with our new #Twitterbird, we've also updated our Display Guidelines: https://t.co/Ed4omjYs  ^JC"))
				 	assert ("retweet_count", l_tweets.retweet_count = 66)
				end
			else
				assert ("Check implementation", False)
			end
		end

feature -- Test	

	tweets_json: STRING = "[
{
  "coordinates": null,
  "favorited": false,
  "truncated": false,
  "created_at": "Wed Jun 06 20:07:10 +0000 2012",
  "id_str": "210462857140252672",
  "entities": {
    "urls": [
      {
        "expanded_url": "/terms/display-guidelines",
        "url": "https://t.co/Ed4omjYs",
        "indices": [
          76,
          97
        ],
        "display_url": "dev.twitter.com/terms/display-\u2026"
      }
    ],
    "hashtags": [
      {
        "text": "Twitterbird",
        "indices": [
          19,
          31
        ]
      }
    ],
    "user_mentions": [

    ]
  },
  "in_reply_to_user_id_str": null,
  "contributors": [
    14927800
  ],
  "text": "Along with our new #Twitterbird, we've also updated our Display Guidelines: https://t.co/Ed4omjYs  ^JC",
  "retweet_count": 66,
  "in_reply_to_status_id_str": null,
  "id": 210462857140252672,
  "geo": null,
  "retweeted": true,
  "possibly_sensitive": false,
  "in_reply_to_user_id": null,
  "place": null,
  "user": {
    "profile_sidebar_fill_color": "DDEEF6",
    "profile_sidebar_border_color": "C0DEED",
    "profile_background_tile": false,
    "name": "Twitter API",
    "profile_image_url": "http://a0.twimg.com/profile_images/2284174872/7df3h38zabcvjylnyfe3_normal.png",
    "created_at": "Wed May 23 06:01:13 +0000 2007",
    "location": "San Francisco, CA",
    "follow_request_sent": false,
    "profile_link_color": "0084B4",
    "is_translator": false,
    "id_str": "6253282",
    "entities": {
      "url": {
        "urls": [
          {
            "expanded_url": null,
            "url": "",
            "indices": [
              0,
              22
            ]
          }
        ]
      },
      "description": {
        "urls": [

        ]
      }
    },
    "default_profile": true,
    "contributors_enabled": true,
    "favourites_count": 24,
    "url": "",
    "profile_image_url_https": "https://si0.twimg.com/profile_images/2284174872/7df3h38zabcvjylnyfe3_normal.png",
    "utc_offset": -28800,
    "id": 6253282,
    "profile_use_background_image": true,
    "listed_count": 10774,
    "profile_text_color": "333333",
    "lang": "en",
    "followers_count": 1212963,
    "protected": false,
    "notifications": null,
    "profile_background_image_url_https": "https://si0.twimg.com/images/themes/theme1/bg.png",
    "profile_background_color": "C0DEED",
    "verified": true,
    "geo_enabled": true,
    "time_zone": "Pacific Time (US & Canada)",
    "description": "The Real Twitter API. I tweet about API changes, service issues and happily answer questions about Twitter and our API. Don't get an answer? It's on my website.",
    "default_profile_image": false,
    "profile_background_image_url": "http://a0.twimg.com/images/themes/theme1/bg.png",
    "statuses_count": 3333,
    "friends_count": 31,
    "following": true,
    "show_all_inline_media": false,
    "screen_name": "twitterapi"
  },
  "in_reply_to_screen_name": null,
  "source": "web",
  "in_reply_to_status_id": null
}	
	
	

	]"

end
