indexing
	description: "EV_FACK_FOCUS_DIALOG Windows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FACK_FOCUS_DIALOG_IMP_MODELESS

inherit
	EV_UNTITLED_DIALOG_IMP_MODELESS

	EV_FACK_FOCUS_GROUPABLE
		rename
			item as wel_item
		end

create
	make_with_dialog_window

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
