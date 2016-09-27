note
	description:
		"Action sequences for EV_APPLICATION_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_APPLICATION_ACTION_SEQUENCES_I

feature -- Event handling

	post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed just after application `launch'.
		do
			if attached post_launch_actions_internal as l_result then
				Result := l_result
			else
				create Result
				post_launch_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	post_launch_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `post_launch_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when the application is otherwise idle.
		do
			if attached idle_actions_internal as l_result then
				Result := l_result
			else
				create Result
				idle_actions_internal := Result
			end
		end

	kamikaze_actions: ARRAYED_LIST [separate PROCEDURE]
			-- Actions to be performed once when the application is otherwise idle.
			-- Allows for separate agents coming from other processors that may want to be called when the application is idle
			-- via 'do_once_on_idle'.

feature {EV_ANY_I} -- Implementation

	idle_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `idle_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	pick_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when any "pick" occurs.
		do
			if attached pick_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pick_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pick_actions_internal: detachable EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `pick_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when any "drop" occurs.
		do
			if attached drop_actions_internal as l_result then
				Result := l_result
			else
				create Result
				drop_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	drop_actions_internal: detachable EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `drop_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	cancel_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when a PND is cancelled
		do
			if attached cancel_actions_internal as l_result then
				Result := l_result
			else
				create Result
				cancel_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	cancel_actions_internal: detachable EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `cancel_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	pnd_motion_actions: EV_PND_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is moved,
			-- during a pick and drop.
		do
			if attached pnd_motion_actions_internal as l_result then
				Result := l_result
			else
				create Result
				pnd_motion_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	file_drop_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; file_list: LIST [STRING_32]]]
			-- Actions to be performed when an OS file drop is performed on `Current'.
			-- `widget' is the widget on which the file(s) where dropped on to.
			-- `file_list' is a list of the file paths being dropped on to `widget'.
			-- In order for `file_drop_actions' to be called an agent has to be already
			-- present in the `file_drop_actions' of `widget' otherwise a drop is disallowed.
		do
			if attached file_drop_actions_internal as l_result then
				Result := l_result
			else
				create Result
				file_drop_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	uncaught_exception_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EXCEPTION]]
		-- Actions to be performed when an
		-- action sequence called via callback
		-- from the underlying toolkit raises an
		-- exception that is not caught
		do
			if attached uncaught_exception_actions_internal as l_result then
				Result := l_result
			else
				create Result
				uncaught_exception_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pnd_motion_actions_internal: detachable like pnd_motion_actions
		-- Implementation of once per object `pnd_motion_actions'.
		note
			option: stable
		attribute
		end

	file_drop_actions_internal: detachable like file_drop_actions
		-- Implementation of once per object `file_drop_actions'.
		note
			option: stable
		attribute
		end

	uncaught_exception_actions_internal: detachable like uncaught_exception_actions
		-- Implementation of once per object `uncaught_exception_actions'.
		note
			option: stable
		attribute
		end

feature

	pointer_motion_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]]
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

	pointer_motion_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_motion_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	pointer_button_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
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

	pointer_button_press_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_button_press_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	pointer_double_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
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

	pointer_double_press_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_double_press_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	pointer_button_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
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

	pointer_button_release_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_button_release_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	mouse_wheel_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]]
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

	mouse_wheel_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]]
			-- Implementation of once per object `mouse_wheel_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	key_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
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

	key_press_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Implementation of once per object `key_press_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	key_press_string_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING_32]]
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

	key_press_string_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING_32]]
			-- Implementation of once per object `key_press_string_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	key_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
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

	key_release_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Implementation of once per object `key_release_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	focus_in_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed when getting focus.
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

	focus_in_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Implementation of once per object `focus_in_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	focus_out_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed when losing focus.
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

	focus_out_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Implementation of once per object `focus_out_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	theme_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when operating system theme changed.
		do
			if attached theme_changed_actions_internal as l_result then
				Result := l_result
			else
				create Result
				theme_changed_actions_internal := Result
			end
		end

feature {EV_ANY_I} -- Implementation

	theme_changed_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `theme_changed_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	system_color_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen color depth changed.
		do
			if attached system_color_change_actions_internal as l_result then
				Result := l_result
			else
				create Result
				system_color_change_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	system_color_change_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `system_color_change_actions'.
		note
			option: stable
		attribute
		end;

feature -- Event handling

	destroy_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when current application is destroying.
		do
			if attached destroy_actions_internal as l_result then
				Result := l_result
			else
				create Result
				destroy_actions_internal := Result
			end
		end

feature {EV_ANY_I}	-- Implementation

	destroy_actions_internal: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Impplementation of once per object `destroy_actions'
		note
			option: stable
		attribute
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end











