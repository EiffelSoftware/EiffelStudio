indexing
	description:
		"Action sequences for EV_APPLICATION."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_APPLICATION_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_APPLICATION_ACTION_SEQUENCES_I

feature -- Event handling

	post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed just after application `launch'.
		do
			Result := implementation.post_launch_actions
		ensure
			not_void: Result /= Void
		end

	idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when the application is otherwise idle.
		do
			Result := implementation.idle_actions
		ensure
			not_void: Result /= Void
		end

	pick_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when any "pick" occurs.
		do
			Result := implementation.pick_actions
		ensure
			not_void: Result /= Void
		end

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when any "drop" occurs.
		do
			Result := implementation.drop_actions
		ensure
			not_void: Result /= Void
		end
		
	cancel_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a PND is cancelled.
			-- A cancel may be initiated in a number of ways depending on the transport
			-- type, including attempting to drop on a target that does not accept
			-- transported pebble.
		do
			Result := implementation.cancel_actions
		ensure
			not_void: Result /= Void
		end
		
	pnd_motion_actions: EV_PND_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer is moved,
			-- during a pick and drop. The "pick and drop" argument
			-- is the current EV_ABSTRACT_PICK_AND_DROPABLE below the
			-- pointer position, or Void if the `drop_actions' for this
			-- item are empty.
		do
			Result := implementation.pnd_motion_actions
		ensure
			not_void: Result /= Void
		end

	uncaught_exception_actions: ACTION_SEQUENCE [TUPLE [EXCEPTION]] is
		-- Actions to be performed when an
		-- action sequence called via callback
		-- from the underlying toolkit raises an
		-- exception that is not caught
		do
			Result := implementation.uncaught_exception_actions
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

