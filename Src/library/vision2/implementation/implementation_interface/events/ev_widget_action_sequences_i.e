indexing
	description:
		"Action sequences for EV_WIDGET_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WIDGET_ACTION_SEQUENCES_I


feature -- Event handling

	file_drop_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [LIST [STRING_32]]] is
			-- Actions to be performed when an OS file drop occurs on `Current'.
		do
			if file_drop_actions_internal = Void then
				create file_drop_actions_internal
			end
			Result := file_drop_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	file_drop_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [LIST [STRING_32]]]
			-- Implementation of once per object `file_drop_actions'.

feature -- Event handling

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer moves.
		do
			if pointer_motion_actions_internal = Void then
				pointer_motion_actions_internal := create_pointer_motion_actions
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

	mouse_wheel_actions: EV_INTEGER_ACTION_SEQUENCE is
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

	create_mouse_wheel_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a mouse_wheel action sequence.
		deferred
		end

	mouse_wheel_actions_internal: EV_INTEGER_ACTION_SEQUENCE
			-- Implementation of once per object `mouse_wheel_actions'.

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

	focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE is
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

	create_focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a focus_in action sequence.
		deferred
		end

	focus_in_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `focus_in_actions'.


feature -- Event handling

	focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE is
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

	create_focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a focus_out action sequence.
		deferred
		end

	focus_out_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
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

	resize_actions_internal: EV_GEOMETRY_ACTION_SEQUENCE;
			-- Implementation of once per object `resize_actions'.

indexing
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

