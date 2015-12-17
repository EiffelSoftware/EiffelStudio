note
	description: "Base class from which all our Vision2 tests inherit. Contains shared functionality for setup."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_VISION2_TEST_SET

inherit
	ANY
		undefine
			default_create
		end

feature -- Action

	run_test (a_agent: PROCEDURE)
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		do
			run_test_with_delay (0, a_agent)
		end

	run_test_with_delay (a_delay_in_ms: INTEGER; a_agent: PROCEDURE)
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		local
			l_app: like application
		do
			create l_app
			application := l_app
			l_app.add_idle_action_kamikaze (a_agent)
			l_app.add_idle_action_kamikaze (agent destroy (l_app, a_delay_in_ms))
			l_app.uncaught_exception_actions.extend (agent record_exception)
			l_app.launch

			report_vision2_failure
		end

feature -- Basic operations

	assert_32 (a_tag: READABLE_STRING_GENERAL; a_condition: BOOLEAN)
			-- Assert `a_condition'.
		require
			a_tag_not_void: a_tag /= Void
		deferred
		end

feature {NONE} -- Access

	application: detachable EV_APPLICATION

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
					assert_32 ({STRING_32} "Exception occurred: (" + a_exception.tag + ") " + l_desc, False)
				else
					assert_32 ({STRING_32} "Exception occurred: (" + a_exception.tag + ")", False)
				end
			end
		end

	report_vision2_failure
			-- Report failure in vision2
		do
			if attached first_recorded_exception as l_exception then
				l_exception.raise
			end
		end

	destroy (a_app: EV_APPLICATION; a_delay_in_ms: INTEGER)
			-- Destroy `a_app' after `a_delay_in_ms' millisecond.
		local
			l_timer: EV_TIMEOUT
		do
			if a_delay_in_ms > 0 then
				create l_timer
				l_timer.actions.extend (agent a_app.destroy)
				l_timer.set_interval (a_delay_in_ms)
			else
				a_app.destroy
			end
		end

feature {NONE} -- Event handling

	process_events
			-- Process application events
		do
			if attached application as l_appl then
				l_appl.process_events
			end
		end

	click_on_button (a_identifer_name: STRING)
			-- Click on a button `a_identifier_name'.
		require
			a_name_not_void: a_identifer_name /= Void
		local
			l_screen: EV_SCREEN
		do
			if attached {EV_BUTTON} find_widget_with_name (a_identifer_name) as l_button then
				create l_screen
				l_screen.set_pointer_position (l_button.screen_x + l_button.width // 2, l_button.screen_y + l_button.height // 2)
				assert_32 ({STRING_32} "Widget under pointer match", l_screen.widget_at_mouse_pointer = l_button)
				l_screen.fake_pointer_button_click ({EV_POINTER_CONSTANTS}.left)
			else
				assert_32 ({STRING_32} "Can't find button with name: " + a_identifer_name, False)
			end
		end

	click_on_window_cloase_button (a_window_identifier: STRING)
			-- Click on the close button of a window `a_window_identifier'.
		require
			not_void: a_window_identifier /= Void
		local
			l_screen: EV_SCREEN
		do
			if attached {EV_WINDOW} find_widget_with_name (a_window_identifier) as l_window then
				create l_screen
				l_screen.set_pointer_position (l_window.screen_x + l_window.width - 5, l_window.screen_y + 5)
				l_screen.fake_pointer_button_click ({EV_POINTER_CONSTANTS}.left)
			else
				assert_32 ({STRING_32} "Can't find window with name: " + a_window_identifier, False)
			end
		end

	check_button_text (a_identifier_name: STRING; a_correct_text: STRING)
			-- Check button's text
		require
			a_name_not_void: a_identifier_name /= Void
			a_correct_text_not_void: a_correct_text /= Void
		do
			if attached {EV_BUTTON} find_widget_with_name (a_identifier_name) as l_button then
				if not l_button.text.same_string (a_correct_text) then
					assert_32 ({STRING_32} "Button's text not correct. " + a_identifier_name + " " + a_correct_text + " " + l_button.text, False)
				end
			else
				assert_32 ({STRING_32} "Can't find button with name: " + a_identifier_name, False)
			end
		end

feature {NONE} -- Implementation

	find_widget_with_name (a_identifier_name: STRING): detachable EV_WIDGET
			-- Find button with identifier name which is `a_name'
		require
			not_void: a_identifier_name /= Void
		local
			l_env: EV_ENVIRONMENT
			l_windows: LINEAR [EV_WINDOW]
		do
			if attached application as l_appl then
				from
					create l_env
					l_windows := l_appl.windows
					l_windows.start
				until
					l_windows.after or Result /= Void
				loop
					Result := find_widget_recursive (l_windows.item, a_identifier_name)

					l_windows.forth
				end
			end
		end

	find_widget_recursive (a_top_level_widget: EV_WIDGET; a_identifier_name: STRING): detachable EV_WIDGET
			-- Find widget which identifier name is `a_identifier_name' recursivly in `a_top_level_widget'
		require
			a_widget_not_void: a_top_level_widget /= Void
			a_widget_name_not_void: a_identifier_name /= Void
		local
			l_items: LINEAR [EV_WIDGET]
		do
			if a_top_level_widget.identifier_name.is_equal (a_identifier_name) then
				Result := a_top_level_widget
			else
				if attached {EV_CONTAINER} a_top_level_widget as lt_container then
					from
						l_items := lt_container.linear_representation
						l_items.start
					until
						l_items.after or Result /= Void
					loop
						Result := find_widget_recursive (l_items.item, a_identifier_name)
						l_items.forth
					end
				end
			end
		end

feature {NONE} -- Conveniences

	colors: EV_STOCK_COLORS
		once
			create Result
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
