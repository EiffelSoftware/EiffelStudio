indexing
	description: "Display text with a special color"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAY_TEXT

inherit
	WEL_STATIC
		redefine
			background_color,
			foreground_color
		end

create
	make

feature
	
	background_color: WEL_COLOR_REF is
			-- Background color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make 
		end
			
	foreground_color: WEL_COLOR_REF is
			-- Foreground color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make
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


end --class DISPLAY_TEXT
