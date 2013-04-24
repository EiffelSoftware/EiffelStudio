note
	description: "[
			An argument parser's source of arguments.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARGUMENT_SOURCE

feature -- Access

	application: PATH
			-- The application's location argument
		once
			create Result.make_from_string ((create {ARGUMENTS_32}).command_name)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	application_base: PATH
			-- The application's base location, or the working directory if the base location cannot
			-- be determined.
		once
			Result := application.parent
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_exists: (create {DIRECTORY}.make_with_path (Result)).exists
		end

	arguments: ARRAY [IMMUTABLE_STRING_32]
			-- An array of supplied user arguments
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ arguments
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Indicates if there are no supplied arguments
		deferred
		ensure
			not_arguments_is_empty: not Result implies not arguments.is_empty
		end

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
