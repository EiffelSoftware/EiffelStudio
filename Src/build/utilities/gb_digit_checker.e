indexing
	description: "Objects that represent a method for checking if a standard digit key is held down."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DIGIT_CHECKER

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make is
			-- Initialize all action sequences.
		do
			ev_application.key_press_string_actions.extend (agent check_pressed_digit)
			ev_application.key_release_actions.extend (agent check_released_digit)
		end

feature -- Status report

	is_digit_pressed: BOOLEAN
			-- Is one of the digit keys (1-9) considered to be pressed?

	digit: INTEGER
			-- Integer corresponding to pressed digit, 0 otherwise.

feature {NONE} -- Implementation

	check_pressed_digit (a_widget: EV_WIDGET; a_str: STRING_32) is
			-- Check `a_key' to see if a digit is pressed.
			-- Fired from actions of `timer'.
		do
			is_digit_pressed := False
			if a_str /= Void and then a_str.count = 1 then
				if a_str.is_integer then
					digit := a_str.to_integer
					check digit_valid: digit >= 0 and digit <= 9 end
					is_digit_pressed := True
				else
					digit := 0
				end
			end
		end

	check_released_digit (a_widget: EV_WIDGET; a_key: EV_KEY) is
			-- Check `a_key' to see if a digit is pressed.
			-- Fired from actions of `timer'.
		do
			is_digit_pressed := False
			digit := 0
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
