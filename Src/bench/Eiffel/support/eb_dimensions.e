indexing
	description:
		"A dimension in a 2 dimensional space as INTEGERs (width, height)"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DIMENSIONS

create
	default_create,
	set

feature -- Access

	width: INTEGER
			-- Horizontal dimension.

	height: INTEGER
			-- Vertical dimension.

feature -- Element change

	set (a_width, a_height: INTEGER) is
			-- Assign `a_width' to `width' and `a_height' to `height'.
		do
			width := a_width
			height := a_height
		ensure
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		do
			width := a_width
		ensure
			width_assigned: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Assign `a_height' to `height'.
		do
			height := a_height
		ensure
			height_assigned: height = a_height
		end
		
end -- class EB_DIMENSIONS
