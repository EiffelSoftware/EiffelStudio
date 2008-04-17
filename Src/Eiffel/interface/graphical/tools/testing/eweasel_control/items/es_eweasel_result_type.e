indexing
	description: "[
					Test run result type enumeration
					Some helper functions about result type
																]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_RESULT_TYPE

feature -- Enmueration

	default_type: INTEGER is 0
			-- Not run yet

	failed: INTEGER is 1
			-- Failed
			-- This means test has been successfully launched, but the test result not expected.

	passed: INTEGER is 2
			-- Passed

	error: INTEGER is 3
			-- Error
			-- This means test has not been successfully lanuched.
			-- Maybe due to parse error in eWeasel tcf file, etc.

feature -- Query

	is_need_correct (a_type: INTEGER): BOOLEAN is
			-- If `a_type' need to be fixed?
		require
			valid: is_valid (a_type)
		do
			Result := (a_type = failed) or (a_type = error)
		end

	result_to_string (a_value: INTEGER): STRING_GENERAL is
			-- Convert a value to string
		require
			valid: is_valid (a_value)
		do
			inspect
				a_value
			when default_type then
				Result := not_run_yet_string
			when failed then
				Result := failed_string
			when passed then
				Result := passed_string
			when error then
				Result := error_string
			else

			end
		end

feature -- Contract support

	is_valid (a_type: INTEGER): BOOLEAN is
			-- If `a_type' valid?
		do
			Result := 	a_type = default_type or
						a_type = failed or
						a_type = passed or
						a_type = error
		end

feature {NONE} -- Implementation

	not_run_yet_string: STRING_GENERAL is
			-- Not run yet string
		do
			Result := interface_names.t_not_run_yet
		end

	failed_string: STRING_GENERAL is
			-- Failed string
		do
			Result := interface_names.t_failed
		end

	passed_string: STRING_GENERAL is
			-- Passed string
		do
			Result := interface_names.t_passed
		end

	error_string: STRING_GENERAL is
			-- Error string
		do
			Result := interface_names.t_error
		end

	interface_names: INTERFACE_NAMES is
			-- Interface names instance
		local
			l_constants: SHARED_BENCH_NAMES
		do
			create l_constants
			Result := l_constants.names
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
