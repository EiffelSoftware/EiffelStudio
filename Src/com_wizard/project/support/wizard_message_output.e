indexing
	description: "Process warnings and errors."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MESSAGE_OUTPUT

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

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
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_title, reason)])
		end

	add_message (reason: STRING) is
			-- Display message `reason' from `origin'.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_message, reason)])
		end

	add_text (reason: STRING) is
			-- Display text `reason' from `origin'.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_text, reason)])
		end

	add_warning (reason: STRING) is
			-- Display warning.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_warning, reason)])
		end

	display_error is
			-- Display current error.
		do
			if environment.abort and environment.is_valid_error_code (environment.error_code) then
				event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_error, environment.error_message)])
			end
		end

	clear is
			-- Clear output.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Clear, Void)])
		end

invariant
	non_void_event_raiser: event_raiser /= Void

end -- class WIZARD_MESSAGE_OUTPUT

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
