indexing
	description:
		"Action sequences for EV_RICH_TEXT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	 EV_RICH_TEXT_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_RICH_TEXT_ACTION_SEQUENCES_I

feature -- Event handling


	caret_move_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Actions to be performed when caret position changes.
		do
			Result := implementation.caret_move_actions
		ensure
			not_void: Result /= Void
		end
		
	selection_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when selection changes.
		do
			Result := implementation.selection_change_actions
		ensure
			not_void: Result /= Void
		end
		
	file_access_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Actions to be performed while loading or saving.
			-- Event data is percentage of file written in the range (0-100).
		do
			Result := implementation.file_access_actions
		ensure
			not_void: Result /= Void
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

