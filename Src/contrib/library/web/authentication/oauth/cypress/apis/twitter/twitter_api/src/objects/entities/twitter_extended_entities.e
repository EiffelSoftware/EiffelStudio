note
	description: "[
		This nested object supports various media types such as multi photos, animated gifs and video. This field also contains a lot of meta data about the type of information that is present in there; such as aspect ratio, variants, sizes, duration, bitrate etc. Each media entity comes with the following attributes:

		id	the media ID (int format)
		id_str	the media ID (string format)
		media_url	The URL of the media file (see the sizes attribute for available sizes)
		media_url_https	The SSL URL of the media file (see the sizes attribute for available sizes)
		url	The media URL that was extracted
		display_url	Not a URL but a string to display instead of the media URL
		expanded_url	The fully resolved media URL
		sizes	We support different sizes: thumb, small, medium and large. The media_url defaults to medium but you can retrieve the media in different sizes by appending a colon + the size key (for example: http://pbs.twimg.com/media/A7EiDWcCYAAZT1D.jpg:thumb ). Each available size comes with three attributes that describe it: w : the width (in pixels) of the media in this particular size; h : the height (in pixels) of the media in this particular size; resize : how we resized the media to this particular size (can be crop or fit )
		type	Only could be a photo, multi photos, animated gifs or videos for now.
		indices	The character positions the media was extracted from
		video_info	Contains information about aspect ratio. The aspect ratio of the video, as a simplified fraction of width and height in a 2-element array. Typical values are [4, 3] or [16, 9]. This field is present only when there is a video in the payload.
		duration_millis	The length of the video, in milliseconds. This field is present only when there is a video in the payload.
		variants	Different encodings/streams of the video. At least one variant is returned for each video entry. Video formats returned via the API are subject to change. As a best practice, developers should scan all returned values and use the most appropriate format for their given platform. This field is present only when there is a video in the payload.

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_EXTENDED_ENTITIES


feature -- Access

	video_info: detachable TWITTER_VIDEO_ENTITY
			-- Information about the video in the paylod if any.
			-- aspect ratio. duration and different encodings.

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

	set_video_info (a_video: like video_info)
			-- Assign `video_info' with `a_video'.
		do
			video_info := a_video
		ensure
			video_info_assigned: video_info = a_video
		end

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
