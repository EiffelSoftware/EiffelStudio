indexing
	description: "Action sequences for EV_DOCKABLE_SOURCE_I."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_ACTION_SEQUENCES_I

feature -- Event handling

	dock_started_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		do
			if dock_started_actions_internal = Void then
				create dock_started_actions_internal
			end
			Result := dock_started_actions_internal
		ensure
			not_void: Result /= Void
		end
		
	dock_ended_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed after a dock completes from `Current'.
			-- Either to a dockable target or a dockable dialog.
		do
			if dock_ended_actions_internal = Void then
				create dock_ended_actions_internal
			end
			Result := dock_ended_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	dock_started_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `dock_started_actions'.
			
	dock_ended_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `dock_ended_actions'.

end -- class EV_DOCKABLE_SOURCE_ACTION_SEQUENCES_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

