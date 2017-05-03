note
	description: "[
					An EV_POSTSCRIPT_DRAWABLE can be used to generate a 
					postscript file. Draw to the drawable as to every other
					drawable and call save_to_named_file when you are done.
					You can set the page size and its orientation with
					set_page_size. Use EV_POSTSCRIPT_PAGE_CONSTANTS to 
					get the right size (default is Letter and Portrait). Besides
					the page size you can also set the size of the drawable
					with set_size. If the size is larger then the page size
					the drawable will be outputed to multiple pages when
					calling save_to_named_file. The clip area can span over
					multiple pages. This drawable does not support tile and
					drawing_mode (always copy mode).
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POSTSCRIPT_DRAWABLE

inherit
	EV_DRAWABLE
		redefine
			implementation
		end

feature -- Measurement

	width: INTEGER
			-- Horizontal size in pixels.
		do
			Result := implementation.width
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			Result := implementation.height
		end

feature -- Element change

	set_size (a_width, a_height: INTEGER)
			-- set `width' to `a_width' and `height' to `a_height'.
		require
			positive: a_width >= 0 and a_height >= 0
		do
			implementation.set_size (a_width, a_height)
		ensure
			set: width = a_width and height = a_height
		end

	add_postscript_line (line: READABLE_STRING_GENERAL)
			-- Add `line' to the postscript drawable.
		require
			line_exists: line /= Void
		do
			implementation.add_ps (line)
		end

feature -- Commands

	save_to_named_file (a_filename: READABLE_STRING_GENERAL)
			-- Save `Current' to `a_filename'.
		obsolete
			"Use `save_to_named_path' instead. [2017-05-31]"
		do
			save_to_named_path (create {PATH}.make_from_string (a_filename))
		end

	save_to_named_path (a_filename: PATH)
			-- Save `Current' to `a_filename'.
		do
			implementation.save_to_named_path (a_filename)
		end

feature -- Status Settings

	set_margins (a_left_margin, a_bottom_margin: INTEGER)
			-- Set `left' and `bottom' margins to `a_left_margin'
			-- and `a_bottom_margin'.
		require
			a_left_margin_not_negative: a_left_margin >= 0
			a_bottom_margin_not_negative: a_bottom_margin >= 0
		do
			implementation.set_margins (a_left_margin, a_bottom_margin)
		ensure
			left_set: implementation.left_margin = a_left_margin
			bottom_set: implementation.bottom_margin = a_bottom_margin
		end

	set_page_size (a_size: INTEGER; landscape: BOOLEAN)
			-- Set horizontal and vertical dimensions of page.
		do
			implementation.set_page_size (a_size, landscape)
		end

feature {EV_ANY} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- Create `implementation'.
			-- Must be defined in each descendant to create the
			-- appropriate `implementation' object.
		do
			implementation := create {EV_POSTSCRIPT_DRAWABLE_IMP}.make
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_POSTSCRIPT_DRAWABLE_IMP;

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_POSTSCRIPT_DRAWABLE





