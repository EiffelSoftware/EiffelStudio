note
	description: "Objects that represent action sequences for EV_GRID_COLUMN."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_COLUMN_ACTION_SEQUENCES
	
inherit
	REFACTORING_HELPER

feature -- Access

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Current' is selected.
		do
			Result := implementation.select_actions
		ensure
			result_not_void: Result /= Void
		end
		
	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Current' is deselected.
		do
			Result := implementation.deselect_actions
		ensure
			result_not_void: Result /= Void
		end		
			
feature {NONE} -- Implementation

	implementation: EV_GRID_COLUMN_ACTION_SEQUENCES_I;

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




end

