indexing
	description: "Access to the vision2 application through a once feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "EV_APPLICATION, application, once, access"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHARED_APPLICATION

feature -- Access

	ev_application: EV_APPLICATION is
			-- Current application. This once feature must be called
			-- only if the application has been created
		once
			Result := (create {EV_ENVIRONMENT}).application
		ensure
			Result_not_void: Result /= Void
		end
		
	process_events_and_idle is
			-- Call `process_events' and `idle_actions' on `ev_application'.
		do
			ev_application.process_events
			ev_application.idle_actions.call (Void)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SHARED_APPLICATION

