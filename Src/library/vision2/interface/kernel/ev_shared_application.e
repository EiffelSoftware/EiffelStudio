note
	description: "Access to the vision2 application if created."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "EV_APPLICATION, application, once, access"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHARED_APPLICATION

feature -- Access

	ev_application: EV_APPLICATION
			-- Current application if created yet.
		require
			application_exists: attached shared_environment.application
			same_processor_as_application: shared_environment.is_application_processor
		do
			check attached shared_environment.application as l_app then
				Result := l_app
			end
		end

	ev_separate_application: separate EV_APPLICATION
			-- Current application if created yet.
		require
			application_exists: attached shared_environment.application
		do
			check attached shared_environment.separate_application as l_app then
				Result := l_app
			end
		end

	process_events_and_idle
			-- Call `process_events'.
		obsolete
			"Call ev_application.process_events instead [2017-05-31]"
		do
			ev_application.process_events
				-- Idle actions are called when all events are processed.
		end

	shared_environment: EV_ENVIRONMENT
			-- Shared EV_ENVIRONMENT object.
		once
			Result := create {EV_ENVIRONMENT}
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_SHARED_APPLICATION






