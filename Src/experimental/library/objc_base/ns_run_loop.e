note
	description: "Wrapper for NSRunLoop."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RUN_LOOP

inherit
	NS_OBJECT

create
	current_run_loop,
	main_run_loop
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature -- Accessing Run Loops and Modes

	current_run_loop
			-- Returns the `NSRunLoop' object for the current thread.
		do
			make_from_pointer ({NS_RUN_LOOP_API}.current_run_loop ())
		end

	current_mode: NS_STRING_BASE
			-- Returns the receiver`s current input mode.
		do
			create Result.share_from_pointer ({NS_RUN_LOOP_API}.current_mode (item))
		end

	limit_date_for_mode (a_mode: NS_STRING_BASE): NS_DATE
			-- Performs one pass through the run loop in the specified mode and returns the date at which the next timer is scheduled to fire.
		do
			create Result.share_from_pointer ({NS_RUN_LOOP_API}.limit_date_for_mode (item, a_mode.item))
		end

	main_run_loop
			-- Returns the run loop of the main thread.
		do
			make_from_pointer ({NS_RUN_LOOP_API}.main_run_loop ())
		end

feature -- Managing Timers

	add_timer_for_mode (a_timer: NS_TIMER; a_mode: NS_STRING_BASE)
			-- Registers a given timer with a given input mode.
		do
			{NS_RUN_LOOP_API}.add_timer_for_mode (item, a_timer.item, a_mode.item)
		end

feature -- Managing Ports

--	add_port_for_mode (a_port: NS_PORT; a_mode: NS_STRING_BASE)
--			-- Adds a port as an input source to the specified mode of the run loop.
--		do
--			{NS_RUN_LOOP_API}.add_port_for_mode (item, a_port.item, a_mode.item)
--		end

--	remove_port_for_mode (a_port: NS_PORT; a_mode: NS_STRING_BASE)
--			-- Removes a port from the specified input mode of the run loop.
--		do
--			{NS_RUN_LOOP_API}.remove_port_for_mode (item, a_port.item, a_mode.item)
--		end

feature -- Running a Loop

	run
			-- Puts the receiver into a permanent loop, during which time it processes data from all attached input sources.
		do
			{NS_RUN_LOOP_API}.run (item)
		end

	run_mode_before_date (a_mode: NS_STRING_BASE; a_limit_date: NS_DATE): BOOLEAN
			-- Runs the loop once, blocking for input in the specified mode until a given date.
		do
			Result := {NS_RUN_LOOP_API}.run_mode_before_date (item, a_mode.item, a_limit_date.item)
		end

	run_until_date (a_limit_date: NS_DATE)
			-- Runs the loop until the specified date, during which time it processes data from all attached input sources.
		do
			{NS_RUN_LOOP_API}.run_until_date (item, a_limit_date.item)
		end

	accept_input_for_mode_before_date (a_mode: NS_STRING_BASE; a_limit_date: NS_DATE)
			-- Runs the loop once or until the specified date, accepting input only for the specified mode.
		do
			{NS_RUN_LOOP_API}.accept_input_for_mode_before_date (item, a_mode.item, a_limit_date.item)
		end

feature -- Scheduling and Canceling Messages

--	perform_selector_target_argument_order_modes (a_selector: OBJC_SELECTOR; a_target: NS_OBJECT; a_arg: NS_OBJECT; a_order: NATURAL; a_modes: NS_ARRAY)
--			-- Schedules the sending of a message on the current run loop.
--		do
--			{NS_RUN_LOOP_API}.perform_selector_target_argument_order_modes (item, a_selector.item, a_target.item, a_arg.item, a_order, a_modes.item)
--		end

--	cancel_perform_selector_target_argument (a_selector: OBJC_SELECTOR; a_target: NS_OBJECT; a_arg: NS_OBJECT)
--			-- Cancels the sending of a previously scheduled message.
--		do
--			{NS_RUN_LOOP_API}.cancel_perform_selector_target_argument (item, a_selector.item, a_target.item, a_arg.item)
--		end

--	cancel_perform_selectors_with_target (a_target: NS_OBJECT)
--			-- Cancels all outstanding ordered performs scheduled with a given target.
--		do
--			{NS_RUN_LOOP_API}.cancel_perform_selectors_with_target (item, a_target.item)
--		end


note
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
