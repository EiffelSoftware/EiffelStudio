note
	description: "Summary description for {ES_ARGUMENTS}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ARGUMENTS

inherit
	ENVIRONMENT_ARGUMENTS
		redefine
			environment_arguments_prepended
		end

feature -- Access

	environment_arguments_prepended: BOOLEAN = True

feature {NONE} -- Implementation

	arguments_program_name: IMMUTABLE_STRING_32
			-- Associated program name
		do
			create Result.make_from_string_8 ("ec")
		ensure
			result_attached: Result /= Void
		end

	arguments_environment_name: IMMUTABLE_STRING_32
			-- Environment variable's name used to extend the command line
		once
			Result := {STRING_32} "ISE_" + arguments_program_name.as_upper + "_FLAGS"
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
