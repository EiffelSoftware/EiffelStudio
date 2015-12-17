note
	description: "Base class from which all our WEL tests inherit. Contains shared functionality for setup."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_TEST_SET

inherit
	EQA_TEST_SET

feature -- Action

	run_test (a_agent: PROCEDURE)
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		local
			l_app: WEL_TEST_APPLICATION
		do
			create l_app.make
			l_app.set_uncaught_exceptions (agent record_exception)
			application := l_app
			l_app.run
			report_wel_failure
		end

feature {NONE} -- Access

	application: detachable WEL_TEST_APPLICATION

	first_recorded_exception: detachable EXCEPTION;
			-- First caught exception

	record_exception (a_exception: EXCEPTION)
			-- Record vision2 exception
		do
			if first_recorded_exception = Void then
				first_recorded_exception := a_exception
				if attached application as l_appl then
					l_appl.destroy
				end
				if attached a_exception.description as l_desc then
					assert ("Exception occurred: (" + a_exception.tag + ") " + l_desc, False)
				else
					assert ("Exception occurred: (" + a_exception.tag + ")", False)
				end
			end
		end

	report_wel_failure
			-- Report failure in vision2
		do
			if attached first_recorded_exception as l_exception then
				l_exception.raise
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
