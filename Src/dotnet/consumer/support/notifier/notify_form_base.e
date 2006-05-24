indexing
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
			on_form_closed
		end

feature {NONE} -- Initialization

	make is
			-- Initialize form.
		do
			initialize_component
		end

	initialize_component is
			-- Initialize form controls
		local
			l_rm: RESOURCE_MANAGER
			l_icon: DRAWING_ICON
			l_location: DRAWING_POINT
		do
			create l_rm.make (resource_name, (({SYSTEM_TYPE})[{NOTIFY_FORM}]).assembly)
			l_icon ?= l_rm.get_object (tray_icon_resource_name)
			check l_icon_attached: l_icon /= Void end

			{WINFORMS_APPLICATION}.add_idle (create {EVENT_HANDLER}.make (Current, $on_idle))
			create notify_icon.make

			create l_location.make_from_x_and_y (-32000, -32000)
			set_location (l_location)
			set_window_state ({WINFORMS_FORM_WINDOW_STATE}.normal)
			set_form_border_style ({WINFORMS_FORM_BORDER_STYLE}.fixed_tool_window)
			set_show_in_taskbar (False)

			notify_icon.visible := True
			notify_icon.text := "Eiffel Metadata Consumer Tool"
			notify_icon.icon := l_icon
			notify_icon.visible := True
		end

feature -- Status Setting

	notify_consume (a_message: NOTIFY_MESSAGE) is
			-- Notifies user of a consume.
		require
			a_message_attached: a_message /= Void
		do
			notify_string := {SYSTEM_STRING}.format ("Consuming assembly: {0}", a_message.assembly_path)
			if notify_string.length > 64 then
				notify_string := notify_string.substring (0, 63)
			end
		end

	clear_notification is
			-- Clears last notification message.
		do
			notify_string := "No current jobs to process."
		end

feature -- Access

	notify_icon: WINFORMS_NOTIFY_ICON
			-- Notify icon

	notify_string: SYSTEM_STRING
			-- String used to populate notify icon ballon

feature -- Events

	on_idle (a_sender: SYSTEM_OBJECT; a_args: EVENT_ARGS) is
			-- Processes application idle events.
		do
			if notify_icon /= Void then
				notify_icon.text := notify_string
			end
		end

	on_form_closed (a_args: WINFORMS_FORM_CLOSED_EVENT_ARGS) is
			-- Called when for has closed
		do
			Precursor {WINFORMS_FORM} (a_args)
			if notify_icon /= Void then
				notify_icon.dispose
				notify_icon := Void
			end
		ensure then
			notify_icon_unattached: notify_icon = Void
		end

feature {NONE} -- Constants

	tray_icon_resource_name: SYSTEM_STRING is "tray_icon"
			-- Tray icon resource name

	resource_name: SYSTEM_STRING is "consumer";
			-- Consumer resources name

indexing
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
