note
	description: "Base implementation for a form used to host a notification icon."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NOTIFY_FORM_BASE

inherit
	WINFORMS_FORM
		rename
			make as make_base
		redefine
			dispose_boolean
		end

feature {NONE} -- Initialization

	make
			-- Initialize form.
		do
			create notify_string.make_empty
			initialize_component
		end

	initialize_component
			-- Initialize form controls
		do
			create notify_icon.make

			set_location (create {DRAWING_POINT}.make_from_x_and_y (-1000, -1000))
			set_window_state ({WINFORMS_FORM_WINDOW_STATE}.minimized)
			set_start_position ({WINFORMS_FORM_START_POSITION}.manual)
			set_form_border_style ({WINFORMS_FORM_BORDER_STYLE}.fixed_tool_window)
			set_show_in_taskbar (False)
			set_opacity (0)

			notify_icon.text := "Eiffel Metadata Consumer Tool"
			notify_icon.icon := resource_icon
			notify_icon.visible := True
		end

feature {NONE} -- Clean Up

	dispose_boolean (a_disposing: BOOLEAN)
			-- Called when for has closed
		do
			Precursor {WINFORMS_FORM} (a_disposing)
			if a_disposing then
				notify_icon.dispose
			end
		end

feature -- Status Setting

	notify_consume (a_message: NOTIFY_MESSAGE)
			-- Notifies user of a consume.
		require
			a_message_attached: a_message /= Void
		do
			if attached {SYSTEM_STRING}.format ("Consuming assembly: {0}", a_message.assembly_path.to_cil) as l_msg then
				notify_info (create {STRING_32}.make_from_cil (l_msg))
			end
		ensure
			last_notification_set: attached last_notification as l_notification and then l_notification.same_string (old notify_string)
		end

	notify_info (a_message: READABLE_STRING_32)
			-- Notifier user of an event
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		do
			last_notification := notify_string.twin
			notify_string.wipe_out
			notify_string.append_string_general (a_message)
		ensure
			last_notification_set: attached last_notification as l_notification and then l_notification.same_string (old notify_string)
		end

	restore_last_notification
			-- Restores last message
		do
			if attached last_notification as l_notification and then not l_notification.is_empty then
				notify_info (l_notification)
			else
				clear_notification
			end
		end

	clear_notification
			-- Clears last notification message.
		do
			notify_string.wipe_out
			notify_string.append_string_general ("No current jobs to process.")
			last_notification := Void
		ensure
			last_notification_set: last_notification = Void
		end

feature -- Access

	notify_icon: WINFORMS_NOTIFY_ICON
			-- Notify icon

	notify_string: STRING_32
			-- String used to populate notify icon ballon

feature -- Events

	on_idle (a_sender: detachable SYSTEM_OBJECT; a_args: detachable EVENT_ARGS)
			-- Processes application idle events.
		do
			notify_icon.text := notify_string.to_cil
		end

feature {NONE} -- Constants

	tray_icon_resource_name: SYSTEM_STRING = "tray_icon"
			-- Tray icon resource name

	resource_name: SYSTEM_STRING = "consumer"
			-- Consumer resources name

feature {NONE} -- Implementation

	last_notification: detachable READABLE_STRING_32
			-- Last set notification

	resource_icon: detachable DRAWING_ICON
			-- Load `notify_icon' from resources can be loaded and if present.
		local
			l_rm: RESOURCE_MANAGER
			retried: BOOLEAN
		do
			if not retried then
				create l_rm.make (resource_name, ({NOTIFY_FORM}).to_cil.assembly)
				if attached {DRAWING_ICON} l_rm.get_object (tray_icon_resource_name) as l_icon then
					Result := l_icon
				end
			end
		rescue
			retried := True
			retry
		end

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
