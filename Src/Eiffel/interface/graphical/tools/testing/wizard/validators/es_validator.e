note
	description: "[
		Validator that is able to define a error message.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_VALIDATOR

inherit
	ES_SHARED_LOCALE_FORMATTER

feature -- Access

	last_error_message: detachable STRING_32
			-- Error message of last validation if any

feature -- Status report

	is_valid: BOOLEAN
			-- Did last validation succeed?
		do
			Result := last_error_message = Void
		ensure
			not_result_implies_error_message: not Result implies last_error_message /= Void
		end

feature {NONE} -- Status setting

	set_error (a_message: STRING_32)
			-- Set error message for current validation
			--
			-- `a_message': Error message
		do
			last_error_message := locale_formatter.translation (a_message)
		ensure
			not_valid: not is_valid
		end

	set_formatted_error (a_message: STRING_32; a_tokens: TUPLE)
			-- Set error message for current validation and replace tokens
			--
			-- `a_message': Error message with tokens
			-- `token_values': Values with which tokens should be replaced.
		do
			last_error_message := locale_formatter.formatted_translation (a_message, a_tokens)
		ensure
			not_valid: not is_valid
		end

	reset
			-- Remove any previous error message
		do
			last_error_message := Void
		ensure
			valid: is_valid
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
