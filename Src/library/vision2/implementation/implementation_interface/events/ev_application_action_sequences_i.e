indexing
	description:
		"Action sequences for EV_APPLICATION_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_APPLICATION_ACTION_SEQUENCES_I


feature -- Event handling

	post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed just after application `launch'.
		do
			if post_launch_actions_internal = Void then
				post_launch_actions_internal :=
					 create_post_launch_actions
			end
			Result := post_launch_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a post_launch action sequence.
		deferred
		end

	post_launch_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `post_launch_actions'.


feature -- Event handling

	idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when the application is otherwise idle.
		do
			if idle_actions_internal = Void then
				idle_actions_internal :=
					 create_idle_actions
			end
			Result := idle_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a idle action sequence.
		deferred
		end

	idle_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `idle_actions'.


feature -- Event handling

	pick_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when any "pick" occurs.
		do
			if pick_actions_internal = Void then
				pick_actions_internal :=
					 create_pick_actions
			end
			Result := pick_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pick_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a pick action sequence.
		deferred
		end

	pick_actions_internal: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `pick_actions'.


feature -- Event handling

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when any "drop" occurs.
		do
			if drop_actions_internal = Void then
				drop_actions_internal :=
					 create_drop_actions
			end
			Result := drop_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		deferred
		end

	drop_actions_internal: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `drop_actions'.

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

