note
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

	make (a_switch: like switch)
			-- Initializes option with just an option switch.
			--
			-- `a_switch': The switch to associated with the option.
		require
			a_switch_attached: a_switch /= Void
		do
			switch := a_switch
		ensure
			switch_set: switch ~ a_switch
		end

	make_with_value (a_value: like value; a_switch: like switch)
			-- Initializes option with just an option switch and an associated value.
			--
			-- `a_value' : The value associated with the option.
			-- `a_switch': The switch to associated with the option.
		require
			a_value_attached: a_value /= Void
			a_switch_attached: a_switch /= Void
		do
			make (a_switch)
			set_value (a_value)
		ensure
			value_set: value.same_string (a_value)
			switch_set: switch ~ a_switch
		end

feature -- Access

	switch: ARGUMENT_SWITCH
			-- Switch associated with the current option.

	value: STRING assign set_value
			-- The option's value, if any.
		local
			l_result: like internal_value
		do
			l_result := internal_value
			if l_result /= Void then
				Result := l_result
			else
				create Result.make_empty
				internal_value := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ value
		end

feature {ARGUMENT_BASE_PARSER} -- Element Change

	set_value (a_value: like value)
			-- Sets the option value.
			--
			-- `a_value': The option value to set.
		do
			internal_value := a_value
		ensure
			value_set: value ~ a_value
		end

feature -- Status Report

	has_value: BOOLEAN
			-- Indicicate if option has an associated value.
		local
			l_value: like internal_value
		do
			l_value := internal_value
			Result := l_value /= Void and then not l_value.is_empty
		ensure
			not_value_is_empty: Result implies not value.is_empty
		end

feature {NONE} -- Implementation: Internal cache

	internal_value: detachable like value
			-- Cached version of `value'.
			-- Note: Do not use directly!

;invariant
	switch_attached: switch /= Void

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
