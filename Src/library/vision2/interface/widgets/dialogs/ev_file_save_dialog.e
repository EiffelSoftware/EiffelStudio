indexing 
	description:
		"Eiffel Vision file save dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_SAVE_DIALOG

inherit
	EV_FILE_DIALOG
		rename
			ok_actions as save_actions
		redefine
			implementation
		end

create
	default_create,
	make_with_title
	
feature -- Event handling

	ok_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when user clicks Save.
		obsolete
			"This has been replaced by save_actions"
		do
			Result := save_actions
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY, EV_ANY_I} -- Implementation
	
	implementation: EV_FILE_SAVE_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_FILE_SAVE_DIALOG_IMP} implementation.make (Current)
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




end -- class EV_FILE_SAVE_DIALOG

