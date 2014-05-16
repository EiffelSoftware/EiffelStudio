note
	description: "Tests for EV_STANDARD_DIALOGs"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EV_STANDARD_DIALOG

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_show_standard_dialogs
			-- Show all the standard dialogs and hide them.
		note
			testing: "execution/isolated"
		do
			run_test (agent show_standard_dialogs)
		end

feature {NONE} -- Actual Test

	show_standard_dialogs
			-- Show all standard dialog and hide them
		local
			window: EV_TITLED_WINDOW
		do
			create window
			window.set_size (100, 200)
			window.show
			show_dialog (window, create {EV_FILE_OPEN_DIALOG})
			show_dialog (window, create {EV_FILE_SAVE_DIALOG})
			show_dialog (window, create {EV_COLOR_DIALOG})
			show_dialog (window, create {EV_DIRECTORY_DIALOG})
			show_dialog (window, create {EV_FONT_DIALOG})
			show_dialog (window, create {EV_PRINT_DIALOG})
		end

	show_dialog (a_window: EV_WINDOW; a_std_dlg: EV_STANDARD_DIALOG)
			-- Show `a_std_dlg' modal to `a_window' and hide it after
			-- 200 milliseconds.
		local
			timer: EV_TIMEOUT
		do
			a_std_dlg.cancel_actions.extend (agent a_std_dlg.destroy)
			a_std_dlg.ok_actions.extend (agent a_std_dlg.destroy)

			create timer.make_with_interval (200)
			timer.actions.extend (agent safe_hide (a_std_dlg))
			a_std_dlg.show_modal_to_window (a_window)
		end

	safe_hide (a_std_dlg: EV_STANDARD_DIALOG)
			-- Safe way to call `hide' on `a_std_dlg'.
		do
			if not a_std_dlg.is_destroyed then
				a_std_dlg.hide
			end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
