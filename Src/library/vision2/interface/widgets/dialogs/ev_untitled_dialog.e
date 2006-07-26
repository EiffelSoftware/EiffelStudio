indexing
	description:
		"Same as EV_DIALOG but without title bar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "dialog, dialogue, popup, window"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG

inherit
	EV_DIALOG
		redefine
			create_implementation
		end

create
	default_create

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_UNTITLED_DIALOG_IMP} implementation.make (Current)
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




end -- class EV_UNTITLED_DIALOG

