note
	description: "[
		Constants for the text panel widgets
		]" 
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_PANEL_CONSTANTS

feature -- Buffer size

	default_buffered_drawable_width: INTEGER = 15_000

	default_buffered_drawable_height: INTEGER = 15_000
		-- Default size of `drawable' used for scrolling purposes.
		--| This value used to be 32000 but on gtk post 2.10.6 there seems to be some sort of 'fix' that gives odd results
		--| with the line number code that means that they do not get displayed correctly

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
