indexing
	description: "Objects that save all floating zone information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_ZONE_DATA

create
	make

feature {NONE} -- Initlization

	make (a_screen_x, a_screen_y: INTEGER) is
			--
		do
			screen_x := a_screen_x
			screen_y := a_screen_y
		ensure
			set_x: screen_x = a_screen_x
			set_y: screen_y = a_screen_y
		end

feature -- States report

	screen_x: INTEGER

	screen_y: INTEGER;
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




end
