indexing
	description: "Eiffel Vision menu bar. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_BAR_I
	
inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end
		
feature -- Status report

	parent: EV_WINDOW is
			-- Parent of `Current'.
		deferred
		end
		

feature {EV_ANY} -- Implementation

	interface: EV_MENU_BAR;	

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




end -- class EV_MENU_BAR_I

