note
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
			notify_info,
			clear_notification,
			on_idle
		end

create
	make

feature {NONE} -- Initialization

	initialize_component
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

	notify_consume (a_message: NOTIFY_MESSAGE)
			-- Notifies user of a consume.
		do
			notify_info (a_message.message)
		end

	notify_info (m: READABLE_STRING_32)
			-- Notifier user of an event with message `m`.
		do
			Precursor (if m.count > 255 then m.substring (1, 252) + "…" else m end)
		end

	clear_notification
			-- Clears last notification message.
		do
			Precursor
			show_ballon := False
		end

feature -- Status

	show_ballon: BOOLEAN
			-- Should ballon be shown?

feature -- Events

	on_idle (a_sender: detachable SYSTEM_OBJECT; a_args: detachable EVENT_ARGS)
			-- Processes application idle events.
		do
			if show_ballon then
				if notify_string /= Void and then notify_string.count > 0 then

					notify_icon.balloon_tip_text := notify_string.to_cil
					notify_icon.show_balloon_tip (1)
				else
					notify_icon.balloon_tip_text := "The Eiffel Metadata Consumer has no queued jobs to process."
					notify_icon.show_balloon_tip (1)
				end
				show_ballon := False
			end
		end

	on_notify_clicked (a_sender: detachable SYSTEM_OBJECT; a_args: detachable EVENT_ARGS)
			-- Processes mouse click events over notify icon.
		do
			show_ballon := True
			on_idle (a_sender, create {EVENT_ARGS}.make)
		end

	on_closed_notify_ballon (a_sender: detachable SYSTEM_OBJECT; a_args: detachable EVENT_ARGS)
			-- Processes actions when ballon is closed.
		do
			show_ballon := False
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
