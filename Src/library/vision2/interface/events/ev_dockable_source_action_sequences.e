indexing
	description: "Action sequences for EV_DOCKABLE_SOURCE."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_ACTION_SEQUENCES
	
inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_DOCKABLE_SOURCE_ACTION_SEQUENCES_I

feature -- Event handling

	dock_started_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when a dockable source is dragged.
		do
			Result := implementation.dock_started_actions
		ensure
			not_void: Result /= Void
		end
		
	dock_ended_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed after a dock completes from `Current'.
			-- Either to a dockable target or a dockable dialog.
		do
			Result := implementation.dock_ended_actions
		ensure
			not_void: Result /= Void
		end
		
	
end -- class EV_DOCKABLE_SOURCE_ACTION_SEQUENCES

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------