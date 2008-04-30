indexing
	description: "Process warnings and errors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MESSAGE_OUTPUT

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make (a_event_raiser: like event_raiser) is
			-- Set `event_raiser' to `a_event_raiser.
		require
			non_void_event_raiser: a_event_raiser /= Void
		do
			event_raiser := a_event_raiser
		ensure
			event_raiser_set: event_raiser = a_event_raiser
		end

feature -- Access

	event_raiser: ROUTINE [ANY, TUPLE [EV_THREAD_EVENT]]
			-- Agent on event raiser

feature -- Basic operations

	add_title (reason: STRING) is
			-- Display title.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make ({WIZARD_OUTPUT_EVENT_ID}.Display_title, reason)])
		end

	add_message (reason: STRING) is
			-- Display message `reason' from `origin'.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make ({WIZARD_OUTPUT_EVENT_ID}.Display_message, reason)])
		end

	add_text (reason: STRING) is
			-- Display text `reason' from `origin'.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make ({WIZARD_OUTPUT_EVENT_ID}.Display_text, reason)])
		end

	add_warning (reason: STRING) is
			-- Display warning.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make ({WIZARD_OUTPUT_EVENT_ID}.Display_warning, reason)])
		end

	display_error is
			-- Display current error.
		do
			if environment.abort and environment.is_valid_error_code (environment.error_code) then
				event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make ({WIZARD_OUTPUT_EVENT_ID}.Display_error, environment.error_message)])
			end
		end

	clear is
			-- Clear output.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make ({WIZARD_OUTPUT_EVENT_ID}.Clear, Void)])
		end

invariant
	non_void_event_raiser: event_raiser /= Void

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
end -- class WIZARD_MESSAGE_OUTPUT

