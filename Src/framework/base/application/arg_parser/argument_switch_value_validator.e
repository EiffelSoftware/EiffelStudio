indexing
	description: "A command line switch value validator for checking user specified command line switch values."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_SWITCH_VALUE_VALIDATOR

feature -- Access

	is_option_valid: BOOLEAN
			-- Indicates if last validate option, using `validate_option' was valid

	reason: STRING
			-- Reason why switch valud is invalid

feature -- Validation

	validate_value (a_value: STRING) is
			-- Validates option value against any defined rules.
			-- `is_option_valid' will be set upon completion.
		require
			a_value_attached: a_value /= Void
		do
			is_option_valid := True
			reason := Void
		ensure
			reason_attached: not is_option_valid implies reason /= Void
			not_reason_is_empty: is_option_valid implies not reason.is_empty
			reason_unttached: is_option_valid implies reason = Void
		end

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

end -- class {ARGUMENT_SWITCH_VALUE_VALIDATOR}
