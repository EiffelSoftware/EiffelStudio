note
	description: "[
					Emuration for OLE Internet Explorer page actions
																		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application, accelerator, event loop"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_OLE_IE_PAGE_ACTIONS

feature -- Emurations

	move_back: INTEGER is 0
		-- Move back to the previously viewed web page

	move_forward: INTEGER is 1
		-- Move forward to the previously viewed web page

	move_to_home: INTEGER is 2
		-- Move to the home page

	search: INTEGER is 3
		-- Search

	refresh: INTEGER is 4
		-- Refresh the page

	stop: INTEGER is 5
		-- Stop the currently loading page	

feature -- Contract support

	is_valid (a_integer: INTEGER): BOOLEAN
			-- If `a_integer' valid?
		do
			Result := a_integer = move_back or
						a_integer = move_forward or
						a_integer = move_to_home or
						a_integer = search or
						a_integer = refresh or
						a_integer = stop
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_OLE_IE_PAGE_ACTIONS
