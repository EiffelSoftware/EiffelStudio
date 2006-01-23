indexing
	description: "Frame container for one display element"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- DISPLAY_FRAME

