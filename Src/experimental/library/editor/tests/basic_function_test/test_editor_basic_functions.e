note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EDITOR_BASIC_FUNCTIONS

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

feature -- Redefined

	on_prepare
		do
			create app
		end

	on_clean
		do
			app.destroy
		end

feature -- Test routines

	basic_stress_testing
			-- New test routine
		note
			testing:  "editor", "covers/{TEXT_PANEL}"
		do
			create app
			create window
			window.show
			app.launch
		end

feature {NONE} -- Implementation

	window: TEST_EDITOR_MAIN_WINDOW

	app: EV_APPLICATION

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


