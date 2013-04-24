note
	description: "Objects that can receive Carbon events"
	author: "Vision Mac Team"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CARBON_EVENTABLE

inherit
	CARBONEVENTS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CARBONEVENTSCORE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature {EV_APPLICATION_IMP} -- Implementation

	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		do
			-- By default do nothing, but return eventNotHandledErr, redefine if necessary
			Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.eventNotHandledErr
		end

feature -- Access

	event_id: INTEGER  -- a unique integer to identify the widgets

end
