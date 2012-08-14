note
	description: "Base class from which all our Vision2 tests inherit. Contains shared functionality for setup."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISION2_TEST_SET

inherit
	EQA_TEST_SET

feature -- Action

	run_test (a_agent: PROCEDURE [ANY, TUPLE])
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		local
			l_app: EV_APPLICATION
		do
			create l_app
			application := l_app
			l_app.add_idle_action_kamikaze (a_agent)
			l_app.add_idle_action_kamikaze (agent l_app.destroy)
			l_app.uncaught_exception_actions.extend (agent record_exception)
			l_app.launch

			report_vision2_failure
		end

feature {NONE} -- Access

	application: EV_APPLICATION

	first_recorded_exception: EXCEPTION;
			-- First caught exception

	record_exception (a_exception: EXCEPTION)
			-- Record vision2 exception
		do
			if first_recorded_exception = Void then
				first_recorded_exception := a_exception
				application.add_idle_action_kamikaze (agent application.destroy)
			end
		end

	report_vision2_failure
			-- Report failure in vision2
		do
			if attached first_recorded_exception as l_exception then
				l_exception.raise
			end
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
