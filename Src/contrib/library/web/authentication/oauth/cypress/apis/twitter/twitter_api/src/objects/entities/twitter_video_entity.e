note
	description: "Summary description for {TWITTER_VIDEO_ENTITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_VIDEO_ENTITY


feature -- Access

	variants: detachable LIST [TWITTER_VIDEO_VARIANTS]
			-- Different encodings/streams of the video. At least one variant is returned for each video entry.
			-- Video formats returned via the API are subject to change.
			-- As a best practice, developers should scan all returned values and use the most appropriate format for their given platform.
			-- This field is present only when there is a video in the payload.	

	duration_millis: INTEGER
			-- The length of the video, in milliseconds. This field is present only when there is a video in the payload.

	video_info: detachable TUPLE [INTEGER, INTEGER]
			-- Contains information about aspect ratio. The aspect ratio of the video, as a simplified fraction of width and height in a 2-element array.
			-- Typical values are [4, 3] or [16, 9]. This field is present only when there is a video in the payload.



feature -- Element Change

	set_variants (a_variants: like variants)
			-- Assign `variants' with `a_variants'.
		do
			variants := a_variants
		ensure
			variants_assigned: variants = a_variants
		end

	set_duration_millis (a_duration_millis: like duration_millis)
			-- Assign `duration_millis' with `a_duration_millis'.
		do
			duration_millis := a_duration_millis
		ensure
			duration_millis_assigned: duration_millis = a_duration_millis
		end

	set_video_info (a_video_info: like video_info)
			-- Assign `video_info' with `a_video_info'.
		do
			video_info := a_video_info
		ensure
			video_info_assigned: video_info = a_video_info
		end


end
