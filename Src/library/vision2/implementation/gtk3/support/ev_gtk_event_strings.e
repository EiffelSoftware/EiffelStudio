note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision: 76420 $"

class
	EV_GTK_EVENT_STRINGS



feature -- Implementation

	accel_activate_string: EV_GTK_C_STRING
		once
			Result := "accel-activate"
		end

	window_state_event_string: EV_GTK_C_STRING
		once
			Result := "window-state-event"
		end

	delete_event_string: EV_GTK_C_STRING
		once
			Result := "delete-event"
		end

	key_press_event_string: EV_GTK_C_STRING
		once
			Result := "key-press-event"
		end

	key_release_event_string: EV_GTK_C_STRING
			-- key-release-event string constant
		once
			Result := "key-release-event"
		end

	focus_in_event_string: EV_GTK_C_STRING
			-- focus_in_event_string constant.
		once
			Result := "focus-in-event"
		end

	focus_out_event_string: EV_GTK_C_STRING
			-- focus_out_event_string constant.
		once
			Result := "focus-out-event"
		end

	set_focus_event_string: EV_GTK_C_STRING
			-- set_focus_event_string constant.
		once
			Result := "set-focus"
		end

	configure_event_string: EV_GTK_C_STRING
			-- configure_event_string constant.
		once
			Result := "configure-event"
		end

	map_event_string: EV_GTK_C_STRING
			-- map_event_string constant.
		once
			Result := "map_event"
		end

	enter_notify_event_string: EV_GTK_C_STRING
			-- enter_notify_event_string constant.
		once
			Result := "enter-notify-event"
		end

	leave_notify_event_string: EV_GTK_C_STRING
			-- leave_notify_event_string constant.
		once
			Result := "leave-notify-event"
		end

	motion_notify_event_string: EV_GTK_C_STRING
			-- motion_notify_event_string constant.
		once
			Result := "motion-notify-event"
		end

	size_allocate_event_string: EV_GTK_C_STRING
			-- size_allocate_event_string constant.
		once
			Result := "size-allocate"
		end

	button_press_event_string: EV_GTK_C_STRING
			-- button_press_event_string constant.
		once
			Result := "button-press-event"
		end

	button_release_event_string: EV_GTK_C_STRING
			-- button_release_event_string constant.
		once
			Result := "button-release-event"
		end

	clicked_event_string: EV_GTK_C_STRING
			-- button_release_event_string constant.
		once
			Result := "clicked"
		end

note
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
