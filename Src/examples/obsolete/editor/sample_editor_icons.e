note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SAMPLE_EDITOR_ICONS

inherit
	EDITOR_ICONS

feature -- Cursor

	header_left_scroll_pixmap: EV_PIXMAP
		do
			create Result
		end

	header_right_scroll_pixmap: EV_PIXMAP
		do
			create Result
		end

	header_close_current_document_pixmap: EV_PIXMAP
		do
			create Result
		end

end
