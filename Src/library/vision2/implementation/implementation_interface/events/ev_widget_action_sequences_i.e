indexing
	description:
		"Action sequences for EV_WIDGET_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WIDGET_ACTION_SEQUENCES_I


feature -- Event handling

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
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

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
		deferred
		end

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_motion_actions'.


feature -- Event handling

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
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

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_button_press action sequence.
		deferred
		end

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_press_actions'.


feature -- Event handling

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
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

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_double_press action sequence.
		deferred
		end

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_double_press_actions'.


feature -- Event handling

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
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

	create_pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_button_release action sequence.
		deferred
		end

	pointer_button_release_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_release_actions'.


feature -- Event handling

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer enters widget.
		do
			if pointer_enter_actions_internal = Void then
				pointer_enter_actions_internal :=
					 create_pointer_enter_actions
			end
			Result := pointer_enter_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_enter action sequence.
		deferred
		end

	pointer_enter_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_enter_actions'.


feature -- Event handling

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer leaves widget.
		do
			if pointer_leave_actions_internal = Void then
				pointer_leave_actions_internal :=
					 create_pointer_leave_actions
			end
			Result := pointer_leave_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_leave action sequence.
		deferred
		end

	pointer_leave_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_leave_actions'.


feature -- Event handling

	key_press_actions: EV_KEY_ACTION_SEQUENCE is
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

	create_key_press_actions: EV_KEY_ACTION_SEQUENCE is
			-- Create a key_press action sequence.
		deferred
		end

	key_press_actions_internal: EV_KEY_ACTION_SEQUENCE
			-- Implementation of once per object `key_press_actions'.


feature -- Event handling

	key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE is
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

	create_key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE is
			-- Create a key_press_string action sequence.
		deferred
		end

	key_press_string_actions_internal: EV_KEY_STRING_ACTION_SEQUENCE
			-- Implementation of once per object `key_press_string_actions'.


feature -- Event handling

	key_release_actions: EV_KEY_ACTION_SEQUENCE is
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

	create_key_release_actions: EV_KEY_ACTION_SEQUENCE is
			-- Create a key_release action sequence.
		deferred
		end

	key_release_actions_internal: EV_KEY_ACTION_SEQUENCE
			-- Implementation of once per object `key_release_actions'.


feature -- Event handling

	focus_in_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is gained.
		do
			if focus_in_actions_internal = Void then
				focus_in_actions_internal :=
					 create_focus_in_actions
			end
			Result := focus_in_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_focus_in_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Create a focus_in action sequence.
		deferred
		end

	focus_in_actions_internal: EV_FOCUS_ACTION_SEQUENCE
			-- Implementation of once per object `focus_in_actions'.


feature -- Event handling

	focus_out_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is lost.
		do
			if focus_out_actions_internal = Void then
				focus_out_actions_internal :=
					 create_focus_out_actions
			end
			Result := focus_out_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_focus_out_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Create a focus_out action sequence.
		deferred
		end

	focus_out_actions_internal: EV_FOCUS_ACTION_SEQUENCE
			-- Implementation of once per object `focus_out_actions'.


feature -- Event handling

	resize_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Actions to be performed when size changes.
		do
			if resize_actions_internal = Void then
				resize_actions_internal :=
					 create_resize_actions
			end
			Result := resize_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_resize_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a resize action sequence.
		deferred
		end

	resize_actions_internal: EV_GEOMETRY_ACTION_SEQUENCE
			-- Implementation of once per object `resize_actions'.

end
