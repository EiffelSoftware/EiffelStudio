indexing
	description: "Form used to host notification icon"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFY_FORM

inherit
	WINFORMS_FORM
		rename
			make as make_base
		end

create
	make

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
		do
			create l_rm.make (resource_name, (({SYSTEM_TYPE})[{NOTIFY_FORM}]).assembly)
			l_icon ?= l_rm.get_object (tray_icon_resource_name)
			check l_icon_attached: l_icon /= Void end
			set_icon (l_icon)

			{WINFORMS_APPLICATION}.add_idle (create {EVENT_HANDLER}.make (Current, $on_idle))
			create notify_icon.make

			set_window_state ({WINFORMS_FORM_WINDOW_STATE}.minimized)
			set_form_border_style ({WINFORMS_FORM_BORDER_STYLE}.fixed_tool_window)
			set_show_in_taskbar (False)
			add_load (create {EVENT_HANDLER}.make (Current, $on_form_load))

			notify_icon.visible := True
			notify_icon.balloon_tip_icon := {WINFORMS_TOOL_TIP_ICON}.info
			notify_icon.balloon_tip_title := "Eiffel Metadata Consumer"
			notify_icon.balloon_tip_text := "The Eiffel Metadata Consumer is a tool used to consume .NET assemblies so they may be used by the Eiffel Software Eiffel for .NET compiler."
			notify_icon.text := "Eiffel Metadata Consumer"
			notify_icon.add_balloon_tip_closed (create {EVENT_HANDLER}.make (Current, $on_closed_notify_ballon))
			notify_icon.add_click (create {EVENT_HANDLER}.make (Current, $on_notify_clicked))
			notify_icon.icon := icon
			notify_icon.visible := True
		end

feature -- Status Setting

	notify_consume (a_name, a_path, a_id, a_reason: SYSTEM_STRING) is
			-- Notifies user of a consume.
		do
			show_ballon := True
			notify_string := {SYSTEM_STRING}.format ("Consuming assembly...%N%NReason: {3}%N%NName: {0}%NID: {2}%N%NLocation:%T{1}", ({NATIVE_ARRAY [SYSTEM_STRING]})[<<a_name, a_path, a_id, a_reason>>])
		end

	clear_notification is
			-- Clears last notification message.
		do
			notify_string := ""
			show_ballon := False
		end

feature -- Access

	notify_icon: WINFORMS_NOTIFY_ICON
			-- Notify icon

	notify_string: SYSTEM_STRING
			-- String used to populate notify icon ballon

feature -- Status

	show_ballon: BOOLEAN
			-- Should ballon be shown?

feature -- Events

	on_idle (a_sender: SYSTEM_OBJECT; a_args: EVENT_ARGS) is
			-- Processes application idle events.
		do
			if show_ballon then
				if notify_string /= Void and then notify_string.length > 0 then

					notify_icon.balloon_tip_text := notify_string
					notify_icon.show_balloon_tip (1)
				else
					notify_icon.balloon_tip_text := "The Eiffel Metadata Consumer has no queued jobs to process."
					notify_icon.show_balloon_tip (1)
				end
				show_ballon := False
			end
		end

	on_form_load (a_sender: SYSTEM_OBJECT; a_args: EVENT_ARGS) is
			-- Processes form load event.
		do
			on_idle (a_sender, a_args)
		end

	on_notify_clicked (a_sender: SYSTEM_OBJECT; a_args: EVENT_ARGS) is
			-- Processes mouse click events over notify icon.
		do
			show_ballon := True
			on_idle (a_sender, create {EVENT_ARGS}.make)
		end

	on_closed_notify_ballon (a_sender: SYSTEM_OBJECT; a_args: EVENT_ARGS) is
			-- Processes actions when ballon is closed.
		do
			show_ballon := False
		end

feature {NONE} -- Constants

	tray_icon_resource_name: SYSTEM_STRING is "tray_icon"

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

end -- class NOTIFY_FORM
