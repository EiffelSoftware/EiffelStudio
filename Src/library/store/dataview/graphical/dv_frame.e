indexing
	description: "Frame container for one display element"
	date: "$Date$"
	revision: "$Revision$"

class
	DV_FRAME

inherit
	EV_FRAME
		redefine
			make_with_text
		end

create
	make_with_text

feature -- Initialization

	make_with_text (title: STRING) is
			-- Initialize.
		do
			Precursor (title)
			set_foreground_color (default_title_color)
		end

feature -- Status report

	set_default_title_color (new_title_color: EV_COLOR) is
			-- Set `new_title_color' as default title color.
			-- Set frame title with `new_title_color'.
		do
			default_title_color.copy (new_title_color)
			set_foreground_color (default_title_color)
		end

feature {NONE} -- Implementation

	default_title_color: EV_COLOR is
			-- Default padding.
		once
			create Result
		end

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- DISPLAY_FRAME