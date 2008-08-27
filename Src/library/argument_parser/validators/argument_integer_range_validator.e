indexing
	description: "A command line switch file validator that checks if an integer is with a value range."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_INTEGER_RANGE_VALIDATOR

inherit
	ARGUMENT_VALUE_VALIDATOR
		redefine
			validate_value
		end

create
	make

feature {NONE} -- Initialization

	make (a_min: like min; a_max: like max)
			-- Initializes validator with a minimum and maximum value.
			--
			-- `a_min': Minimum, inclusive accepted value.
			-- `a_max': Maximum, inclusive accepted value.
		require
			a_min_less_than_a_max: a_min < a_max
		do
			min := a_min
			max := a_max
		ensure
			min_set: min = a_min
			max_set: max = a_max
		end

feature -- Access

	min: INTEGER_64
			-- Minimum accepted value

	max: INTEGER_64
			-- Maximum accepted value

feature -- Validation

	validate_value (a_value: !STRING)
			-- <Precursor>
		local
			l_value: INTEGER_64
		do
			if a_value.is_integer_64 then
				l_value := a_value.to_integer_64
				is_option_valid := l_value >= min and then l_value <= max
				if not is_option_valid then
					reason := (create {STRING_FORMATTER}).format ("'{1} is not within the range from {2} to {3}.'", [l_value, min, max])
				end
			else
				reason := "The specified value is not a valid number."
			end
		end

invariant
	min_less_than_max: min < max

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class {ARGUMENT_INTEGER_RANGE_VALIDATOR}
