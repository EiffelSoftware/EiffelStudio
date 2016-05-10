note
	description: "Application objects for WEL tests."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TEST_APPLICATION

inherit
	WEL_APPLICATION

create
	make

feature -- Initialization

	set_uncaught_exceptions (a_agent: PROCEDURE [EXCEPTION])
			-- Make sure to handle uncaught exceptions.
		do
			dispatcher.set_exception_callback (a_agent)
		end

feature -- Access

	main_window: WEL_FRAME_WINDOW
		once
			create Result.make_top ("WEL TEST window")
		end

feature -- Operations

	destroy
			-- Stop program.
		do
			{WEL_API}.send_message (main_window.item, {WEL_WM_CONSTANTS}.wm_quit, default_pointer, default_pointer)
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
