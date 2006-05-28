indexing
	description: "Form used to host notification icon, for Win64 systems"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFY_FORM

inherit
	NOTIFY_FORM_BASE
		redefine
			initialize_component,
			notify_consume,
			clear_notification,
			on_idle,
			on_form_closed
		end

create
	make

feature {NONE} -- Initialization

	initialize_component is
			-- Initialize form controls
		do
			Precursor {NOTIFY_FORM_BASE}
			notify_icon.balloon_tip_icon := {WINFORMS_TOOL_TIP_ICON}.info
			notify_icon.balloon_tip_title := "Eiffel Metadata Consumer"
			notify_icon.balloon_tip_text := "The Eiffel Metadata Consumer is a tool used to consume .NET assemblies so they may be used by the Eiffel Software Eiffel for .NET compiler."
			notify_icon.add_balloon_tip_closed (create {EVENT_HANDLER}.make (Current, $on_closed_notify_ballon))
			notify_icon.add_click (create {EVENT_HANDLER}.make (Current, $on_notify_clicked))
		end

feature -- Status Setting

	notify_consume (a_message: NOTIFY_MESSAGE) is
			-- Notifies user of a consume.
		local
			l_message: SYSTEM_STRING
		do
			show_ballon := True
			l_message := a_message.message
			if l_message.length > 255 then
				l_message := {SYSTEM_STRING}.concat (l_message.substring (0, 251), ({SYSTEM_STRING})["..."])
			end
			notify_string := l_message
		end

	clear_notification is
			-- Clears last notification message.
		do
			notify_string := ""
			show_ballon := False
		end

feature -- Status

	show_ballon: BOOLEAN
			-- Should ballon be shown?

feature -- Events

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
