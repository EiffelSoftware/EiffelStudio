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

end

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

