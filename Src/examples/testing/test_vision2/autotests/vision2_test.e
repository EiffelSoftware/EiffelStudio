note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	VISION2_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_exceptions
			-- Test to catch failures in Vision2 message loop
		local
			l_app: VISION2_APPLICATION
		do
			create l_app
			application := l_app
			l_app.post_launch_actions.extend (agent create_main_window)
			l_app.post_launch_actions.extend (agent set_text_field)
			l_app.post_launch_actions.extend (agent quit_application)
			l_app.uncaught_exception_actions.extend (agent record_exception)
			l_app.launch

			report_vision2_failure
		end

feature {NONE} -- Implementation

	create_main_window
			-- Create main window
		do
			create main_window
			main_window.text_field.change_actions.extend (agent on_text_changed)
			main_window.show
		end

	set_text_field
			-- Set text in text field
		do
			if main_window /= Void then
				main_window.text_field.set_text ("Hi")
			else
				assert ("Window uninitialized", False)
			end
		end

	on_text_changed
			-- On text changed action
		do
			if main_window /= Void then
				main_window.text_field.disable_sensitive
			else
				assert ("Window uninitialized", False)
			end

			assert ("Test assert", False)
		end

	quit_application
			-- Quit application
		do
			if main_window /= Void and then application /= Void then
				main_window.destroy
				application.destroy
			else
				assert ("Application or window uninitialized", False)
			end
		end

	record_exception (a_exception: EXCEPTION)
			-- Record vision2 exception
		do
			if first_recorded_exception = Void then
				first_recorded_exception := a_exception
			end
		end

	report_vision2_failure
			-- Report failure in vision2
		do
			if attached first_recorded_exception as l_exception then
				if attached l_exception.description as d then
					assert_32 (d, False)
				else
					assert ("Caught Exception", False)
				end
			end
		end

feature {NONE} -- Access

	first_recorded_exception: detachable EXCEPTION
			-- The first recorded exception in Vision2 message loop

	main_window: detachable MAIN_WINDOW
			-- Main window
		note
			option: stable
		attribute
		end

	application: detachable VISION2_APPLICATION
			-- Vision2 application
		note
			option: stable
		attribute
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
