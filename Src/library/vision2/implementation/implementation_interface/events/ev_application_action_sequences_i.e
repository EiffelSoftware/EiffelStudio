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


feature -- Event handling

	cancel_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a PND is cancelled
		do
			if cancel_actions_internal = Void then
				cancel_actions_internal :=
					 create_cancel_actions
			end
			Result := cancel_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_cancel_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a cancel action sequence.
		deferred
		end

	cancel_actions_internal: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `cancel_actions'.

feature -- Event handling

	pnd_motion_actions: EV_PND_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer is moved,
			-- during a pick and drop.
		do
			if pnd_motion_actions_internal = Void then
				pnd_motion_actions_internal := create_pnd_motion_actions
			end
			Result := pnd_motion_actions_internal
		ensure
			not_void: Result /= Void
		end

	uncaught_exception_actions: ACTION_SEQUENCE [TUPLE [EXCEPTION]] is
		-- Actions to be performed when an
		-- action sequence called via callback
		-- from the underlying toolkit raises an
		-- exception that is not caught
		do
			if uncaught_exception_actions_internal = Void then
				create uncaught_exception_actions_internal
			end
			Result := uncaught_exception_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pnd_motion_actions: EV_PND_MOTION_ACTION_SEQUENCE is
			-- Create a pnd motion action sequence.
		deferred
		end

	pnd_motion_actions_internal: EV_PND_MOTION_ACTION_SEQUENCE
		-- Implementation of once per object `pnd_motion_actions'.

	uncaught_exception_actions_internal: ACTION_SEQUENCE [TUPLE [EXCEPTION]]
		-- Implementation of once per object `uncaught_exception_actions'.

feature

	pointer_motion_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]] is
			-- Actions to be performed when screen pointer moves.
		do
			if pointer_motion_actions_internal = Void then
				pointer_motion_actions_internal :=
					 create_pointer_motion_actions
			end
			Result := pointer_motion_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_motion_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]] is
			-- Create a pointer_motion action sequence.
		deferred
		end

	pointer_motion_actions_internal: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_motion_actions'.

feature -- Event handling

	pointer_button_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when screen pointer button is pressed.
		do
			if pointer_button_press_actions_internal = Void then
				pointer_button_press_actions_internal :=
					 create_pointer_button_press_actions
			end
			Result := pointer_button_press_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_button_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Create a pointer_button_press action sequence.
		deferred
		end

	pointer_button_press_actions_internal: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_button_press_actions'.


feature -- Event handling

	pointer_double_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when screen pointer is double clicked.
		do
			if pointer_double_press_actions_internal = Void then
				pointer_double_press_actions_internal :=
					 create_pointer_double_press_actions
			end
			Result := pointer_double_press_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_double_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Create a pointer_double_press action sequence.
		deferred
		end

	pointer_double_press_actions_internal: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_double_press_actions'.


feature -- Event handling

	pointer_button_release_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when screen pointer button is released.
		do
			if pointer_button_release_actions_internal = Void then
				pointer_button_release_actions_internal :=
					 create_pointer_button_release_actions
			end
			Result := pointer_button_release_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_button_release_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Create a pointer_button_release action sequence.
		deferred
		end

	pointer_button_release_actions_internal: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_button_release_actions'.

feature -- Event handling

	mouse_wheel_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]] is
			-- Actions to be performed when mouse wheel is rotated.
		do
			if mouse_wheel_actions_internal = Void then
				mouse_wheel_actions_internal := create_mouse_wheel_actions
			end
			Result := mouse_wheel_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_mouse_wheel_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]] is
			-- Create a mouse_wheel action sequence.
		deferred
		end

	mouse_wheel_actions_internal: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]]
			-- Implementation of once per object `mouse_wheel_actions'.

feature -- Event handling

	key_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]] is
			-- Actions to be performed when a keyboard key is pressed.
		do
			if key_press_actions_internal = Void then
				key_press_actions_internal :=
					 create_key_press_actions
			end
			Result := key_press_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_key_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]] is
			-- Create a key_press action sequence.
		deferred
		end

	key_press_actions_internal: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Implementation of once per object `key_press_actions'.


feature -- Event handling

	key_press_string_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING]] is
			-- Actions to be performed when a keyboard press generates a displayable character.
		do
			if key_press_string_actions_internal = Void then
				key_press_string_actions_internal :=
					 create_key_press_string_actions
			end
			Result := key_press_string_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_key_press_string_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING]] is
			-- Create a key_press_string action sequence.
		deferred
		end

	key_press_string_actions_internal: ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING]]
			-- Implementation of once per object `key_press_string_actions'.


feature -- Event handling

	key_release_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]] is
			-- Actions to be performed when a keyboard key is released.
		do
			if key_release_actions_internal = Void then
				key_release_actions_internal :=
					 create_key_release_actions
			end
			Result := key_release_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_key_release_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]] is
			-- Create a key_release action sequence.
		deferred
		end

	key_release_actions_internal: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Implementation of once per object `key_release_actions'.

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

