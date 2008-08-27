indexing
	description: "Represents a user passed argument option."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_OPTION

create {ARGUMENT_SWITCH}
	make,
	make_with_value

feature {NONE} -- Initialization

	make (a_switch: !like switch)
			-- Initializes option with just an option switch.
			--
			-- `a_switch': The switch to associated with the option.
		do
			switch := a_switch
		ensure
			switch_set: switch = a_switch
		end

	make_with_value (a_value: !like value; a_switch: !like switch)
			-- Initializes option with just an option switch and an associated value.
			--
			-- `a_value': The value associated with the option.
			-- `a_switch': The switch to associated with the option.
		do
			make (a_switch)
			set_value (a_value)
		ensure
			value_set: equal (value, a_value)
			switch_set: equal (switch, a_switch)
		end

feature -- Access

	switch: !ARGUMENT_SWITCH
			-- Switch associated with the current option.

	value: !STRING assign set_value
			-- The option's value, if any.
		require
			has_value: has_value
		do
			create Result.make_from_string (internal_value)
		ensure
			result_consistent: equal (Result, value)
		end

feature {ARGUMENT_BASE_PARSER} -- Element Change

	set_value (a_value: !like value)
			-- Sets the option value.
			--
			-- `a_value': The option value to set.
		do
			internal_value := a_value
		ensure
			internal_value_set: equal (internal_value, a_value)
		end

feature -- Status Report

	has_value: BOOLEAN
			-- Indicicate if option has an associated value.
		do
			Result := internal_value /= Void and then not internal_value.is_empty
		ensure
			result_base_true: Result implies (internal_value /= Void and then not internal_value.is_empty)
		end

feature {NONE} -- Implementation: Internal cache

	internal_value: ?like value
			-- Mutable version of `value.

;indexing
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

end -- class {ARGUMENT_OPTION}
