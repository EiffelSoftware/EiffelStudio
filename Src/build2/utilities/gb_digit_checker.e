indexing
	description: "Objects that represent a method for checking if a standard digit key is held down."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DIGIT_CHECKER

create
	make_with_components

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Initialize all action sequences.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
		ensure
			components_set: components = a_components
		end

feature -- Basic operations

	begin_processing (widget: EV_WIDGET) is
			-- Begin processing `a_widget' to determine if a paticular digit key
			-- is held down.
		require
			widget_not_void: widget /= Void
		do
			create timer.make_with_interval (timer_interval)
			timer.actions.extend (agent increase_timer_counter)
			check_pressed_digit_agent := agent check_pressed_digit
			widget.key_press_actions.extend (check_pressed_digit_agent)
			internal_widget := widget
		end

	end_processing is
			-- End key processing for digits.
		do
			timer_counter := 0
			timer_counter_at_last_press := 0
				-- Note that we protect in here as we always end processing after
				-- a pick and drop but only start it from particular sources.
			if internal_widget /= Void then
				internal_widget.key_press_actions.prune_all (check_pressed_digit_agent)
			end
			if timer /= Void and then not timer.is_destroyed then
				timer.destroy
			end
		end

feature -- Status report

	digit_pressed: BOOLEAN is
			-- Is one of the digit keys (1-9) considered to be pressed?
		do
				-- Note that we cannot check that they are identical due to the fact that the timer happens
				-- at a repeated interval, although the keypress may happen at any point between a timeout.
				-- therefore, in a worse case scenario, the key press could occur immediately before the next time
				-- out, and in that case, the timeout has changed before the repeat of the keyboard has passed.
				-- This removes the delay effectively, so by always permitting 1 or less, the full range of the
				-- delay is always waited.
			Result := (timer_counter - timer_counter_at_last_press <= 1) and timer_counter_at_last_press /= 0
		end

	digit: INTEGER is
			-- Integer corresponding to pressed digit.
		require
			digit_pressed: digit_pressed
		do
			Result := insert_count
		end

feature {NONE} -- Implementation

	internal_widget: EV_WIDGET
		-- Widget to Which checking is currently conencted.

	check_pressed_digit_agent: PROCEDURE [ANY, TUPLE [EV_KEY]]
		-- Agent currently connected to `key_press_actions' of `internal_widget'.
		-- We must store a reference to the agent so that it may be correctly
		-- removed from the action sequence.

	timer: EV_TIMEOUT
		-- A timeout used internally to perform periodic updates
		-- of the internal counter used.

	timer_counter: INTEGER
		-- A counter fired by `timer', every `timer_interval' milliseconds

	timer_counter_at_last_press: INTEGER
		-- The value of `timer_counter' at the last time a press was received.

	timer_interval: INTEGER is 100
		-- Interval used for `timer_counter'.
		-- If a key press has not been recieved in this space of time (milliseconds),
		-- the key is no longer considered to be pressed.

	insert_count: INTEGER
		-- Value corresponding to pressed digit.

	key_constants: EV_KEY_CONSTANTS is
			-- Once access to key constants.
		once
			create Result
		end

	check_pressed_digit (a_key: EV_KEY) is
			-- Check `a_key' to see if a digit is pressed.
			-- Fired from actions of `timer'.
		require
			a_key_not_void: a_key /= Void
		do
			insert_count := 10 - (key_constants.Key_numpad_0 - a_key.code + 1)
			if insert_count >= 1 and insert_count <=9 then
				timer_counter_at_last_press := timer_counter
			end
		end

	increase_timer_counter is
			-- Increase value `timer_counter' by one.
		do
			timer_counter := timer_counter + 1
		ensure
			count_increased: timer_counter = old timer_counter + 1
		end

invariant
	key_constants_not_void: key_constants /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_DIGIT_CHECKER
