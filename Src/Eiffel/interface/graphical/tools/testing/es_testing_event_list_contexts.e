indexing
	description: "[
					Context UUID used in event list service
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_EVENT_LIST_CONTEXTS

feature -- Enumeration

	all_test_runs_dialog: !UUID is
			-- Used by {ES_ALL_TEST_RUN_RESULTS_DIALOG}
		once
			create Result.make_from_string ("0BFCC3DB-268C-4DE2-8125-3BC3AB2E2CB0")
		end

	eweasel_result_analyzer: !UUID is
			-- Used by {EWEASEL_RESULT_ANALYZER}
		once
			create Result.make_from_string ("8BC8DAE7-7B87-4116-9CE8-D91A60400C83")
		end

	es_test_case_grid_manager: !UUID is
			-- Used by {ES_TEST_CASE_GRID_MANAGER}
		once
			create Result.make_from_string ("2F589F5C-8B51-4B25-B53E-5284CE8D2459")
		end

	execution_manager: !UUID is
			-- Used by {ES_EWEASEL_EXECUTION_MANAGER}
		once
			create Result.make_from_string ("75B5C239-304C-4AD6-8A72-D748670510B4")
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
