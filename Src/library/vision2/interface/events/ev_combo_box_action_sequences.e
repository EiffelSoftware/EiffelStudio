indexing
	description:
		"Action sequences for EV_COMBO_BOX."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date"
	revision: "$Revision"

deferred class
	 EV_COMBO_BOX_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_COMBO_BOX_ACTION_SEQUENCES_I

feature -- Event handling


	drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE is
		obsolete "Use `list_shown_actions' instead."
			-- Actions to be performed when drop down list is displayed.
		do
			Result := implementation.drop_down_actions
		ensure
			not_void: Result /= Void
		end
		
	list_shown_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when drop down list is shown.
		do
			Result := implementation.drop_down_actions
		ensure
			not_void: Result /= Void
		end
		
	list_hidden_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when drop down list is hidden.
		do
			Result := implementation.list_hidden_actions
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

