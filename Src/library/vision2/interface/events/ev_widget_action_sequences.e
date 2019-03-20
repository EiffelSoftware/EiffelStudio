note
	description:
		"Action sequences for EV_WIDGET."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WIDGET_ACTION_SEQUENCES

inherit
	EV_ACTION_SEQUENCES

feature {NONE} -- Implementation

	implementation: EV_WIDGET_ACTION_SEQUENCES_I
		deferred
		end

feature -- Event handling

	file_drop_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [LIST [STRING_32]]]
			-- Actions to be performed when an OS file drop is performed on `Current'.
		do
			Result := implementation.file_drop_actions
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer moves.
		do
			Result := implementation.pointer_motion_actions
		ensure
			not_void: Result /= Void
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is pressed.
		do
			Result := implementation.pointer_button_press_actions
		ensure
			not_void: Result /= Void
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is double clicked.
		do
			Result := implementation.pointer_double_press_actions
		ensure
			not_void: Result /= Void
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is released.
		do
			Result := implementation.pointer_button_release_actions
		ensure
			not_void: Result /= Void
		end

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer enters widget.
		do
			Result := implementation.pointer_enter_actions
		ensure
			not_void: Result /= Void
		end

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer leaves widget.
		do
			Result := implementation.pointer_leave_actions
		ensure
			not_void: Result /= Void
		end

	mouse_wheel_actions: EV_INTEGER_ACTION_SEQUENCE
			-- Actions to be performed when mouse wheel is rotated.
		do
			Result := implementation.mouse_wheel_actions
		ensure
			not_void: Result /= Void
		end

	key_press_actions: EV_KEY_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is pressed.
		do
			Result := implementation.key_press_actions
		ensure
			not_void: Result /= Void
		end

	key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard press generates a displayable character.
		do
			Result := implementation.key_press_string_actions
		ensure
			not_void: Result /= Void
		end

	key_release_actions: EV_KEY_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is released.
		do
			Result := implementation.key_release_actions
		ensure
			not_void: Result /= Void
		end

	focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is gained.
		do
			Result := implementation.focus_in_actions
		ensure
			not_void: Result /= Void
		end

	focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is lost.
		do
			Result := implementation.focus_out_actions
		ensure
			not_void: Result /= Void
		end

	resize_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed when size changes.
		do
			Result := implementation.resize_actions
		ensure
			not_void: Result /= Void
		end

	dpi_changed_actions: EV_DPI_ACTION_SEQUENCE
			-- Actions to be performed when size changes.
		do
			Result := implementation.dpi_changed_actions
		ensure
			not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
