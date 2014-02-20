note
	description: "[
		A string expander utilizing only environment variables as its source of variable values.
		
		See {STRING_EXPANDER} for details on variable styles and expansion.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XU_STRING_EXPANDER

inherit
	STRING_EXPANDER

feature -- Status report

	use_environment_variables: BOOLEAN
			-- Indicates if environment variables should be used when retrieving environment variables.
		do
			Result := True
		end

feature {NONE} -- Helpers

	environment: ENVIRONMENT_ACCESS
			-- Shared access to {ENVIRONMENT_ACCESS}
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Query

	variable (a_id: READABLE_STRING_8): detachable STRING
			-- <Precursor>
		do
			if attached environment.get_from_application (a_id, "") as l_string then
				Result := l_string.to_string_8
			end
		end

	variable_32 (a_id: READABLE_STRING_32): detachable STRING_32
			-- <Precursor>
		do
			Result := environment.get_from_application (a_id, "")
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
