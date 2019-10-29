note
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

	file_drop_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [LIST [STRING_32]]]
			-- Actions to be performed when an OS file drop occurs on `Current'.
		do
			if attached file_drop_actions_internal as l_result then
				Result := l_result
			else
				create Result
				init_file_drop_actions (Result)
				file_drop_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	file_drop_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [LIST [STRING_32]]]
			-- Implementation of once per object `file_drop_actions'.
		note
			option: stable
		attribute
		end

	init_file_drop_actions (a_file_drop_actions: like file_drop_actions)
			-- Initialize `a_file_drop_actions' accordingly to the current widget.
		deferred
		end

feature -- Event handling

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer moves.
		do
			if attached pointer_motion_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pointer_motion_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: detachable EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_motion_actions'.
		note
			option: stable
		attribute
		end


feature -- Event handling

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is pressed.
		do
			if attached pointer_button_press_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pointer_button_press_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_button_press_actions_internal: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_press_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is double clicked.
		do
			if attached pointer_double_press_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pointer_double_press_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_double_press_actions_internal: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_double_press_actions'.
		note
			option: stable
		attribute
		end


feature -- Event handling

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is released.
		do
			if attached pointer_button_release_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pointer_button_release_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_button_release_actions_internal: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_release_actions'.
		note
			option: stable
		attribute
		end


feature -- Event handling

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer enters widget.
		do
			if attached pointer_enter_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pointer_enter_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_enter_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_enter_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	mouse_wheel_actions: EV_INTEGER_ACTION_SEQUENCE
			-- Actions to be performed when mouse wheel is rotated.
		do
			if attached mouse_wheel_actions_internal as l_result then
				Result := l_result
			else
				create Result
				mouse_wheel_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	mouse_wheel_actions_internal: detachable EV_INTEGER_ACTION_SEQUENCE
			-- Implementation of once per object `mouse_wheel_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer leaves widget.
		do
			if attached pointer_leave_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pointer_leave_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_leave_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_leave_actions'.
		note
			option: stable
		attribute
		end


feature -- Event handling

	key_press_actions: EV_KEY_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is pressed.
		do
			if attached key_press_actions_internal as l_result then
				Result := l_result
			else
				create Result
				key_press_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	key_press_actions_internal: detachable EV_KEY_ACTION_SEQUENCE
			-- Implementation of once per object `key_press_actions'.
		note
			option: stable
		attribute
		end


feature -- Event handling

	key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard press generates a displayable character.
		do
			if attached key_press_string_actions_internal as l_result then
				Result := l_result
			else
				create Result
				key_press_string_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	key_press_string_actions_internal: detachable EV_KEY_STRING_ACTION_SEQUENCE
			-- Implementation of once per object `key_press_string_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	key_release_actions: EV_KEY_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is released.
		do
			if attached key_release_actions_internal as l_result then
				Result := l_result
			else
				create Result
				key_release_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	key_release_actions_internal: detachable EV_KEY_ACTION_SEQUENCE
			-- Implementation of once per object `key_release_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is gained.
		do
			if attached focus_in_actions_internal as l_result then
				Result := l_result
			else
				create Result
				focus_in_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	focus_in_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `focus_in_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is lost.
		do
			if attached focus_out_actions_internal as l_result then
				Result := l_result
			else
				create Result
				focus_out_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	focus_out_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `focus_out_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	resize_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Actions to be performed when size changes.
		do
			if attached resize_actions_internal as l_result then
				Result := l_result
			else
				create Result
				init_resize_actions (Result)
				resize_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	dpi_changed_actions: EV_DPI_ACTION_SEQUENCE
			-- Actions to be performed when dpi changes.
		do
			if attached dpi_changed_actions_internal as l_result then
				Result := l_result
			else
				create Result
				init_dpi_changed_actions (Result)
				dpi_changed_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	resize_actions_internal: detachable EV_GEOMETRY_ACTION_SEQUENCE
			-- Implementation of once per object `resize_actions'.
		note
			option: stable
		attribute
		end

	init_resize_actions (a_resize_actions: like resize_actions)
			-- Initialize `a_resize_actions' accordingly to the current widget.
		deferred
		end


	dpi_changed_actions_internal: detachable EV_DPI_ACTION_SEQUENCE
			-- Implementation of once per object `dpi_changed_actions'.
		note
			option: stable
		attribute
		end

	init_dpi_changed_actions (a_dpi_changed_actions: like dpi_changed_actions)
			-- Initialize `a_dpi_changed_actions' accordingly to the current widget.
		deferred
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












