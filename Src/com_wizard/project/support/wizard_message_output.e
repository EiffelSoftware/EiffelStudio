indexing
	description: "Process warnings and errors."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MESSAGE_OUTPUT

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

	add_title (origin: ANY; reason: STRING) is
			-- Display title.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_title, reason)])
		end

	add_message (origin: ANY; reason: STRING) is
			-- Display message `reason' from `origin'.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_message, reason)])
		end

	add_text (origin: ANY; reason: STRING) is
			-- Display text `reason' from `origin'.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_text, reason)])
		end

	add_warning (origin: ANY; reason: STRING) is
			-- Display warning.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_warning, reason)])
		end

	add_error (origin: ANY; reason: STRING) is
			-- Display error.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Display_error, reason)])
		end

	clear is
			-- Clear output.
		do
			event_raiser.call ([create {WIZARD_OUTPUT_EVENT}.make (feature {WIZARD_OUTPUT_EVENT_ID}.Clear, Void)])
		end

invariant
	non_void_event_raiser: event_raiser /= Void

end -- class WIZARD_MESSAGE_OUTPUT

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

