indexing
	description: "Action sequences for EV_CHECKABLE_TREE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CHECKABLE_TREE_ACTION_SEQUENCES
	
inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create, copy
		end
		
feature {NONE} -- Implementation

	implementation: EV_CHECKABLE_TREE_ACTION_SEQUENCES_I

feature -- Event handling

	check_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE is
			-- Actions to be performed when item is checked.
		do
			Result := implementation.check_actions
		ensure
			not_void: Result /= Void
		end
		
	uncheck_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE is
			-- Actions to be performed when item is unchecked.
		do
			Result := implementation.uncheck_actions
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




end -- class EV_CHECKABLE_LIST_ACTION_SEQUENCES

