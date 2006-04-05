indexing
	description: "Assertion settings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ASSERTIONS

feature -- Access, stored in configuration file

	is_precondition: BOOLEAN is
			-- Check preconditions
		do
			Result := internal_assertions_values & precondition_flag = precondition_flag
		end

	is_postcondition: BOOLEAN is
			-- Check postconditions
		do
			Result := internal_assertions_values & postcondition_flag = postcondition_flag
		end

	is_check: BOOLEAN is
			-- Check assertions
		do
			Result := internal_assertions_values & check_flag = check_flag
		end

	is_invariant: BOOLEAN is
			-- Check invariants
		do
			Result := internal_assertions_values & invariant_flag = invariant_flag
		end

	is_loop: BOOLEAN is
			-- Check loop assertions
		do
			Result := internal_assertions_values & loop_flag = loop_flag
		end

	has_assertions: BOOLEAN is
			-- Are any assertions enabled?
		do
			Result := internal_assertions_values /= 0
		end


feature {CONF_ACCESS} -- Update, stored in configuration file

	enable_precondition is
			-- Enable precondition.
		do
			internal_assertions_values := internal_assertions_values | precondition_flag
		ensure
			is_precondition: is_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	enable_postcondition is
			-- Enable postcondition.
		do
			internal_assertions_values := internal_assertions_values | postcondition_flag
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_postcondition: is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	enable_check is
			-- Enable check.
		do
			internal_assertions_values := internal_assertions_values | check_flag
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check: is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	enable_invariant is
			-- Enable invariant.
		do
			internal_assertions_values := internal_assertions_values | invariant_flag
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant: is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	enable_loop is
			-- Enable loop.
		do
			internal_assertions_values := internal_assertions_values | loop_flag
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop: is_loop
		end

	disable_precondition is
			-- Enable precondition.
		do
			internal_assertions_values := internal_assertions_values & precondition_flag.bit_not
		ensure
			not_is_precondition: not is_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	disable_postcondition is
			-- Enable postcondition.
		do
			internal_assertions_values := internal_assertions_values & postcondition_flag.bit_not
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			not_is_postcondition: not is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	disable_check is
			-- Enable check.
		do
			internal_assertions_values := internal_assertions_values & check_flag.bit_not
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			not_is_check: not is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	disable_invariant is
			-- Enable invariant.
		do
			internal_assertions_values := internal_assertions_values & invariant_flag.bit_not
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			not_is_invariant: not is_invariant
			is_loop_unchanged: is_loop = old is_loop
		end

	disable_loop is
			-- Enable loop.
		do
			internal_assertions_values := internal_assertions_values & loop_flag.bit_not
		ensure
			is_precondition_unchanged: is_precondition = old is_precondition
			is_postcondition_unchanged: is_postcondition = old is_postcondition
			is_check_unchanged: is_check = old is_check
			is_invariant_unchanged: is_invariant = old is_invariant
			not_is_loop: not is_loop
		end

feature {NONE} -- Constants

	precondition_flag: INTEGER is 0x01
	postcondition_flag: INTEGER is 0x02
	check_flag: INTEGER is 0x04
	loop_flag: INTEGER is 0x08
	invariant_flag: INTEGER is 0x10
			-- Value used during C generation to define assertion level.
			-- See values in `eif_option.h'.

feature {CONF_ASSERTIONS} -- Implementation, attributes stored in configuration file

	internal_assertions_values: INTEGER;
			-- The assertion values, encoded into an integer.

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
end
