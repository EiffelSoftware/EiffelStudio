indexing
	description:
		"Action sequences for EV_WINDOW."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WINDOW_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_WINDOW_ACTION_SEQUENCES_I

feature -- Event handling


	move_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Actions to be performed when window moves.
		do
			Result := implementation.move_actions
		ensure
			not_void: Result /= Void
		end


	show_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window is shown.
		do
			Result := implementation.show_actions
		ensure
			not_void: Result /= Void
		end
		
	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed whan a request to close window
			-- has been received.
		do
			Result := implementation.close_request_actions
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

