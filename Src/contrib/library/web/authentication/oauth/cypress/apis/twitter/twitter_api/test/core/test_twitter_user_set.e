note
	description: "Summary description for {TEST_TWITTER_USER_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TWITTER_USER_SET

inherit

	TEST_TWITTER_COMMON


feature --Test


	test_user
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (user_json) as l_user_json then
				if attached {TWITTER_USER} twitter_json.twitter_user (void, l_user_json) as l_user then
					assert ("id", l_user.id = 2244994945)
					assert ("id_str", attached l_user.id_str as l_id_str and then l_id_str.same_string ("2244994945"))

					assert ("default_profile", not l_user.default_profile)
					assert ("default_profile_image", not l_user.default_profile_image)
					assert ("following", not l_user.following)
				end
			else
				assert ("Check implementation", False)
			end
		end

feature -- JSON

	user_json: STRING = "[
		{
  "id": 2244994945,
  "id_str": "2244994945",
  "name": "TwitterDev",
  "screen_name": "TwitterDev",
  "location": "Internet",
  "profile_location": null,
  "description": "Developer and Platform Relations @Twitter. We are developer advocates. We can't answer all your questions, but we listen to all of them!",
  "url": "https://t.co/66w26cua1O",
  "entities": {
    "url": {
      "urls": [
        {
          "url": "https://t.co/66w26cua1O",
          "expanded_url": "https://dev.twitter.com/",
          "display_url": "dev.twitter.com",
          "indices": [
            0,
            23
          ]
        }
      ]
    },
    "description": {
      "urls": []
    }
  },
  "protected": false,
  "followers_count": 429831,
  "friends_count": 1535,
  "listed_count": 999,
  "created_at": "Sat Dec 14 04:35:55 +0000 2013",
  "favourites_count": 1713,
  "utc_offset": -25200,
  "time_zone": "Pacific Time (US & Canada)",
  "geo_enabled": true,
  "verified": true,
  "statuses_count": 2588,
  "lang": "en",
  "status": {
    "created_at": "Tue Aug 30 10:52:20 +0000 2016",
    "id": 770574870841331700,
    "id_str": "770574870841331712",
    "text": "@lesterhan oops! Thanks for pointing that out, looks like the image is no longer available! we will fix in a future doc version! ^AP",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [
        {
          "screen_name": "lesterhan",
          "name": "Lester Han",
          "id": 126025266,
          "id_str": "126025266",
          "indices": [
            0,
            10
          ]
        }
      ],
      "urls": []
    },
    "source": "<a href=\"https://about.twitter.com/products/tweetdeck\" rel=\"nofollow\">TweetDeck</a>",
    "in_reply_to_status_id": 770332467626672100,
    "in_reply_to_status_id_str": "770332467626672129",
    "in_reply_to_user_id": 126025266,
    "in_reply_to_user_id_str": "126025266",
    "in_reply_to_screen_name": "lesterhan",
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  "contributors_enabled": false,
  "is_translator": false,
  "is_translation_enabled": false,
  "profile_background_color": "FFFFFF",
  "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
  "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
  "profile_background_tile": false,
  "profile_image_url": "http://pbs.twimg.com/profile_images/530814764687949824/npQQVkq8_normal.png",
  "profile_image_url_https": "https://pbs.twimg.com/profile_images/530814764687949824/npQQVkq8_normal.png",
  "profile_banner_url": "https://pbs.twimg.com/profile_banners/2244994945/1396995246",
  "profile_link_color": "0084B4",
  "profile_sidebar_border_color": "FFFFFF",
  "profile_sidebar_fill_color": "DDEEF6",
  "profile_text_color": "333333",
  "profile_use_background_image": false,
  "has_extended_profile": false,
  "default_profile": false,
  "default_profile_image": false,
  "following": false,
  "follow_request_sent": false,
  "notifications": false,
  "translator_type": "regular"
}

	]"

end
