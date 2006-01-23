indexing	
	description: "Eiffel Vision check menu. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_CHECK_MENU_ITEM_I

inherit
	EV_MENU_ITEM_I
		redefine
			interface
		end

	EV_DESELECTABLE_I
		redefine
			interface
		end

feature {NONE} -- Implementation

	interface: EV_CHECK_MENU_ITEM;

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




end -- class EV_CHECK_MENU_ITEM_I

