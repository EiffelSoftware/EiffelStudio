indexing
	description:
		"Action sequences for EV_PICK_AND_DROPABLE."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_PICK_AND_DROPABLE_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_I

feature -- Event handling


	pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		do
			Result := implementation.pick_actions
		ensure
			not_void: Result /= Void
		end
		
	pick_ended_actions: EV_PND_FINISHED_ACTION_SEQUENCE is
			-- Actions to be performed when a transport from `Current' ends.
			-- If transport completed successfully, then event data
			-- is target. If cancelled, then event data is Void.
		do
			Result := implementation.pick_ended_actions
		ensure
			not_void: Result /= Void
		end

	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble that fits here is picked.
		do
			Result := implementation.conforming_pick_actions
		ensure
			not_void: Result /= Void
		end


	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble is dropped here.
		do
			Result := implementation.drop_actions
		ensure
			not_void: Result /= Void
		end

end

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

