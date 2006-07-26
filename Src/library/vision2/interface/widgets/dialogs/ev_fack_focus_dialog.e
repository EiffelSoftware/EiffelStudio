indexing
	description: "[
					Dialog will let parent window title bar, borders looks like have focus.
					Actually focus is handled as normal dialog.
																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "keep focus, remain focus, dialog, dialogue, popup, window"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FACK_FOCUS_DIALOG

inherit
	EV_UNTITLED_DIALOG
		redefine
			create_implementation
		end

feature {EV_ANY_I} -- Implementation

	create_implementation is
			-- Redefine
		do
			create {EV_FACK_FOCUS_DIALOG_IMP} implementation.make (Current)
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


end
