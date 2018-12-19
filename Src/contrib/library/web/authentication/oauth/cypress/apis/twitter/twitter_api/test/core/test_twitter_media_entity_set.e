note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_TWITTER_MEDIA_ENTITY_SET

inherit

	TEST_TWITTER_COMMON

feature -- Test routines

	test_video_variant
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (video_variant_json) as l_video_variant_json then
				if attached {TWITTER_VIDEO_VARIANTS}  twitter_json.twitter_video_variants (void, l_video_variant_json) as l_video_variant then
					assert ("bitrate = 2176000", attached l_video_variant.bitrate as l_bitrate and then l_bitrate = 2176000)
					assert ("content_type = video\/mp4", attached l_video_variant.content_type as l_content_type and then l_content_type.same_string ("video\/mp4"))
					assert ("Expected url", attached l_video_variant.url as l_url and then l_url.same_string ("https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/1280x720\/c4E56sl91ZB7cpYi.mp4"))
				end
			else
				assert("Check implementation", False)
			end
		end

	test_size_entity
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (size_entity_json) as l_size_entity_json then
				if attached {TWITTER_SIZE_ENTITY}  twitter_json.twitter_size_entities (void, l_size_entity_json) as l_size_entity then
					assert ("Expecter h=576", l_size_entity.height = 576)
					assert ("Expecter resize=fir",  attached l_size_entity.resize as l_resize and then l_resize.same_string ("fit") )
					assert ("Expecter w=1024", l_size_entity.width = 1024)
				end
			else
				assert("Check implementation", False)
			end
		end

	test_url_entity
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (url_entity_json) as l_url_entity_json then
				if attached {TWITTER_URLS_ENTITY}  twitter_json.twitter_url_entities (void, l_url_entity_json) as l_url_entity then
					assert ("Expec url", attached l_url_entity.url as l_url and then l_url.same_string ("https:\/\/t.co\/XdXRudPXH5"))
					assert ("Expec expanded_url", attached l_url_entity.expanded_url as l_expanded_url and then l_expanded_url.same_string ("https:\/\/blog.twitter.com\/2013\/rich-photo-experience-now-in-embedded-tweets-3"))
					assert ("Expec expanded_url", attached l_url_entity.display_url as l_display_url and then l_display_url.same_string ("blog.twitter.com\/2013\/rich-phot\u2026"))
					assert ("Expec indices", attached l_url_entity.indices as l_indices and then l_indices ~ [80,103])
				end
			else
				assert("Check implementation", False)
			end
		end

	test_symbol_entity
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (symbol_entity_json) as l_symbol_entity_json then
				if attached {TWITTER_SYMBOLS_ENTITY}  twitter_json.twitter_symbols_entities (void, l_symbol_entity_json) as l_symbol_variant then
					assert ("text = COKE", attached l_symbol_variant.text as l_text and then l_text.same_string ("COKE"))
					assert ("Expec indices", attached l_symbol_variant.indices as l_indices and then l_indices ~ [8,13])
				end
			else
				assert("Check implementation", False)
			end
		end

	test_hashtags_entity
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (hashtags_entity_json) as l_hashtags_entity_json then
				if attached {TWITTER_HASHTAGS_ENTITY}  twitter_json.twitter_hashtags_entities (void, l_hashtags_entity_json) as l_hashtags_entity then
					assert ("text = devnestSF", attached l_hashtags_entity.text as l_text and then l_text.same_string ("devnestSF"))
					assert ("Expec indices", attached l_hashtags_entity.indices as l_indices and then l_indices ~ [6,16])
				end
			else
				assert("Check implementation", False)
			end
		end

	test_user_mentions_entity
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (user_mentions_json) as l_user_mentions_json then
				if attached {TWITTER_USER_MENTIONS_ENTITY}  twitter_json.twitter_user_mentions_entities (void, l_user_mentions_json) as l_user_mentions_entity then
					assert ("Expec id = 6844292", l_user_mentions_entity.id = 6844292 )
					assert ("Expec id_str = 6844292", attached l_user_mentions_entity.id_str as l_id_str and then l_id_str.same_string ("6844292") )
					assert ("Expec indices", attached l_user_mentions_entity.indices as l_indices and then l_indices ~ [81,92])
					assert ("Expec name = Twitter Engineering", attached l_user_mentions_entity.name as l_name and then l_name.same_string ("Twitter Engineering"))
					assert ("Expec screen_name = TwitterEng", attached l_user_mentions_entity.screen_name as l_screen_name and then l_screen_name.same_string ("TwitterEng"))
				end
			else
				assert("Check implementation", False)
			end
		end


	test_sizes_entity
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (sizes_entity_json) as l_sizes_entity_json then
				if attached {TWITTER_SIZES_ENTITY}  twitter_json.twitter_sizes_entities (void, l_sizes_entity_json) as l_sizes_entity then
					if attached {TWITTER_SIZE_ENTITY} l_sizes_entity.large  as l_large then
						assert ("Expecter h=768", l_large.height = 768)
						assert ("Expecter resize=fit",  attached l_large.resize as l_resize and then l_resize.same_string ("fit") )
						assert ("Expecter w=1024", l_large.width = 1024)
					end
					if attached {TWITTER_SIZE_ENTITY} l_sizes_entity.medium  as l_medium then
						assert ("Expecter h=450", l_medium.height = 450)
						assert ("Expecter resize=fit",  attached l_medium.resize as l_resize and then l_resize.same_string ("fit") )
						assert ("Expecter w=600", l_medium.width = 600)
					end
					if attached {TWITTER_SIZE_ENTITY} l_sizes_entity.thumb  as l_thumb then
						assert ("Expecter h=150", l_thumb.height = 150)
						assert ("Expecter resize=crop",  attached l_thumb.resize as l_resize and then l_resize.same_string ("crop") )
						assert ("Expecter w=150", l_thumb.width = 150)
					end
					if attached {TWITTER_SIZE_ENTITY} l_sizes_entity.small  as l_small then
						assert ("Expecter h=255", l_small.height = 255)
						assert ("Expecter resize=fit",  attached l_small.resize as l_resize and then l_resize.same_string ("fit") )
						assert ("Expecter w=340", l_small.width = 340)
					end
				end
			else
				assert("Check implementation", False)
			end
		end


	test_video_entity
			-- New test routine
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (video_entities_json) as l_video_entity_json then
				if attached {TWITTER_VIDEO_ENTITY}  twitter_json.twitter_video_info_entities (void, l_video_entity_json) as l_video_entity then
					assert ("Expect duration in millis= ", l_video_entity.duration_millis = 30033 )
					assert ("Expec aspect ratio [16,9]", attached l_video_entity.video_info as l_aspect_ratio and then l_aspect_ratio ~ [16,9])
					if attached {LIST[TWITTER_VIDEO_VARIANTS]} l_video_entity.variants as l_variants then
						if attached {TWITTER_VIDEO_VARIANTS} l_variants.first as l_first then
							assert ("bitrate = 2176000", attached l_first.bitrate as l_bitrate and then l_bitrate = 2176000)
							assert ("content_type = video\/mp4", attached l_first.content_type as l_content_type and then l_content_type.same_string ("video\/mp4"))
							assert ("Expected url", attached l_first.url as l_url and then l_url.same_string ("https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/1280x720\/c4E56sl91ZB7cpYi.mp4"))
						end
						if attached {TWITTER_VIDEO_VARIANTS} l_variants.last as l_last then
							assert ("bitrate = 0", attached l_last.bitrate as l_bitrate and then l_bitrate = 0)
							assert ("content_type = application\/x-mpegURL", attached l_last.content_type as l_content_type and then l_content_type.same_string ("application\/x-mpegURL"))
							assert ("Expected url", attached l_last.url as l_url and then l_url.same_string ("https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/pl\/r1kgzh5PmLgium3-.m3u8"))
						end
					end
				end
			else
				assert("Check implementation", False)
			end
		end


	test_extended_entities
		local
			twitter_json: TWITTER_JSON
		do
			create twitter_json
			if attached parsed_json (extended_entities_json) as l_extended_entities_json then
				if attached {TWITTER_EXTENDED_ENTITIES}  twitter_json.twitter_extended_entities (void, l_extended_entities_json) as l_extended_entity then
					if attached l_extended_entity.video_info as l_video then
						assert ("Expect duration in millis= ", l_video.duration_millis = 30033 )
						assert ("Expec aspect ratio [16,9]", attached l_video.video_info as l_aspect_ratio and then l_aspect_ratio ~ [16,9])
						if attached {LIST[TWITTER_VIDEO_VARIANTS]} l_video.variants as l_variants then
							if attached {TWITTER_VIDEO_VARIANTS} l_variants.first as l_first then
								assert ("bitrate = 2176000", attached l_first.bitrate as l_bitrate and then l_bitrate = 2176000)
								assert ("content_type = video\/mp4", attached l_first.content_type as l_content_type and then l_content_type.same_string ("video\/mp4"))
								assert ("Expected url", attached l_first.url as l_url and then l_url.same_string ("https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/1280x720\/c4E56sl91ZB7cpYi.mp4"))
							end
							if attached {TWITTER_VIDEO_VARIANTS} l_variants.last as l_last then
								assert ("bitrate = 0", attached l_last.bitrate as l_bitrate and then l_bitrate = 0)
								assert ("content_type = application\/x-mpegURL", attached l_last.content_type as l_content_type and then l_content_type.same_string ("application\/x-mpegURL"))
								assert ("Expected url", attached l_last.url as l_url and then l_url.same_string ("https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/pl\/r1kgzh5PmLgium3-.m3u8"))
							end
						end
					end
					assert ("Diaplay Url", attached l_extended_entity.display_url as l_durl and then l_durl.same_string ("pic.twitter.com\/31JoMS50ha") )
					assert ("Expanded Url", attached l_extended_entity.expanded_url as l_eurl and then l_eurl.same_string ("http:\/\/twitter.com\/twitter\/status\/560070183650213889\/video\/1") )
					assert ("Expec indices", attached l_extended_entity.indices as l_indices and then l_indices ~ [110,132])

				end
			else
				assert("Check implementation", False)
			end
		end


