note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_EVENT_STRINGS

feature -- Event names

	accel_activate_name: STRING = "accel-activate"

	window_state_event_name: STRING = "window-state-event"

	delete_event_name: STRING = "delete-event"

	key_press_event_name: STRING = "key-press-event"

	key_release_event_name: STRING = "key-release-event"
			-- key-release-event string constant

	focus_in_event_name: STRING = "focus-in-event"
			-- focus_in_event_name constant.

	focus_out_event_name: STRING = "focus-out-event"
			-- focus_out_event_name constant.

	set_focus_event_name: STRING = "set-focus"
			-- set_focus_event_name constant.

	configure_event_name: STRING = "configure-event"
			-- configure_event_name constant.

	map_signal_name: STRING = "map"
			-- map signal name constant.
			--| The ::map signal is emitted when widget is going to be mapped, that is when the widget is visible

	unmap_signal_name: STRING = "unmap"
			-- unmap signal name constant.
			--| The ::unmap signal is emitted when widget is going to be unmapped, which means that either it or any of its parents up to the toplevel widget have been set as hidden.

	map_event_name: STRING = "map-event"
			-- map_event_name constant.
			--| The ::map-event signal will be emitted when the widget 's window is mapped

	unmap_event_name: STRING = "unmap-event"
			-- map_event_name constant.
			--| The ::unmap-event signal will be emitted when the widget 's window is unmapped. A window is unmapped when it becomes invisible on the screen.			

	enter_notify_event_name: STRING = "enter-notify-event"
			-- enter_notify_event_name constant.

	leave_notify_event_name: STRING = "leave-notify-event"
			-- leave_notify_event_name constant.

	motion_notify_event_name: STRING = "motion-notify-event"
			-- motion_notify_event_name constant.

	size_allocate_event_name: STRING = "size-allocate"
			-- size_allocate_event_name constant.

	button_press_event_name: STRING = "button-press-event"
			-- button_press_event_name constant.

	button_release_event_name: STRING = "button-release-event"
			-- button_release_event_name constant.

	clicked_event_name: STRING = "clicked"
			-- button_release_event_name constant.

	expose_event_name: STRING = "expose-event"

	draw_event_name: STRING = "draw"

	commit_event_name: STRING = "commit"

	changed_event_name: STRING = "changed"

	mark_set_event_name: STRING = "mark_set"

	value_changed_event_name: STRING = "value-changed"

	realize_event_name: STRING = "realize"

	response_event_name: STRING = "response"

	row_collapsed_event_name: STRING = "row-collapsed"

	row_expanded_event_name: STRING = "row-expanded"

	switch_page_event_name: STRING = "switch-page"

	toggled_event_name: STRING = "toggled"

	notify_width_event_name: STRING = "notify::width"

	scroll_event_name: STRING = "scroll-event"

feature -- Event names

	accel_activate_string: EV_GTK_C_STRING
			--
		once
			Result := accel_activate_name
		end

	window_state_event_string: EV_GTK_C_STRING
			--
		once
			Result := window_state_event_name
		end

	delete_event_string: EV_GTK_C_STRING
			--
		once
			Result := delete_event_name
		end

	key_press_event_string: EV_GTK_C_STRING
			--
		once
			Result := key_press_event_name
		end

	key_release_event_string: EV_GTK_C_STRING
			-- key-release-event string constant
		once
			Result := key_release_event_name
		end

	focus_in_event_string: EV_GTK_C_STRING
			-- focus_in_event_string constant.
		once
			Result := focus_in_event_name
		end

	focus_out_event_string: EV_GTK_C_STRING
			-- focus_out_event_string constant.
		once
			Result := focus_out_event_name
		end

	set_focus_event_string: EV_GTK_C_STRING
			-- set_focus_event_string constant.
		once
			Result := set_focus_event_name
		end

	configure_event_string: EV_GTK_C_STRING
			-- configure_event_string constant.
		once
			Result := configure_event_name
		end

	map_event_string: EV_GTK_C_STRING
			-- map_event_string constant.
		once
			Result := map_event_name
		end

	enter_notify_event_string: EV_GTK_C_STRING
			-- enter_notify_event_string constant.
		once
			Result := enter_notify_event_name
		end

	leave_notify_event_string: EV_GTK_C_STRING
			-- leave_notify_event_string constant.
		once
			Result := leave_notify_event_name
		end

	motion_notify_event_string: EV_GTK_C_STRING
			-- motion_notify_event_string constant.
		once
			Result := motion_notify_event_name
		end

	size_allocate_event_string: EV_GTK_C_STRING
			-- size_allocate_event_string constant.
		once
			Result := size_allocate_event_name
		end

	button_press_event_string: EV_GTK_C_STRING
			-- button_press_event_string constant.
		once
			Result := button_press_event_name
		end

	button_release_event_string: EV_GTK_C_STRING
			-- button_release_event_string constant.
		once
			Result := button_release_event_name
		end

	clicked_event_string: EV_GTK_C_STRING
			-- button_release_event_string constant.
		once
			Result := clicked_event_name
		end

	draw_event_string: EV_GTK_C_STRING
		once
			Result := draw_event_name
		end

	commit_event_string: EV_GTK_C_STRING
		once
			Result := commit_event_name
		ensure
			instance_free: class
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
