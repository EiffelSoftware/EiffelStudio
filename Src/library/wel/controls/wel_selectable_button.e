indexing
	description: "Control that looks and acts like a button. But %
		% the button looks raised when it isn't pushed or checked,%
		% and sunken when it is pushed or checked."
	legal: "See notice at end of class."
	note: "To create this kind of button  a ressource editor,   %
		% create a checkbox and then choose the pushlike option %
		% for this checkbox"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SELECTABLE_BUTTON

inherit
	WEL_CHECK_BOX
		redefine
			default_style
		end

create
	make,
	make_by_id

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + 
				Ws_group + Ws_tabstop + Bs_autocheckbox + Bs_pushlike
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




end -- class WEL_SELECTABLE_BUTTON

