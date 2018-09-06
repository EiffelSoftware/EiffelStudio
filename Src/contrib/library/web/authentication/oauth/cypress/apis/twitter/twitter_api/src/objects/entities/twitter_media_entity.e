note
	description: "[
					Object that represent a Media Entity in an array of media attached to the Tweet with the Twitter Photo Upload feature.
					Each media entity comes with the following attributes:
	
				{
				  ...
				  "text": "Four more years. http:\/\/t.co\/bAJE6Vom",
				  "entities": {
				    "hashtags": [],
				    "symbols": [],
				    "urls": [],
				    "user_mentions": [],
				    "media": [{
				      "id": 266031293949698048,
				      "id_str": "266031293949698048",
				      "indices": [17, 37],
				      "media_url": "http:\/\/pbs.twimg.com\/media\/A7EiDWcCYAAZT1D.jpg",
				      "media_url_https": "https:\/\/pbs.twimg.com\/media\/A7EiDWcCYAAZT1D.jpg",
				      "url": "http:\/\/t.co\/bAJE6Vom",
				      "display_url": "pic.twitter.com\/bAJE6Vom",
				      "expanded_url": "http:\/\/twitter.com\/BarackObama\/status\/266031293945503744\/photo\/1",
				      "type": "photo",
				      "sizes": {
				        "medium": {
				          "w": 600,
				          "h": 399,
				          "resize": "fit"
				        },
				        "thumb": {
				          "w": 150,
				          "h": 150,
				          "resize": "crop"
				        },
				        "small": {
				          "w": 340,
				          "h": 226,
				          "resize": "fit"
				        },
				        "large": {
				          "w": 800,
				          "h": 532,
				          "resize": "fit"
				        }
				      }
				    }]
				  }
				}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name:Media Entity", "src=https://dev.twitter.com/overview/api/entities-in-twitter-objects#the-media-entity", "protocol=uri"

class
	TWITTER_MEDIA_ENTITY


feature -- Access

	indices: detachable TUPLE [INTEGER, INTEGER]
			-- The character positions the media was extracted from
			-- Maybe TUPLE [INTEGER, INTEGER] is enough

	type: detachable STRING
			-- Only photo for now

	sizes: detachable TWITTER_SIZES_ENTITY
			-- We support different sizes: thumb, small, medium and large.
			-- The media_url defaults to medium but you can retrieve the media in different sizes by appending a colon + the size key
			-- (for example: http://pbs.twimg.com/media/A7EiDWcCYAAZT1D.jpg:thumb ).
			-- Each available size comes with three attributes that describe it: w : the width (in pixels)
			-- of the media in this particular size; h : the height (in pixels) of the media
			-- in this particular size; and resize : how we resized the media to this particular size (can be crop or fit )

	expanded_url: detachable STRING
			-- The fully resolved media URL.

	display_url: detachable STRING
			-- Not a URL but a string to display instead of the media URL

	url: detachable STRING
			-- The media URL that was extracted.

	media_url_https: detachable STRING
			-- The SSL URL of the media file (see the sizes attribute for available sizes)

	media_url: detachable STRING
			-- The URL of the media file (see the sizes attribute for available sizes).

	id_str: detachable STRING
			-- the media ID String format.

	id: INTEGER_64
			-- the media ID.

feature -- Element change

	set_indices (an_indices: like indices)
			-- Assign `indices' with `an_indices'.
		do
			indices := an_indices
		ensure
			indices_assigned: indices = an_indices
		end

	set_type (a_type: like type)
			-- Assign `type' with `a_type'.
		do
			type := a_type
		ensure
			type_assigned: type = a_type
		end

	set_sizes (a_sizes: like sizes)
			-- Assign `sizes' with `a_sizes'.
		do
			sizes := a_sizes
		ensure
			sizes_assigned: sizes = a_sizes
		end

	set_expanded_url (an_expanded_url: like expanded_url)
			-- Assign `expanded_url' with `an_expanded_url'.
		do
			expanded_url := an_expanded_url
		ensure
			expanded_url_assigned: expanded_url = an_expanded_url
		end

	set_display_url (a_display_url: like display_url)
			-- Assign `display_url' with `a_display_url'.
		do
			display_url := a_display_url
		ensure
			display_url_assigned: display_url = a_display_url
		end

	set_url (an_url: like url)
			-- Assign `url' with `an_url'.
		do
			url := an_url
		ensure
			url_assigned: url = an_url
		end

	set_media_url_https (a_media_url_https: like media_url_https)
			-- Assign `media_url_https' with `a_media_url_https'.
		do
			media_url_https := a_media_url_https
		ensure
			media_url_https_assigned: media_url_https = a_media_url_https
		end

	set_media_url (a_media_url: like media_url)
			-- Assign `media_url' with `a_media_url'.
		do
			media_url := a_media_url
		ensure
			media_url_assigned: media_url = a_media_url
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

end
