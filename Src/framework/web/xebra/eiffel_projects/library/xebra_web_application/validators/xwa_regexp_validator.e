note
	description: "[
		{XWA_REGEXP_VALIDATOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_REGEXP_VALIDATOR

inherit
	XWA_VALIDATOR

feature -- Intialization

	make
			-- Creation
		do
--			create regexp.make
--			regexp.compile (regular_expression)
		ensure
--			regexp_attached: attached regexp
--			regexp_compiled: attached regexp.is_compiled
		end

feature {NONE} -- Access

--	regexp: RX_PCRE_MATCHER
			-- The compiled regular expression

feature -- Implementation

	validate (a_argument: STRING): BOOLEAN
			-- Validates if `a_argument' is valid
		do
--			Result := regexp.matches (a_argument)
			Result := False -- NOT IMPLEMENTED
		end

	regular_expression: STRING
			-- The regular expression that should be used for the validation
		deferred
		ensure
			result_attached: attached Result
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
