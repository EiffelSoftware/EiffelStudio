note
	description: "Object that represent the size of a Twitter media."
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_SIZE_ENTITY


feature -- Access

	width: INTEGER
			--	Width in pixels of this size. Example:
			-- "w":150

	resize: detachable STRING
			-- Resizing method used to obtain this size.
			-- A value of fit``means that the media was resized to fit one dimension, keeping its native aspect ratio.
			-- A value of ``crop means that the media was cropped in order to fit a specific resolution. Example:
			--"resize":"crop"

	height: INTEGER
			-- Height in pixels of this size.
			-- Example:"h":150

feature -- Element change

	set_width (a_w: like width)
			-- Assign `width' with `a_w'.
		do
			width := a_w
		ensure
			w_assigned: width = a_w
		end

	set_resize (a_resize: like resize)
			-- Assign `resize' with `a_resize'.
		do
			resize := a_resize
		ensure
			resize_assigned: resize = a_resize
		end

	set_height (a_h: like height)
			-- Assign `height' with `a_h'.
		do
			height := a_h
		ensure
			h_assigned: height = a_h
		end

end
