note
	description: "Tests for EV_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EV_DIALOG

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_show_modal
			-- Show a modal dialog and close it by hiding it.
		note
			testing: "execution/isolated"
		do
			run_test (agent show (True, False))
		end

	test_show_modeless
			-- Show a modeless dialog and close it by hiding it.
		note
			testing: "execution/isolated"
		do
			run_test (agent show (False, True))
		end

	test_show
			-- Show a dialog and close it by hiding it.
		note
			testing: "execution/isolated"
		do
			run_test (agent show (False, False))
		end

	test_show_hide_modal
			-- Show/Hide/Show a modal dialog and close it.
		note
			testing: "execution/isolated"
		do
			run_test (agent show_hide (True, False))
		end

	test_show_hide_modeless
			-- Show/Hide/Show a modeless dialog and close it.
		note
			testing: "execution/isolated"
		do
			run_test (agent show_hide (False, True))
		end

	test_show_hide
			-- Show/Hide/Show a dialog and close it.
		note
			testing: "execution/isolated"
		do
			run_test (agent show_hide (False, False))
		end

feature {NONE} -- Actual Test

	show (a_is_modal, a_is_modeless: BOOLEAN)
			-- Shows an empty window without title bar, 100x200px in size.
		require
			nothing_modal_or_modeless_but_not_both: (a_is_modal xor a_is_modeless) or else (not a_is_modal and not a_is_modeless)
		local
			dialog: EV_DIALOG
			window: EV_WINDOW
			button: EV_BUTTON
		do
			create window
			window.set_size (100, 200)
			create dialog
			create button.make_with_text ("OK")
			dialog.extend (button)
			dialog.show_actions.extend (agent dialog.hide)
			if a_is_modal then
				dialog.show_modal_to_window (window)
			elseif a_is_modeless then
				dialog.show_relative_to_window (window)
			else
				dialog.show
			end
		end

	show_hide (a_is_modal, a_is_modeless: BOOLEAN)
			-- Shows an empty window without title bar, 100x200px in size.
		require
			nothing_modal_or_modeless_but_not_both: (a_is_modal xor a_is_modeless) or else (not a_is_modal and not a_is_modeless)
		local
			dialog: EV_DIALOG
			window: EV_WINDOW
			button: EV_BUTTON
		do
			create window
			window.set_size (100, 200)
			create dialog
			create button.make_with_text ("OK")
			dialog.extend (button)
			dialog.show_actions.extend (agent (a_dialog: EV_DIALOG; a_window: EV_WINDOW; a_is_mod, a_is_modless: BOOLEAN)
				do
					a_dialog.hide
					a_dialog.show_actions.wipe_out
					a_dialog.show_actions.extend (agent a_dialog.destroy)
					if a_is_mod then
						a_dialog.show_modal_to_window (a_window)
					elseif a_is_modless then
						a_dialog.show_relative_to_window (a_window)
					else
						a_dialog.show
					end
				end (dialog, window, a_is_modal, a_is_modeless))

			if a_is_modal then
				dialog.show_modal_to_window (window)
			elseif a_is_modeless then
				dialog.show_relative_to_window (window)
			else
				dialog.show
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
