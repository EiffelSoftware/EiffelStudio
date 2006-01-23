indexing
	description:
		"Action sequences for EV_RICH_TEXT_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	 EV_RICH_TEXT_ACTION_SEQUENCES_I


feature -- Event handling

	caret_move_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Actions to be performed when caret position changes.
		do
			if caret_move_actions_internal = Void then
				caret_move_actions_internal :=
					 create_caret_move_actions
			end
			Result := caret_move_actions_internal
		ensure
			not_void: Result /= Void
		end
		
	selection_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when selection changes.
		do
			if selection_change_actions_internal = Void then
				selection_change_actions_internal :=
					 create_selection_change_actions
			end
			Result := selection_change_actions_internal
		ensure
			not_void: Result /= Void
		end
		
	file_access_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Actions to be performed while loading or saving.
			-- Event data is percentage of file written (0-100).
		do
			if file_access_actions_internal = Void then
				file_access_actions_internal := create_file_access_actions
			end
			Result := file_access_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_caret_move_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a caret move action sequence.
		deferred
		end

	caret_move_actions_internal: EV_INTEGER_ACTION_SEQUENCE
			-- Implementation of once per object `caret_move_actions'.
			
	create_selection_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a selection change action sequence.
		deferred
		end

	selection_change_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `selection_change_actions'.
			
	create_file_access_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a file access action sequence.
		deferred
		end
		
feature {EV_ANY_I, EV_RICH_TEXT_BUFFERING_STRUCTURES_I}
		
	file_access_actions_internal: EV_INTEGER_ACTION_SEQUENCE;
			-- Implementation of once per object `file_access_actions'.

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

