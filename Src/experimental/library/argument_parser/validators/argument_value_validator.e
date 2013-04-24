note
	description: "A command line switch value validator for checking user specified command line switch values."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARGUMENT_VALUE_VALIDATOR

feature -- Access

	reason: STRING
			-- Reason why switch value was considered invalid.
		require
			not_is_option_valid: not is_option_valid
			has_validated: has_validated
		local
			l_result: like internal_reason
		do
			l_result := internal_reason
			if l_result = Void then
				create Result.make_empty
				internal_reason := Result
			else
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result ~ reason
		end

feature -- Status report

	is_option_valid: BOOLEAN
			-- Indicates if last validate option, using `validate_option' is valid.

	has_validated: BOOLEAN
			-- Indicates if a validation operation has been performed yet.

feature {NONE} -- Element change

	invalidate_option (a_reason: READABLE_STRING_8)
			-- Set the option as invalid and provides a reason.
		require
			a_reason_attached: a_reason /= Void
			not_a_reason_is_empty: not a_reason.is_empty
		do
			is_option_valid := False
			create internal_reason.make_from_string (a_reason)
		ensure
			not_is_option_valid: not is_option_valid
			reason_set: reason.same_string (a_reason)
		end

feature -- Basic operations

	frozen validate (a_value: READABLE_STRING_8)
			-- Validates option value against any defined rules.
			--
			-- `a_value': The argument option to validate.
		require
			a_value_attached: a_value /= Void
		do
			reset
			has_validated := True
			validate_value (a_value)
		ensure
			not_reason_is_empty: not is_option_valid implies not reason.is_empty
			has_validated: has_validated
		end

feature {NONE} -- Basic operations

	validate_value (a_value: READABLE_STRING_8)
			-- Validates option value against any defined rules.
			--|Call `invalidate_option' to set the appropriate state.
			--
			-- `a_value': The argument option to validate.
		require
			a_value_attached: a_value /= Void
		deferred
		ensure
			not_reason_is_empty: not is_option_valid implies not reason.is_empty
		end

feature {NONE} -- Basic operations

	reset
			-- Resets the current state for reuse.
		do
			is_option_valid := True
			has_validated := False
			internal_reason := Void
		ensure
			is_option_valid: is_option_valid
			not_has_validated: not has_validated
			internal_reason_detached: internal_reason = Void
		end

feature {NONE} -- Implementation: Internal cache

	internal_reason: detachable like reason
			-- Cached version of `reason'
			-- Note: Do not use directly!

invariant
	not_reason_is_empty: (not is_option_valid and has_validated) implies not reason.is_empty

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