feature -- Twitter JSON Examples


	video_variant_json: STRING = "[
		{
			"bitrate": 2176000,
			"content_type": "video\/mp4",
			"url": "https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/1280x720\/c4E56sl91ZB7cpYi.mp4"
		}
	]"

	size_entity_json: STRING ="[
		{
         "h": 576,
         "resize": "fit",
         "w": 1024
       }
	]"


	url_entity_json: STRING = "[
		{
      	"url": "https:\/\/t.co\/XdXRudPXH5",
      	"expanded_url": "https:\/\/blog.twitter.com\/2013\/rich-photo-experience-now-in-embedded-tweets-3",
      	"display_url": "blog.twitter.com\/2013\/rich-phot\u2026",
      	"indices": [80, 103]
    	}
	]"

	symbol_entity_json: STRING = "[
 		{
        "text": "COKE",
        "indices": [
          8,
          13
        ]
      }
	]"

	hashtags_entity_json: STRING = "[
		{
		"text": "devnestSF",
	      "indices":[
	        6,
	        16
	      ]
		}
	]"


	user_mentions_json: STRING = "[
		{
	      "screen_name": "TwitterEng",
	      "name": "Twitter Engineering",
	      "id": 6844292,
	      "id_str": "6844292",
	      "indices": [81, 92]
  	  }
	]"

	sizes_entity_json: STRING = "[
			{
               "medium": {
                   "w": 600,
                   "h": 450,
                   "resize": "fit"
               },
               "large": {
                   "w": 1024,
                   "h": 768,
                   "resize": "fit"
               },
               "thumb": {
                   "w": 150,
                   "h": 150,
                   "resize": "crop"
               },
               "small": {
                   "w": 340,
                   "h": 255,
                   "resize": "fit"
               }
            }
	]"


	video_entities_json: STRING = "[
	{
       "aspect_ratio": [
         16,
         9
       ],
       "duration_millis": 30033,
       "variants": [
         {
           "bitrate": 2176000,
           "content_type": "video\/mp4",
           "url": "https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/1280x720\/c4E56sl91ZB7cpYi.mp4"
         },
         {
           "bitrate": 320000,
           "content_type": "video\/mp4",
           "url": "https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/320x180\/nXXsvs7vOhcMivwl.mp4"
         },
         {
           "bitrate": 832000,
           "content_type": "video\/mp4",
           "url": "https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/640x360\/vmLr5JlVs2kBLrXS.mp4"
         },
         {
           "content_type": "application\/x-mpegURL",
           "url": "https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/pl\/r1kgzh5PmLgium3-.m3u8"
         }
     }

]"

	extended_entities_json: STRING = "[
{
     "display_url": "pic.twitter.com\/31JoMS50ha",
     "expanded_url": "http:\/\/twitter.com\/twitter\/status\/560070183650213889\/video\/1",
     "features": {

     },
     "id": 5.6007013197639e+17,
     "id_str": "560070131976392705",
     "indices": [
       110,
       132
     ],
     "media_url": "http:\/\/pbs.twimg.com\/ext_tw_video_thumb\/560070131976392705\/pu\/img\/TcG_ep5t-iqdLV5R.jpg",
     "media_url_https": "https:\/\/pbs.twimg.com\/ext_tw_video_thumb\/560070131976392705\/pu\/img\/TcG_ep5t-iqdLV5R.jpg",
     "sizes": {
       "large": {
         "h": 576,
         "resize": "fit",
         "w": 1024
       },
       "medium": {
         "h": 337,
         "resize": "fit",
         "w": 600
       },
       "small": {
         "h": 191,
         "resize": "fit",
         "w": 340
       },
       "thumb": {
         "h": 150,
         "resize": "crop",
         "w": 150
       }
     },
     "type": "video",
     "url": "http:\/\/t.co\/31JoMS50ha",
     "video_info": {
       "aspect_ratio": [
         16,
         9
       ],
       "duration_millis": 30033,
       "variants": [
         {
           "bitrate": 2176000,
           "content_type": "video\/mp4",
           "url": "https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/1280x720\/c4E56sl91ZB7cpYi.mp4"
         },
         {
           "bitrate": 320000,
           "content_type": "video\/mp4",
           "url": "https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/320x180\/nXXsvs7vOhcMivwl.mp4"
         },
         {
           "bitrate": 832000,
           "content_type": "video\/mp4",
           "url": "https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/vid\/640x360\/vmLr5JlVs2kBLrXS.mp4"
         },
         {
           "content_type": "application\/x-mpegURL",
           "url": "https:\/\/video.twimg.com\/ext_tw_video\/560070131976392705\/pu\/pl\/r1kgzh5PmLgium3-.m3u8"
         }
       ]
     }
   }

	]"

end


