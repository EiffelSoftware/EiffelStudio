note
	description: "Action sequences for EV_CHECKABLE_TREE_I"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CHECKABLE_TREE_ACTION_SEQUENCES_I

feature -- Event handling

	check_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Actions to be performed when an item is checked.
		do
			if check_actions_internal = Void then
				check_actions_internal :=
					 create_check_actions
			end
			Result := check_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_check_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Create a check action sequence.
		deferred
		end

	check_actions_internal: detachable EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Implementation of once per object `check_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	uncheck_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Actions to be performed when an item is unchecked.
		do
			if uncheck_actions_internal = Void then
				uncheck_actions_internal :=
					 create_uncheck_actions
			end
			Result := uncheck_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_uncheck_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Create a uncheck action sequence.
		deferred
		end

	uncheck_actions_internal: detachable EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Implementation of once per object `uncheck_actions'.
		note
			option: stable
		attribute
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_CHECKABLE_TREE_ACTION_SEQUENCES_I












