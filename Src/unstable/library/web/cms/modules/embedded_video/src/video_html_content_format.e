note
	description: "Summary description for {VIDEO_HTML_CONTENT_FORMAT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VIDEO_HTML_CONTENT_FORMAT

inherit

	CONTENT_FORMAT
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create filters.make (0)
			filters.force (create {VIDEO_CONTENT_FILTER})
		end

feature -- Access

	name: STRING = "video_html"

	title: STRING_8 = "Video HTML content"

	filters: ARRAYED_LIST [CONTENT_FILTER]

end
