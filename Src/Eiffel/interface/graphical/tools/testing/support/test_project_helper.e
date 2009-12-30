note
	description: "[
		Implementation of {TEST_PROJECT_HELPER_I} used for batch environment.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_PROJECT_HELPER

inherit
	ES_TEST_PROJECT_HELPER
		redefine
			can_compile,
			can_run,
			compile,
			cancel_compilation,
			run
		end

feature -- Status report

	can_compile: BOOLEAN
			-- <Precursor>
		do
			Result := eiffel_project.able_to_compile
		end

	can_run: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Basic operations

	compile
			-- <Precursor>
		do
			eiffel_project.quick_melt
			if eiffel_project.freezing_occurred then
				eiffel_project.call_finish_freezing_and_wait (True)
			end
		end

	cancel_compilation
			-- <Precursor>
		do
			degree_output.request_abort
		end

	run (a_working_directory: detachable STRING; a_arguments: detachable STRING; a_env: detachable HASH_TABLE [STRING_32, STRING_32])
			-- <Precursor>
		do
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
