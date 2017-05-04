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

	application: STRING
			-- The application's location argument
		once
			create Result.make_from_string ((create {ARGUMENTS}).argument (0))
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	application_base: STRING
			-- The application's base location, or the working directory if the base location cannot
			-- be determined.
		local
			l_result: detachable STRING
			l_path: STRING
			i: INTEGER
		once
			l_path := (create {ARGUMENTS}).argument_array [0]
			if l_path /= Void and then not l_path.is_empty then
				i := l_path.last_index_of (operating_environment.directory_separator, l_path.count)
				if i > 0 then
					l_result := l_path.substring (1, i - 1)
				end
			end
			if l_result = Void or else l_result.is_empty then
				l_result := (create {EXECUTION_ENVIRONMENT}).current_working_path.utf_8_name
			end
			create {STRING} Result.make_from_string (l_result)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			no_trailing_separator: Result.item (Result.count) /= operating_environment.directory_separator
			result_exists: (create {DIRECTORY}.make (Result)).exists
		end

	arguments: ARRAY [STRING]
			-- An array of supplied user arguments
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ arguments
			result_contains_attached_items: Result.for_all (agent (ia_item: STRING): BOOLEAN
				local
					l_item: detachable STRING
				do
					l_item := ia_item
					Result := l_item /= Void
				end)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Indicates if there are no supplied arguments
		deferred
		ensure
			not_arguments_is_empty: not Result implies not arguments.is_empty
		end

;note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
