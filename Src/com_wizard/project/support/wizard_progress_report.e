indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROGRESS_REPORT

create
	make

feature {NONE} -- Initialization

	make (a_event_raiser: like event_raiser) is
			-- Set `event_raiser' with `a_event_raiser'.
		require
			non_void_event_raiser: a_event_raiser /= Void
		do
			event_raiser := a_event_raiser
		ensure
			event_raiser_set: event_raiser = a_event_raiser
		end

feature -- Element Change

	set_title (a_title: STRING) is
			-- Set `title' with `a_title'.
		require
			non_void_title: a_title /= Void
			valid_title: not a_title.is_empty
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Title, a_title)])
		end

	set_range (a_range: INTEGER) is
			-- Set `range' with `a_range'.
		require
			valid_range: a_range >= 0
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Set_range, a_range)])
		end

	step is
			-- Increment progress.
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Step, Void)])
		end

feature -- Basic Operations

	start is
			-- Start report (i.e. activate dialog).
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Start, Void)])
		end

	finish is
			-- Terminate report (i.e. terminate dialog)
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Finish, Void)])
		end

feature {NONE} -- Implementation

	event_raiser: ROUTINE [ANY, TUPLE [EV_THREAD_EVENT]]
			-- Event raiser

end -- class WIZARD_PROGRESS_REPORT