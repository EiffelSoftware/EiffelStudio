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
			notify_string := ""
			initialize_component
		end

	initialize_component
			-- Initialize form controls
		local
			l_rm: RESOURCE_MANAGER
			l_icon: detachable DRAWING_ICON
			l_location: DRAWING_POINT
			l_type: SYSTEM_TYPE
		do
			l_type := {NOTIFY_FORM}
			create l_rm.make (resource_name, (l_type.assembly))
			l_icon ?= l_rm.get_object (tray_icon_resource_name)
			check l_icon_attached: l_icon /= Void end

			create notify_icon.make
			{WINFORMS_APPLICATION}.add_idle (create {EVENT_HANDLER}.make (Current, $on_idle))

			create l_location.make_from_x_and_y (-1000, -1000)
			set_location (l_location)
			set_window_state ({WINFORMS_FORM_WINDOW_STATE}.minimized)
			set_start_position ({WINFORMS_FORM_START_POSITION}.manual)
			set_form_border_style ({WINFORMS_FORM_BORDER_STYLE}.fixed_tool_window)
			set_show_in_taskbar (False)
			set_opacity (0)

			notify_icon.text := "Eiffel Metadata Consumer Tool"
			notify_icon.icon := l_icon
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
			notify_info ({SYSTEM_STRING}.format ("Consuming assembly: {0}", a_message.assembly_path))
		ensure
			last_notification_set: last_notification = old notify_string
		end

	notify_info (a_message: STRING)
			-- Notifier user of an event
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		do
			last_notification := notify_string
			if a_message.count > 64 then
				notify_string := a_message.substring (0, 63)
			else
				notify_string := a_message
			end
		ensure
			last_notification_set: last_notification = old notify_string
		end

	restore_last_notification
			-- Restores last message
		do
			if attached last_notification as l_notification then
				notify_info (l_notification)
			else
				clear_notification
			end
		end

	clear_notification
			-- Clears last notification message.
		do
			notify_string := "No current jobs to process."
			last_notification := Void
		ensure
			last_notification_set: last_notification = Void
		end

feature -- Access

	notify_icon: WINFORMS_NOTIFY_ICON
			-- Notify icon

	notify_string: STRING
			-- String used to populate notify icon ballon

feature -- Events

	on_idle (a_sender: detachable SYSTEM_OBJECT; a_args: detachable EVENT_ARGS)
			-- Processes application idle events.
		do
			notify_icon.text := notify_string
		end

feature {NONE} -- Constants

	tray_icon_resource_name: SYSTEM_STRING = "tray_icon"
			-- Tray icon resource name

	resource_name: SYSTEM_STRING = "consumer"
			-- Consumer resources name

feature {NONE} -- Implementation

	last_notification: detachable SYSTEM_STRING;
			-- Last set notification

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class NOTIFY_FORM_BASE
