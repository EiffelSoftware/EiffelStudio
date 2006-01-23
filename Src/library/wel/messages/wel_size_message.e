indexing
	description: "Information about message Wm_size which is sent to a %
		%window after its size has changed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SIZE_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Access

	size_type: INTEGER is
			-- Type of resizing requested.
			-- See class WEL_SIZE_CONSTANTS for different values.
		do
			Result := w_param.to_integer_32
		end

	width: INTEGER is
			-- New width of the client area
		do
			Result := cwin_lo_word (l_param)
		end

	height: INTEGER is
			-- New height of the client area
		do
			Result := cwin_hi_word (l_param)
		end

feature -- Status report

	maximized: BOOLEAN is
			-- Has the window been maximized?
		do
			Result := size_type = Size_maximized
		end

	minimized: BOOLEAN is
			-- Has the window been minimized?
		do
			Result := size_type = Size_minimized
		end

	restored: BOOLEAN is
			-- Has the window been restored?
		do
			Result := size_type = Size_restored
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




end -- class WEL_SIZE_MESSAGE

